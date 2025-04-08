module dut(
    input        clock,
    input        reset,
    output       io_enq_ready,
    input        io_enq_valid,
    input  [7:0] io_enq_bits,
    input        io_deq_ready,
    output       io_deq_valid,
    output [7:0] io_deq_bits
);

    // Internal registers
    reg pValid;
    reg [7:0] pData;

    // Combinational logic for io_deq_valid and io_enq_ready
    assign io_deq_valid = pValid;
    assign io_enq_ready = ~pValid;
    assign io_deq_bits = pData;

    // Sequential logic to manage pValid and pData
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset the state
            pValid <= 1'b0;
            pData <= 8'b0;
        end else begin
            // Logic for handling data capture and release
            if (io_enq_valid && io_enq_ready) begin
                // Capture new data when there's valid input and we are ready to accept
                pData <= io_enq_bits;
                pValid <= 1'b1;
            end else if (io_deq_ready && pValid) begin
                // Release data when the deq is ready and pValid is true
                pValid <= 1'b0;
            end
            // Hold current state when neither enroll nor dequeue conditions are met
        end
    end

endmodule
