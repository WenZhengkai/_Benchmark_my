module dut #(
    parameter integer DATA_WIDTH = 8,
    parameter integer ADDR_WIDTH = 5, // Supports up to 2^5 = 32 entries
    parameter integer ENTRIES = 1 << ADDR_WIDTH,
    parameter boolean HAS_FLUSH = 0
)(
    input wire clock,
    input wire reset,
    output wire io_enq_ready,
    input wire io_enq_valid,
    input wire [DATA_WIDTH-1:0] io_enq_bits,
    input wire io_deq_ready,
    output wire io_deq_valid,
    output wire [DATA_WIDTH-1:0] io_deq_bits,
    output wire [ADDR_WIDTH:0] io_count
    `ifdef HAS_FLUSH
    , input wire io_flush // optional and only available if HAS_FLUSH is true
    `endif
);

    // Memory for Storage
    reg [DATA_WIDTH-1:0] ram[0:ENTRIES-1];
    reg [ADDR_WIDTH-1:0] enq_ptr = 0;
    reg [ADDR_WIDTH-1:0] deq_ptr = 0;
    reg maybe_full = 0;

    // Pointer Management Logic
    wire ptr_match = (enq_ptr == deq_ptr);

    // Full/Empty Logic
    wire full = ptr_match && maybe_full;
    wire empty = ptr_match && ~maybe_full;

    // Enqueue and Dequeue Conditions
    wire do_enq = io_enq_ready && io_enq_valid;
    wire do_deq = io_deq_ready && io_deq_valid;

    // Count Calculation
    wire [ADDR_WIDTH:0] diff = enq_ptr - deq_ptr;
    assign io_count = full ? ENTRIES : diff;

    // Output Signals
    assign io_enq_ready = ~full;
    assign io_deq_valid = ~empty;
    assign io_deq_bits = ram[deq_ptr];

    // Sequential Logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            enq_ptr <= 0;
            deq_ptr <= 0;
            maybe_full <= 0;
        end else begin
            if (do_enq) begin
                ram[enq_ptr] <= io_enq_bits;
                enq_ptr <= enq_ptr + 1;
                if (enq_ptr == deq_ptr)
                    maybe_full <= 1;
            end
            
            if (do_deq) begin
                deq_ptr <= deq_ptr + 1;
                if (enq_ptr == deq_ptr + 1)
                    maybe_full <= 0;
            end

            `ifdef HAS_FLUSH
            if (HAS_FLUSH && io_flush) begin
                enq_ptr <= 0;
                deq_ptr <= 0;
                maybe_full <= 0;
            end
            `endif
        end
    end

endmodule
