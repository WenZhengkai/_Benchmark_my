module dut(
    input        clock,
    input        reset,
    output       io_enq_ready,
    input        io_enq_valid,
    input  [7:0] io_enq_bits,
    output       io_deq_valid,
    input        io_deq_credit,
    output [7:0] io_deq_bits,
    output [2:0] io_curCredit
);

    // Parameters
    localparam MAX_CREDIT = 3'b111; // Maximum credit value (7)

    // Internal registers
    reg [7:0] dataOut;
    reg validOut;
    reg [2:0] curCredit;
    reg icredit;

    // Assign output signals
    assign io_enq_ready = (curCredit > 0);
    assign io_deq_valid = validOut;
    assign io_deq_bits = dataOut;
    assign io_curCredit = curCredit;

    // Process logic (sequential)
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= MAX_CREDIT; // Initialize credits
            validOut <= 0;
            dataOut <= 8'b0;
            icredit <= 0;
        end else begin
            icredit <= io_deq_credit; // Latch the dequeue credit signal

            // Handle credit increment/decrement
            if (icredit && !io_enq_valid) begin
                // If a credit is received and no enqueuing data, increment curCredit
                if (curCredit < MAX_CREDIT)
                    curCredit <= curCredit + 1;
            end else if (!icredit && io_enq_valid && io_enq_ready) begin
                // If data is enqueued and no credit, decrement curCredit
                curCredit <= curCredit - 1;
            end

            // Data register and valid register updates
            if (io_enq_valid && io_enq_ready) begin
                dataOut <= io_enq_bits; // Capture enqueued data
                validOut <= 1; // Set data valid
            end else if (io_deq_valid && !io_deq_credit) begin
                validOut <= 0; // Clear valid flag if dequeued
            end
        end
    end
endmodule
