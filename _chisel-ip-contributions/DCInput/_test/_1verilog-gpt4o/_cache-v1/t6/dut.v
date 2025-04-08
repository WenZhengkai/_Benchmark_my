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
    reg ready_r;
    reg occupied;
    reg [7:0] hold;

    // Combinational wires
    wire load;
    wire drain;

    // Determine if we should load new data
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);

    // Determine if we should drain data to output
    assign drain = occupied && io_deq_ready;

    // Data output logic
    assign io_deq_bits = occupied ? hold : io_enq_bits;

    // Data valid logic
    assign io_deq_valid = io_enq_valid || occupied;

    // Ready signal logic
    assign io_enq_ready = !occupied || drain || load;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ready_r <= 1'b1;
            occupied <= 1'b0;
            hold <= 8'b0;
        end else begin
            // Control Logic
            if (load) begin
                hold <= io_enq_bits;
                occupied <= 1'b1;
            end
            if (drain) begin
                occupied <= 1'b0;
            end

            // Update ready state based on occupied, drain, load
            ready_r <= !occupied || drain || load;
        end
    end

endmodule
