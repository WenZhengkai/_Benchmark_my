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

    // Internal state registers
    reg         pValid;
    reg [7:0]   pData;

    // Combinational logic for output assignments
    assign io_deq_valid = pValid;
    assign io_deq_bits = pData;
    assign io_enq_ready = ~pValid;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset all internal registers
            pValid <= 1'b0;
            pData <= 8'b0;
        end else begin
            if (!pValid && io_enq_valid) begin
                // Capture the enqueue data if no data is being held
                pData <= io_enq_bits;
                pValid <= 1'b1;
            end else if (pValid && io_deq_ready) begin
                // Clear the held data if dequeue is ready and data is valid
                pValid <= 1'b0;
            end
        end
    end

endmodule
