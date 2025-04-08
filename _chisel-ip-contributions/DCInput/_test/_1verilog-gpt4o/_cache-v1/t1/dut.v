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

    // Registers
    reg ready_r;
    reg occupied;
    reg [7:0] hold;

    // Wires
    wire load;
    wire drain;

    // Initial conditions
    initial begin
        ready_r = 1'b1;
        occupied = 1'b0;
        hold = 8'b0;
    end

    // Load: Determines if new data should be loaded
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);

    // Drain: Determines if data should be outputted
    assign drain = occupied && io_deq_ready;

    // Data forwarding and occupancy logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            ready_r <= 1'b1;
            occupied <= 1'b0;
        end else begin
            if (load) begin
                hold <= io_enq_bits;
                occupied <= 1'b1;
            end
            
            if (drain) begin
                occupied <= 1'b0;
            end

            ready_r <= !occupied || drain || load;
        end
    end

    // Determine output signals
    assign io_enq_ready = ready_r;
    assign io_deq_valid = io_enq_valid || occupied;
    assign io_deq_bits = occupied ? hold : io_enq_bits;

endmodule
