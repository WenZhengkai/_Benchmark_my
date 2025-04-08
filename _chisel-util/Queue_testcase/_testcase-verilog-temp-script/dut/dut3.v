module dut #(
    parameter WIDTH = 8,      // Width of the data
    parameter DEPTH = 32,     // Number of entries in the queue
    parameter HAS_FLUSH = 0   // Include flush capability
) (
    input               clock,
    input               reset,
    output              io_enq_ready,
    input               io_enq_valid,
    input  [WIDTH-1:0]  io_enq_bits,
    input               io_deq_ready,
    output              io_deq_valid,
    output [WIDTH-1:0]  io_deq_bits,
    output [4:0]        io_count,
    input               io_flush           // Only if HAS_FLUSH is set
);

    reg [WIDTH-1:0] ram[DEPTH-1:0];
    reg [$clog2(DEPTH)-1:0] enq_ptr;
    reg [$clog2(DEPTH)-1:0] deq_ptr;
    reg maybe_full;

    wire ptr_match = (enq_ptr == deq_ptr);
    wire full = ptr_match && maybe_full;
    wire empty = ptr_match && !maybe_full;

    wire do_enq = io_enq_ready && io_enq_valid;
    wire do_deq = io_deq_ready && io_deq_valid;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
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

            if (do_enq != do_deq) begin
                maybe_full <= do_enq;
            end

            if (HAS_FLUSH && io_flush) begin
                enq_ptr <= 0;
                deq_ptr <= 0;
                maybe_full <= 0;
            end
        end
    end

    assign io_enq_ready = !full;
    assign io_deq_valid = !empty;
    assign io_deq_bits  = ram[deq_ptr];

    wire [4:0] diff = enq_ptr >= deq_ptr ? enq_ptr - deq_ptr : (DEPTH + enq_ptr) - deq_ptr;
    assign io_count = full ? DEPTH : diff;

endmodule
