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
    reg           ready_r;
    reg           occupied;
    reg  [7:0]    hold;

    // Combinational wires
    wire          load;
    wire          drain;

    // Load condition
    assign load = io_enq_valid && ready_r && (!io_deq_ready || drain);

    // Drain condition
    assign drain = occupied && io_deq_ready;

    // Determine output data
    assign io_deq_bits = occupied ? hold : io_enq_bits;

    // Determine the validity of the output data
    assign io_deq_valid = io_enq_valid || occupied;

    // Determine if the module is ready for new data
    assign io_enq_ready = ready_r;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Initialize registers on reset
            ready_r <= 1'b1;
            occupied <= 1'b0;
        end else begin
            if (load) begin
                // Load new data into hold register
                hold <= io_enq_bits;
                occupied <= 1'b1;
            end
            if (drain) begin
                // Clear the occupied status when data is forwarded
                occupied <= 1'b0;
            end

            // Determine ready_r status
            ready_r <= drain || !occupied;
        end
    end

endmodule
