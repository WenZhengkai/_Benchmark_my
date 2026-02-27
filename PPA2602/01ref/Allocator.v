
module Allocator #(
  parameter integer NWAYS = 16,
  parameter integer TAGSZ = 32,
  parameter integer L     = $clog2(NWAYS)
)(
  input  wire [TAGSZ-1:0] s1_req_rmeta [0:NWAYS-1][0:NWAYS-1],
  input  wire [TAGSZ-1:0] s1_req_tag,
  input  wire [NWAYS-1:0] s1_hits,
  output reg  [L-1:0]     s1_meta_write_way
);

  // ----------------------------
  // PriorityEncoder on hits:
  // Chisel used PriorityEncoder on (hits OR-reduced as UInts),
  // which returns the lowest index with a '1'.
  // ----------------------------
  reg [L-1:0] hit_way;
  integer i;

  always @* begin
    hit_way = {L{1'b0}};
    for (i = 0; i < NWAYS; i = i + 1) begin
      if (s1_hits[i]) begin
        hit_way = i[L-1:0];
        disable hit_loop;
      end
    end
  end

  // Named block to allow "disable" (synthesizable in common tools)
  always @* begin : hit_loop
    // dummy, real work is above; some tools require the disable target block
  end

  wire any_hit = |s1_hits;

  // ----------------------------
  // alloc_way computation:
  // Chisel builds a big vector:
  //   Cat( VecInit( s1_req_rmeta.map(w => Cat(w.map(_.tag))) ).asUInt,
  //        s1_req_tag )
  // Then splits into L-bit chunks and XOR-reduces them.
  //
  // For NWAYS=16, TAGSZ=32:
  // total width = 16*16*32 + 32 = 8224
  // number of L-bit chunks = ceil(8224/4) = 2056
  //
  // We'll implement the same XOR over L-bit slices by iterating bits directly
  // in a deterministic order matching the concatenation:
  // Highest bits: w=0 block, inside that i=0..15, then w=1 block, ... w=15 block,
  // finally lowest TAGSZ bits are s1_req_tag.
  //
  // alloc_way[k] is XOR of every bit in the big vector whose position mod L == k
  // (with position 0 being LSB of the big vector).
  // ----------------------------
  reg [L-1:0] alloc_way;
  integer w, j, b;
  integer pos; // bit position in the conceptual concatenated vector (LSB=0)

  always @* begin
    alloc_way = {L{1'b0}};
    pos = 0;

    // First, LSB portion is s1_req_tag (because Cat(..., s1_req_tag) puts tag at LSB)
    for (b = 0; b < TAGSZ; b = b + 1) begin
      alloc_way[pos % L] = alloc_way[pos % L] ^ s1_req_tag[b];
      pos = pos + 1;
    end

    // Then rmeta blocks above it. In the Chisel Cat, the last element before s1_req_tag
    // becomes just above tag. That corresponds to w=NWAYS-1 as the last concatenated group.
    // We must append tags in the same "above-LSB" order:
    // iterate w from NWAYS-1 down to 0, and within each w iterate i from NWAYS-1 down to 0,
    // because Cat(a,b,c) makes 'a' the highest bits.
    for (w = NWAYS-1; w >= 0; w = w - 1) begin
      for (j = NWAYS-1; j >= 0; j = j - 1) begin
        for (b = 0; b < TAGSZ; b = b + 1) begin
          alloc_way[pos % L] = alloc_way[pos % L] ^ s1_req_rmeta[w][j][b];
          pos = pos + 1;
        end
      end
    end
  end

  // Final select: hit -> hit_way, else -> alloc_way
  always @* begin
    if (any_hit)
      s1_meta_write_way = hit_way;
    else
      s1_meta_write_way = alloc_way;
  end

endmodule
