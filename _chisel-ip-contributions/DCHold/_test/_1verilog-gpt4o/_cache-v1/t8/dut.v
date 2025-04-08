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
    reg        pValid;
    reg [7:0]  pData;

    // Reset logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pValid <= 1'b0;
        end else begin
            // Handle data storage and flow control
            if (io_enq_valid && !pValid) begin
                // Accept new data
                pData <= io_enq_bits;
                pValid <= 1'b1;
            end else if (io_deq_ready && pValid) begin
                // Clear data when dequeued
                pValid <= 1'b0;
            end
        end
    end

    // Output assignments
    assign io_enq_ready = !pValid;  // Ready to accept new data when not holding anything
    assign io_deq_valid = pValid;   // Valid data available if pValid is set
    assign io_deq_bits = pData;     // Output the held data

endmodule
