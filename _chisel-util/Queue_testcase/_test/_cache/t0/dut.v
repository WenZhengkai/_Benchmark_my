module dut #(
    parameter ENTRIES = 16,   // Number of FIFO entries
    parameter HAS_FLUSH = 1   // Enable flush if set to 1
)(
    input              clock,
    input              reset,
    output             io_enq_ready,
    input              io_enq_valid,
    input      [7:0]   io_enq_bits,
    input              io_deq_ready,
    output             io_deq_valid,
    output reg [7:0]   io_deq_bits,
    output reg [4:0]   io_count,
    input              io_flush             // Flush control signal (Only if HAS_FLUSH is true)
);

    reg [7:0] ram [0:ENTRIES-1];           // Memory for storage
    reg [4:0] enq_ptr, deq_ptr;            // Pointers
    reg maybe_full;                        // Full marker

    wire ptr_match = (enq_ptr == deq_ptr); // Pointer matching
    wire empty = ptr_match & ~maybe_full;
    wire full = ptr_match & maybe_full;

    wire [4:0] diff = enq_ptr >= deq_ptr ? (enq_ptr - deq_ptr) : ((ENTRIES + enq_ptr) - deq_ptr);
    
    assign io_enq_ready = ~full;
    assign io_deq_valid = ~empty;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            enq_ptr <= 0;
            deq_ptr <= 0;
            maybe_full <= 0;
            io_deq_bits <= 0;
            io_count <= 0;
        end else begin
            if (io_enq_ready && io_enq_valid) begin
                ram[enq_ptr] <= io_enq_bits;
                enq_ptr <= enq_ptr + 1;
                if (enq_ptr == (ENTRIES-1))
                    enq_ptr <= 0;
            end

            if (io_deq_ready && io_deq_valid) begin
                io_deq_bits <= ram[deq_ptr];
                deq_ptr <= deq_ptr + 1;
                if (deq_ptr == (ENTRIES-1))
                    deq_ptr <= 0;
            end

            if (io_enq_ready && io_enq_valid && ~io_deq_ready || ~io_deq_valid) begin
                maybe_full <= 1;
            end else if (~io_enq_valid && io_deq_ready && io_deq_valid) begin
                maybe_full <= 0;
            end

            if (HAS_FLUSH && io_flush) begin
                enq_ptr <= 0;
                deq_ptr <= 0;
                maybe_full <= 0;
            end

            io_count <= full ? ENTRIES : diff;
        end
    end
endmodule
