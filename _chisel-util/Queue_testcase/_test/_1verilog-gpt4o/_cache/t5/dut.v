module dut #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 32,
    parameter HAS_FLUSH = 0
)(
    input wire                     clock,
    input wire                     reset,
    output wire                    io_enq_ready,
    input wire                     io_enq_valid,
    input wire [DATA_WIDTH-1:0]    io_enq_bits,
    input wire                     io_deq_ready,
    output wire                    io_deq_valid,
    output wire [DATA_WIDTH-1:0]   io_deq_bits,
    output wire [$clog2(DEPTH):0]  io_count
);

    // Memory for storage
    reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

    // Pointers
    reg [$clog2(DEPTH)-1:0] enq_ptr;
    reg [$clog2(DEPTH)-1:0] deq_ptr;
    reg maybe_full;

    // Output signals
    wire ptr_match = (enq_ptr == deq_ptr);
    wire full = ptr_match && maybe_full;
    wire empty = ptr_match && !maybe_full;

    assign io_enq_ready = !full;
    assign io_deq_valid = !empty;

    // Calculate count
    wire [$clog2(DEPTH):0] diff = (enq_ptr >= deq_ptr) ? (enq_ptr - deq_ptr) : (DEPTH + enq_ptr - deq_ptr);
    assign io_count = full ? DEPTH : diff;

    // Enqueue and Dequeue logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            enq_ptr <= 0;
            deq_ptr <= 0;
            maybe_full <= 0;
        end else begin
            if (io_enq_valid && io_enq_ready) begin
                ram[enq_ptr] <= io_enq_bits;
                enq_ptr <= enq_ptr + 1;
                if (enq_ptr + 1 == deq_ptr) begin
                    maybe_full <= 1;
                end
            end

            if (io_deq_ready && io_deq_valid) begin
                deq_ptr <= deq_ptr + 1;
                if (deq_ptr + 1 == enq_ptr) begin
                    maybe_full <= 0;
                end
            end

            // Handle flush if enabled
            if (HAS_FLUSH && io_flush) begin
                enq_ptr <= 0;
                deq_ptr <= 0;
                maybe_full <= 0;
            end
        end
    end

    assign io_deq_bits = ram[deq_ptr];

endmodule
