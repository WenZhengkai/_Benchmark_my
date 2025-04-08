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

    reg [2:0] curCredit;
    reg [7:0] dataOut;
    reg validOut;
    reg icredit;

    // Internal Logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= 3'b111; // Assuming max credit is 7 (can be adjusted)
            icredit   <= 1'b0;
            validOut  <= 1'b0;
        end else begin
            icredit <= io_deq_credit;

            // Update the curCredit based on conditions
            if (icredit && !io_enq_valid) begin
                curCredit <= curCredit + 3'd1; // Increment credit
            end else if (!icredit && io_enq_valid && io_enq_ready) begin
                curCredit <= curCredit - 3'd1; // Decrement credit
            end

            // Update output registers
            if (io_enq_valid && io_enq_ready) begin
                dataOut  <= io_enq_bits;  // Load new data
                validOut <= 1'b1;         // Set valid flag
            end else begin
                validOut <= 1'b0;         // Clear valid flag if no transaction
            end
        end
    end

    // Output assignments
    assign io_enq_ready = (curCredit > 3'd0); // Ready when there is credit
    assign io_deq_valid = validOut;           // Valid output if there's valid data
    assign io_deq_bits  = dataOut;            // Output the data
    assign io_curCredit = curCredit;          // Output the current credit
endmodule
