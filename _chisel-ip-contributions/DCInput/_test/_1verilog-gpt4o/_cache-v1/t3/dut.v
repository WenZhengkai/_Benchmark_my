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

    // Internal registers and wires
    reg          ready_r;
    reg          occupied;
    reg  [7:0]   hold;
    wire         load;
    wire         drain;

    // Assign statements for combinational wires
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);
    assign drain = occupied && io_deq_ready;

    // Assign output signals based on internal logic
    assign io_deq_valid = io_enq_valid || occupied;
    assign io_enq_ready = ready_r;
    assign io_deq_bits = occupied ? hold : io_enq_bits;

    // Sequential logic for register updates
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ready_r <= 1'b1;
            occupied <= 1'b0;
        end else begin
            if (load) begin
                hold <= io_enq_bits;
                occupied <= 1'b1;
            end else if (drain) begin
                occupied <= 1'b0;
            end
            ready_r <= ~occupied || drain || load;
        end
    end
endmodule
