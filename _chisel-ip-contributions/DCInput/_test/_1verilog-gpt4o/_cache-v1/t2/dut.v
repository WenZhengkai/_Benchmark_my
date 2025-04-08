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
    reg         ready_r;
    reg         occupied;
    reg  [7:0]  hold;

    // Combinational wires
    wire        load;
    wire        drain;

    // Load condition: Ready to accept new data when ready_r is true,
    // the enqueue is valid, and either the dequeue is not ready or we are draining
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);

    // Drain condition: Drain data when we are occupied and dequeue is ready
    assign drain = occupied && io_deq_ready;

    // Output logic
    assign io_deq_bits = occupied ? hold : io_enq_bits;
    assign io_deq_valid = io_enq_valid || occupied;
    assign io_enq_ready = ready_r;

    // Control Logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ready_r  <= 1'b1;
            occupied <= 1'b0;
            hold     <= 8'b0;
        end else begin
            if (load) begin
                hold     <= io_enq_bits;
                occupied <= 1'b1;
            end

            if (drain) begin
                occupied <= 1'b0;
            end

            // Update ready_r based on occupied, drain, and load conditions
            ready_r <= (!occupied) || drain || load;
        end
    end

endmodule
