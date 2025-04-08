module dut #(parameter ENTRIES = 32, parameter HAS_FLUSH = 1) (
    input              clock,
    input              reset,
    output reg         io_enq_ready,
    input              io_enq_valid,
    input       [7:0]  io_enq_bits,
    input              io_deq_ready,
    output reg         io_deq_valid,
    output reg  [7:0]  io_deq_bits,
    output reg  [4:0]  io_count,
    input              io_flush      // Input for flush, only if HAS_FLUSH is true
);

    reg [7:0] ram [0:ENTRIES-1];    // Memory for storage
    reg [4:0] enq_ptr, deq_ptr;     // Enqueue and Dequeue pointers
    reg       maybe_full;           // Indicates if the queue is maybe full

    wire ptr_match = (enq_ptr == deq_ptr);
    wire full      = ptr_match && maybe_full;
    wire empty     = ptr_match && !maybe_full;

    // Enqueue and Dequeue operations
    wire do_enq = io_enq_ready && io_enq_valid;
    wire do_deq = io_deq_ready && io_deq_valid;

    // Queue Output Calculations
    always @(*) begin
        io_enq_ready = !full;
        io_deq_valid = !empty;
    end

    // Enqueue Process
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            enq_ptr <= 0;
            maybe_full <= 0;
        end else if (do_enq) begin
            ram[enq_ptr] <= io_enq_bits;
            enq_ptr <= enq_ptr + 1;
            if (enq_ptr == ENTRIES - 1)
                maybe_full <= 1;
        end
    end

    // Dequeue Process
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            deq_ptr <= 0;
            // maybe_full remain reset in enqueue block
        end else if (do_deq) begin
            io_deq_bits <= ram[deq_ptr];
            deq_ptr <= deq_ptr + 1;
            if (!ptr_match)
                maybe_full <= 0;
        end
    end

    // Count Calculation
    always @(*) begin
        if (full) begin
            io_count = ENTRIES;
        end else if (enq_ptr >= deq_ptr) begin
            io_count = enq_ptr - deq_ptr;
        end else begin
            io_count = ENTRIES + enq_ptr - deq_ptr;
        end
    end

    // Optional Flush Logic
    generate
        if (HAS_FLUSH) begin
            always @(posedge clock or posedge reset) begin
                if (reset) begin
                    enq_ptr <= 0;
                    deq_ptr <= 0;
                    maybe_full <= 0;
                end else if (io_flush) begin
                    enq_ptr <= 0;
                    deq_ptr <= 0;
                    maybe_full <= 0;
                end
            end
        end
    endgenerate

endmodule
