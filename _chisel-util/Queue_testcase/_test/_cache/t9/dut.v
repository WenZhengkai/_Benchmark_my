module dut #(
    parameter DATA_WIDTH = 8,
    parameter ENTRIES = 16,
    parameter HAS_FLUSH = 1
)(
    input              clock,
    input              reset,
    output             io_enq_ready,
    input              io_enq_valid,
    input  [DATA_WIDTH-1:0] io_enq_bits,
    input              io_deq_ready,
    output             io_deq_valid,
    output [DATA_WIDTH-1:0] io_deq_bits,
    output [4:0]       io_count,
    input              io_flush // Only effective if HAS_FLUSH is 1
);

    // Memory for storing data entries
    reg [DATA_WIDTH-1:0] ram [0:ENTRIES-1];
    
    // Pointers for enqueue and dequeue
    reg [$clog2(ENTRIES)-1:0] enq_ptr = 0;
    reg [$clog2(ENTRIES)-1:0] deq_ptr = 0;
    
    // Full/Empty logic auxiliary register
    reg maybe_full = 0;

    // Pointer match signal
    wire ptr_match = (enq_ptr == deq_ptr);
    
    // Full and empty signals
    wire full = ptr_match && maybe_full;
    wire empty = ptr_match && !maybe_full;
    
    // Enqueue and dequeue condition flags
    wire do_enq = io_enq_ready && io_enq_valid;
    wire do_deq = io_deq_ready && io_deq_valid;
    
    // Calculate the count of elements in the queue
    wire [4:0] diff = enq_ptr - deq_ptr;
    assign io_count = full ? ENTRIES : (enq_ptr >= deq_ptr ? diff : ENTRIES + diff);
    
    // Logic for enqueue ready and dequeue valid flags
    assign io_enq_ready = !full;
    assign io_deq_valid = !empty;

    // Output data from the queue
    assign io_deq_bits = ram[deq_ptr];
    
    // Enqueue operation
    always @(posedge clock) begin
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
            if (do_enq && !do_deq) begin
                maybe_full <= 1;
            end else if (!do_enq && do_deq) begin
                maybe_full <= 0;
            end

            // Flush logic when enabled
            if (HAS_FLUSH && io_flush) begin
                enq_ptr <= 0;
                deq_ptr <= 0;
                maybe_full <= 0;
            end
        end
    end
    
endmodule
