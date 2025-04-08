module dut #(
    parameter ENTRIES = 32,       // Number of entries in the queue
    parameter HAS_FLUSH = 1       // Flush feature enabled if 1
) (
    input clock,
    input reset,
    output io_enq_ready,
    input io_enq_valid,
    input [7:0] io_enq_bits,
    input io_deq_ready,
    output io_deq_valid,
    output [7:0] io_deq_bits,
    output [4:0] io_count,
    input io_flush                // Flush input for clearing the queue
);

    // Internal memory for queue storage
    reg [7:0] ram[ENTRIES-1:0];

    // Pointers for enqueue and dequeue operations
    reg [$clog2(ENTRIES)-1:0] enq_ptr;
    reg [$clog2(ENTRIES)-1:0] deq_ptr;
    reg maybe_full;

    wire ptr_match = (enq_ptr == deq_ptr);

    // Full and empty signals
    wire full = ptr_match && maybe_full;
    wire empty = ptr_match && !maybe_full;

    // Enqueue and dequeue operations
    wire do_enq = io_enq_ready && io_enq_valid;
    wire do_deq = io_deq_valid && io_deq_ready;

    // Logic for io_enq_ready and io_deq_valid
    assign io_enq_ready = !full;
    assign io_deq_valid = !empty;

    // Output the data at dequeue pointer
    assign io_deq_bits = ram[deq_ptr];

    // Calculate the count of stored elements
    wire [4:0] diff = (enq_ptr >= deq_ptr) ? (enq_ptr - deq_ptr) : (ENTRIES + enq_ptr - deq_ptr);
    assign io_count = full ? ENTRIES : diff;

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

            if (do_enq && !do_deq) begin
                maybe_full <= 1;
            end else if (!do_enq && do_deq) begin
                maybe_full <= 0;
            end
            
            // Handle the flush logic if enabled
            if (HAS_FLUSH && io_flush) begin
                enq_ptr <= 0;
                deq_ptr <= 0;
                maybe_full <= 0;
            end
        end
    end

endmodule
