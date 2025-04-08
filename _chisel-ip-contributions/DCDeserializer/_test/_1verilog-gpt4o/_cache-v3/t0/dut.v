module dut (
    input        clock,
    input        reset,
    output       io_dataIn_ready,
    input        io_dataIn_valid,
    input  [4:0] io_dataIn_bits,
    input        io_dataOut_ready,
    output       io_dataOut_valid,
    output [7:0] io_dataOut_bits
);

    // Parameters
    localparam SERIAL_WIDTH = 5;  // Width of the serialized channel
    localparam PARALLEL_WIDTH = 8;  // Total width of the data
    localparam CYCLES = (PARALLEL_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;  // Number of cycles to fully deserialize
    localparam CYCLE_BITS = $clog2(CYCLES);  // Bit width for cycle counter

    // Internal Registers
    reg [CYCLE_BITS-1:0] cycleCount;
    reg [PARALLEL_WIDTH-1:0] dataSelect;
    reg dataValid;

    // Internal Wires
    wire dataIn_fire = io_dataIn_valid && io_dataIn_ready;
    wire dataOut_fire = io_dataOut_valid && io_dataOut_ready;

    // Output Logic
    assign io_dataOut_bits = dataSelect;
    assign io_dataOut_valid = dataValid;

    // Flow Control
    assign io_dataIn_ready = ~dataValid || (dataValid && io_dataOut_ready);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            dataSelect <= 0;
            dataValid <= 0;
        end else begin
            if (dataIn_fire) begin
                // Insert the incoming segment into its position within dataSelect
                dataSelect <= (dataSelect & ~(5'b11111 << (SERIAL_WIDTH * cycleCount))) | (io_dataIn_bits << (SERIAL_WIDTH * cycleCount));
                if (cycleCount == CYCLES - 1) begin
                    dataValid <= 1;
                    cycleCount <= 0;
                end else begin
                    cycleCount <= cycleCount + 1;
                end
            end
            if (dataOut_fire) begin
                dataValid <= 0;
            end
        end
    end

endmodule
