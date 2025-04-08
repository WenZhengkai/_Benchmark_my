module dut #(parameter ENTRIES = 16, parameter HAS_FLUSH = 0) (
    input            clock,
    input            reset,
    output           io_enq_ready,
    input            io_enq_valid,
    input  [7:0]     io_enq_bits,
    input            io_deq_ready,
    output           io_deq_valid,
    output [7:0]     io_deq_bits,
    output [4:0]     io_count,
    input            io_flush // Only active when HAS_FLUSH is set
);

    reg [7:0] ram [0:ENTRIES-1]; // Memory for storage
    reg [$clog2(ENTRIES):0] enq_ptr, deq_ptr;
    reg maybe_full;
    wire ptr_match = (enq_ptr == deq_ptr);
    
    // Determine full and empty conditions
    wire full  = ptr_match && maybe_full;
    wire empty = ptr_match && !maybe_full;
    
    // Enqueue/dequeue logic
    wire do_enq = io_enq_ready & io_enq_valid;
    wire do_deq = io_deq_ready & io_deq_valid;
    
    // Determine the count
    wire [4:0] diff = (enq_ptr >= deq_ptr) ? (enq_ptr - deq_ptr) : (ENTRIES + enq_ptr - deq_ptr);
    wire [4:0] count = full ? ENTRIES : diff;
    assign io_count = count;

    // Calculate output signals
    assign io_enq_ready = !full;
    assign io_deq_valid = !empty;
    assign io_deq_bits = ram[deq_ptr];
    
    // Sequential logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            enq_ptr <= 0;
            deq_ptr <= 0;
            maybe_full <= 0;
        end else begin
            if (HAS_FLUSH && io_flush) begin
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
                    maybe_full <= (enq_ptr + 1 == deq_ptr + ENTRIES);
                end else if (!do_enq && do_deq) begin
                    maybe_full <= (enq_ptr != deq_ptr + ENTRIES);
                end
            end
        end
    end
endmodule
