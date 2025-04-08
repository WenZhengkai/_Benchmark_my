module dut (
    input         clock,
    input         reset,
    output        io_enq_ready,
    input         io_enq_valid,
    input  [7:0]  io_enq_bits,
    input         io_deq_ready,
    output        io_deq_valid,
    output [7:0]  io_deq_bits
);
    // Internal registers
    reg ready_r;
    reg occupied;
    reg [7:0] hold;

    // Internal wires
    wire load;
    wire drain;

    // Initialize registers
    initial begin
        ready_r = 1'b1;  // Assume register can accept new data at start
        occupied = 1'b0; // No data initially held
        hold = 8'b0;     // No initial data in hold
    end

    // Combinational logic for load and drain
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);
    assign drain = occupied && io_deq_ready;

    // Control logic for registers
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ready_r <= 1'b1;
            occupied <= 1'b0;
            hold <= 8'b0;
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

    // Data forwarding logic
    assign io_deq_bits = occupied ? hold : io_enq_bits;
    assign io_deq_valid = io_enq_valid || occupied;
    assign io_enq_ready = ready_r;
    
endmodule
