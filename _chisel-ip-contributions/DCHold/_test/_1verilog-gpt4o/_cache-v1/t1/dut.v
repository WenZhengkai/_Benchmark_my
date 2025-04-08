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

    // Internal registers for holding the state and data
    reg pValid;
    reg [7:0] pData;

    // Output assignments
    assign io_deq_valid = pValid;
    assign io_deq_bits  = pData;

    // io_enq_ready is true when no data is held, indicating readiness to accept new data
    assign io_enq_ready = ~pValid;

    // State and data management logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset condition
            pValid <= 1'b0;
            pData  <= 8'b0;
        end else begin
            // If a data is being held and deq is ready, clear the data
            if (pValid && io_deq_ready) begin
                pValid <= 1'b0;
            end

            // If enq is ready and valid data is provided, capture it
            if (io_enq_ready && io_enq_valid) begin
                pData  <= io_enq_bits;
                pValid <= 1'b1;
            end
        end
    end

endmodule
