module dut (
    input          clock,
    input          reset,
    output         io_enq_ready,
    input          io_enq_valid,
    input   [7:0]  io_enq_bits,
    output         io_deq_valid,
    input          io_deq_credit,
    output  [7:0]  io_deq_bits,
    output  [2:0]  io_curCredit
);

    // Parameters
    localparam maxCredit = 3'b111;  // Example: Maximum credits available
    
    // Internal registers
    reg [2:0] curCredit;
    reg       icredit;
    reg [7:0] dataOut;
    reg       validOut;

    // Assigning outputs
    assign io_curCredit   = curCredit;
    assign io_enq_ready   = (curCredit > 0);
    assign io_deq_valid   = validOut;
    assign io_deq_bits    = dataOut;

    // Credit and flow control logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= maxCredit;
            validOut  <= 1'b0;
        end else begin
            icredit <= io_deq_credit;
            
            if (io_enq_valid && io_enq_ready) begin
                // Enqueuing data
                dataOut   <= io_enq_bits;
                validOut  <= 1'b1;
                if (!icredit) begin
                    // Debit a credit when sending data
                    curCredit <= curCredit - 1;
                end
            end else if (icredit && !io_enq_ready) begin
                // Credit received without enqueue
                curCredit <= curCredit + 1;
            end
            
            if (icredit) begin
                validOut <= 1'b0; // Reset validOut once credit received for sent data
            end
        end
    end

endmodule
