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

    // Max credit indicates maximum allowable credits
    localparam [2:0] maxCredit = 3'b111; 

    reg [2:0] curCredit;
    reg [7:0] dataOut;
    reg       validOut;
    reg       icredit;

    // Initialize or reset logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= maxCredit;
            icredit   <= 1'b0;
            dataOut   <= 8'b0;
            validOut  <= 1'b0;
        end else begin
            icredit <= io_deq_credit;
            
            // Handle credit increment and decrement
            if (icredit && !io_enq_valid) begin
                // Credit received, not enqueuing -- increment curCredit
                if (curCredit < maxCredit) begin
                    curCredit <= curCredit + 1;
                end
            end else if (!icredit && io_enq_ready && io_enq_valid) begin
                // Data sent, decrement curCredit
                if (curCredit > 0) begin
                    curCredit <= curCredit - 1;
                end
            end

            // Enqueue operation - uses two primary operations
            if (io_enq_ready && io_enq_valid) begin
                dataOut  <= io_enq_bits; // Capture data to send out
                validOut <= 1'b1;        // Valid signal activated
            end else if (icredit) begin
                validOut <= 1'b0;        // Make output invalid when credit is received
            end
        end
    end

    // Output assignments
    assign io_enq_ready = (curCredit > 0);
    assign io_deq_valid = validOut;
    assign io_deq_bits = dataOut;
    assign io_curCredit = curCredit;

endmodule
