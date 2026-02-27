
module Allocator #(
  parameter int NWAYS = 16,
  parameter int TAGSZ = 32
)(
  input  logic [NWAYS-1:0][NWAYS-1:0][TAGSZ-1:0] s1_req_rmeta,
  input  logic [TAGSZ-1:0]                        s1_req_tag,
  input  logic [NWAYS-1:0]                        s1_hits,
  output logic [$clog2(NWAYS)-1:0]                s1_meta_write_way
);

  localparam int L          = $clog2(NWAYS);                 // =4
  localparam int RMETA_W    = NWAYS*NWAYS*TAGSZ + TAGSZ;      // 16*16*32 + 32 = 8224
  localparam int RMETAS_W   = RMETA_W + 1;                    // +1 for the extra tag slice in Chisel => 8225
  localparam int NCHUNKS    = (RMETAS_W + L - 1) / L;         // ceil(8225/4)=2057

  // Build r_metas = { Cat(VecInit(io.s1_req_rmeta.map{w => Cat(w.map(_.tag)) })), s1_req_tag }
  // then append io.s1_req_tag(tagSz-1,0) again (as in the Chisel code)
  logic [RMETAS_W-1:0] r_metas;

  // Priority encoder result (lowest index set wins, like Chisel PriorityEncoder on a Vec)
  logic [$clog2(NWAYS)-1:0] hit_way;
  logic                    any_hit;

  // alloc_way from XOR of L-bit chunks (last chunk may be smaller; Chisel would yield a smaller UInt)
  logic [L-1:0] alloc_way;

  integer i, j, k;

  // Pack r_metas deterministically:
  // We follow the same ordering as:
  //   io.s1_req_rmeta.map { w => Cat(w.map(_.tag)) }
  // where Cat over w.map(_.tag) places higher indices on the left.
  // Then Cat over the outer Vec similarly places higher outer indices on the left.
  // Finally append s1_req_tag at LSB, and append s1_req_tag again slice(tagSz-1,0).
  always_comb begin
    r_metas = '0;

    // Fill the upper 8192 bits with rmeta tags, and the next 32 bits with s1_req_tag,
    // and the LSB 1 bit with s1_req_tag[0] to match the Chisel "+ io.s1_req_tag(tagSz-1,0)"
    // after already including it in the first Cat(..., io.s1_req_tag).
    //
    // Layout:
    //   r_metas[RMETAS_W-1 : 33]  = concatenated rmeta tags (8192 bits)
    //   r_metas[32 : 1]           = s1_req_tag[31:0] (32 bits)
    //   r_metas[0]                = s1_req_tag[0] (the extra 1 bit due to the second Cat)
    //
    // Concatenated rmeta tags ordering equivalent to nested Cat:
    //   outer idx descending, inner idx descending.
    k = RMETAS_W-1;
    // Place rmeta tags (8192 bits)
    for (i = NWAYS-1; i >= 0; i--) begin
      for (j = NWAYS-1; j >= 0; j--) begin
        r_metas[k -: TAGSZ] = s1_req_rmeta[i][j];
        k -= TAGSZ;
      end
    end

    // After 8192 bits, k should be at 32
    // Place s1_req_tag into [32:1]
    r_metas[32:1] = s1_req_tag;

    // Extra appended bit at [0]
    r_metas[0] = s1_req_tag[0];
  end

  // any_hit
  always_comb begin
    any_hit = |s1_hits;
  end

  // PriorityEncoder: lowest index wins
  always_comb begin
    hit_way = '0;
    for (i = 0; i < NWAYS; i++) begin
      if (s1_hits[i]) begin
        hit_way = i[$clog2(NWAYS)-1:0];
        break;
      end
    end
  end

  // XOR reduce over chunks of size L, with last chunk potentially shorter.
  // In Chisel, the last chunk is 1 bit here; XOR with a 4-bit value will width-extend that 1-bit.
  always_comb begin
    alloc_way = '0;
    for (i = 0; i < NCHUNKS; i++) begin
      int lo, hi, w;
      logic [L-1:0] chunk;

      lo = i*L;
      hi = (i+1)*L - 1;
      if (hi >= RMETAS_W) hi = RMETAS_W-1;
      w  = hi - lo + 1; // 1..L

      chunk = '0;
      chunk[w-1:0] = r_metas[hi:lo]; // pack into L bits (LSBs), zero-extend
      alloc_way ^= chunk;
    end
  end

  // Output select: if hit use hit_way else alloc_way
  always_comb begin
    if (any_hit)
      s1_meta_write_way = hit_way;
    else
      s1_meta_write_way = alloc_way;
  end

endmodule

