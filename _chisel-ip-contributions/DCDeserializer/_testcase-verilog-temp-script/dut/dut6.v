module dut(
    input          clock,
    input          reset,
    output         io_dataIn_ready,
    input          io_dataIn_valid,
    input   [4:0]  io_dataIn_bits,
    input          io_dataOut_ready,
    output         io_dataOut_valid,
    output  [7:0]  io_dataOut_bits
);

    // Calculation of the number of cycles required for full deserialization
    localparam DATA_WIDTH = 8;
    localparam SERIAL_WIDTH = 5;
    localparam CYCLES = (DATA_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH; // Equivalent to ceil(DATA_WIDTH / SERIAL_WIDTH)
    localparam LOG2_CYCLES = 2; // log2Ceil for 2 cycles as we require minimum 2 cycle for 8 bits 

    // Register Declarations
    reg [LOG2_CYCLES-1:0] cycleCount;
    reg [DATA_WIDTH-1:0] dataSelect; // Holds the deserialized data temporarily
    reg dataValid; // Indicates if deserialized data is valid

    // Assignments for output
    assign io_dataOut_bits = dataSelect;
    assign io_dataOut_valid = dataValid;
    assign io_dataIn_ready = ~dataValid || (io_dataOut_ready && dataValid);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            dataSelect <= 0;
            dataValid <= 0;
        end else begin
            // Handle input fire scenario
            if (io_dataIn_valid && io_dataIn_ready) begin
                dataSelect <= {dataSelect[DATA_WIDTH-SERIAL_WIDTH-1:0], io_dataIn_bits};
                if (cycleCount == CYCLES - 1) begin
                    dataValid <= 1;
                    cycleCount <= 0;
                end else begin
                    cycleCount <= cycleCount + 1;
                end
            end

            // Handle output fire scenario
            if (io_dataOut_valid && io_dataOut_ready) begin
                dataValid <= 0;
            end
        end
    end

endmodule
