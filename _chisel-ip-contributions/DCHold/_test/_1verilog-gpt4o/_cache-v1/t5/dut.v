module dut (
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

    // Output assignments
    assign io_deq_valid = pValid;
    assign io_deq_bits = pData;
    assign io_enq_ready = ~pValid;  // Ready to accept new data if no valid data being held

    // Sequential logic for handling the data holding mechanism
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset all internal states
            pValid <= 1'b0;
            pData <= 8'b0;
        end else begin
            if (io_deq_ready && pValid) begin
                // If the data is being dequeued successfully, clear the holding register
                pValid <= 1'b0;
            end

            if (io_enq_valid && io_enq_ready) begin
                // Capture new data into the holding register
                pData <= io_enq_bits;
                pValid <= 1'b1;
            end
        end
    end

endmodule
