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
    reg icredit;
    reg [7:0] dataOut;
    reg validOut;

    // Assign the current credit to the output
    assign io_curCredit = curCredit;

    // io.enq.ready is high when curCredit is greater than 0
    assign io_enq_ready = (curCredit > 0);
    
    // For data dequeue, valid is the same as validOut register
    assign io_deq_valid = validOut;
    assign io_deq_bits = dataOut;

    // Handle credit reception and enqueue operations
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            curCredit <= 3'd7; // Assuming maxCredit is 7 (for a 3-bit counter)
            icredit <= 1'b0;
            validOut <= 1'b0;
        end else begin
            // Latch the credit signal
            icredit <= io_deq_credit;
            
            // Handle credit increment / decrement
            if (icredit && !validOut) begin
                curCredit <= curCredit + 1; // Increment credit when a credit is received
            end else if (io_enq_ready && io_enq_valid) begin
                curCredit <= curCredit - 1; // Decrement credit when data is enqueued
                dataOut <= io_enq_bits;     // Latch the data bits into the dataOut register
                validOut <= 1'b1;           // Set validOut since we're enqueuing data
            end
            
            // Reset validOut when data has been dequeued
            if (validOut && io_deq_credit) begin
                validOut <= 1'b0;
            end
        end
    end

endmodule
