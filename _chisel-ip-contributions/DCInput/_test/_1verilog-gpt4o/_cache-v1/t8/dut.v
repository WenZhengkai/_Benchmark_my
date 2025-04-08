module dut(
    input clock,
    input reset,
    output io_enq_ready,
    input io_enq_valid,
    input [7:0] io_enq_bits,
    input io_deq_ready,
    output io_deq_valid,
    output [7:0] io_deq_bits
);

    // Internal registers
    reg ready_r;
    reg occupied;
    reg [7:0] hold;

    // Internal wires
    wire load;
    wire drain; 

    // Assign load and drain conditions
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);
    assign drain = occupied && io_deq_ready;

    // Output logic
    assign io_enq_ready = ready_r;
    assign io_deq_bits = occupied ? hold : io_enq_bits;
    assign io_deq_valid = io_enq_valid || occupied;

    // Sequential logic for registers
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ready_r <= 1'b1;
            occupied <= 1'b0;
            hold <= 8'b0;
        end else begin
            if (load) begin
                hold <= io_enq_bits;
                occupied <= 1'b1;
            end

            if (drain) begin
                occupied <= 1'b0;
            end

            // Control the ready_r based on occupied, drain, and load
            ready_r <= (occupied && drain) || load ? 1'b0 : 1'b1;
        end
    end

endmodule
