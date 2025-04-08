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
    reg [7:0] pData;
    reg       pValid;

    // Output assignments
    assign io_deq_valid = pValid;
    assign io_deq_bits = pData;
    assign io_enq_ready = ~pValid;

    // Synchronous logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pValid <= 1'b0;
            pData  <= 8'b0;
        end else begin
            if (io_enq_valid && io_enq_ready) begin
                // Capture the incoming data when enq.valid is high and the module is ready
                pData <= io_enq_bits;
                pValid <= 1'b1;
            end else if (io_deq_ready && pValid) begin
                // Unload data when deq.ready is high and data is valid
                pValid <= 1'b0;
            end
        end
    end

endmodule
