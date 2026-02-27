module dut #(
    parameter integer ENTRIES = 16, // Number of entries in the queue
    parameter logic HAS_FLUSH = 1   // Enable/disable flush functionality
)(
    input wire clock,
    input wire reset,
    output wire io_enq_ready,
    input wire io_enq_valid,
    input wire [7:0] io_enq_bits,
    input wire io_deq_ready,
    output wire io_deq_valid,
    output wire [7:0] io_deq_bits,
    output wire [4:0] io_count
);

  reg [7:0] ram [0:ENTRIES-1]; // Memory for storage
  reg [clog2(ENTRIES)-1:0] enq_ptr; // Enqueue pointer
  reg [clog2(ENTRIES)-1:0] deq_ptr; // Dequeue pointer
  reg maybe_full; // Indicates the fullness state when pointers match

  // Enqueue and Dequeue operations
  wire ptr_match = (enq_ptr == deq_ptr);
  wire full = ptr_match && maybe_full;
  wire empty = ptr_match && !maybe_full;
  
  assign io_enq_ready = !full;
  assign io_deq_valid = !empty;
  assign io_deq_bits = ram[deq_ptr];

  // Compute the queue count
  wire [clog2(ENTRIES):0] diff = enq_ptr >= deq_ptr ? 
                                  enq_ptr - deq_ptr : 
                                  ENTRIES + enq_ptr - deq_ptr;
  assign io_count = full ? ENTRIES : diff;

  // Enqueue and Dequeue conditions
  wire do_enq = io_enq_valid && io_enq_ready;
  wire do_deq = io_deq_valid && io_deq_ready;

  // Handle Flush mechanism
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      enq_ptr <= 0;
      deq_ptr <= 0;
      maybe_full <= 0;
    end else begin
      if (HAS_FLUSH && io_enq_ready && io_deq_valid) begin
        enq_ptr <= 0;
        deq_ptr <= 0;
        maybe_full <= 0;
      end else begin
        if (do_enq) begin
          ram[enq_ptr] <= io_enq_bits;
          enq_ptr <= enq_ptr + 1;
        end

        if (do_deq) begin
          deq_ptr <= deq_ptr + 1;
        end

        if (do_enq && !do_deq) begin
          maybe_full <= 1;
        end else if (!do_enq && do_deq) begin
          maybe_full <= 0;
        end
      end
    end
  end

  // Function to calculate log base 2
  function integer clog2(input integer bit_depth);
    begin
      for (clog2 = 0; bit_depth > 1; bit_depth = bit_depth >> 1) begin
        clog2 = clog2 + 1;
      end
    end
  endfunction

endmodule
