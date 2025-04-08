module dut (
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

    // Parameters for maximum credit value
    localparam integer maxCredit = 7;  // Assuming 3-bit credit for example

    // Internal registers
    reg [2:0] curCredit;     // Current available credits
    reg [7:0] dataOut;       // Data to be dequeued
    reg       validOut;      // Valid register for the dequeued data
    reg       icredit;       // Latched status of the dequeue credit signal

    // Initialize registers
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= maxCredit;  // Initialize the credit counter to maxCredit
            icredit <= 0;
            dataOut <= 8'h00;
            validOut <= 0;
        end else begin
            // Latch io_deq_credit signal
            icredit <= io_deq_credit;
            
            // Update current credit
            if (icredit && !io_enq_valid) begin
                // Only increment credit if icredit is high and no enqueue operation
                if (curCredit < maxCredit) begin
                    curCredit <= curCredit + 1;
                end
            end else if (!icredit && io_enq_valid && io_enq_ready) begin
                // Decrement credit when data is enqueued
                curCredit <= curCredit - 1;
            end

            // Handle the data out and valid signal
            if (io_enq_valid && io_enq_ready) begin
                dataOut <= io_enq_bits;
                validOut <= 1;
            end else if (io_deq_credit) begin
                validOut <= 0;
            end
        end
    end

    // Output assignments
    assign io_enq_ready = (curCredit > 0);  // Ready if credit is available
    assign io_deq_valid = validOut;         // Valid when we have valid data out
    assign io_deq_bits = dataOut;           // Data to be dequeued
    assign io_curCredit = curCredit;        // Current credit value

endmodule
