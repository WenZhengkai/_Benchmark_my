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

    // Define parameters
    localparam SERIAL_WIDTH = 5;
    localparam PARALLEL_WIDTH = 8;
    localparam CYCLES = (PARALLEL_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;  // Ceil(PARALLEL_WIDTH / SERIAL_WIDTH)
    
    // Internal registers
    reg [SERIAL_WIDTH*CYCLES-1:0] dataSelect;
    reg [CYCLES-1:0] cycleCount;
    reg dataValid;

    integer i;
    
    // Assign outputs
    assign io_dataIn_ready = ~dataValid;
    assign io_dataOut_valid = dataValid;
    assign io_dataOut_bits = dataSelect[PARALLEL_WIDTH-1:0]; // Adjust slicing based on any remainder logic needed

    // Main logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            dataValid <= 0;
            dataSelect <= 0;
        end
        else begin
            if (io_dataIn_valid && io_dataIn_ready) begin
                // Store incoming bits
                dataSelect <= (dataSelect << SERIAL_WIDTH) | io_dataIn_bits;
                
                // Increment cycle count
                if (cycleCount == CYCLES - 1) begin
                    // Last cycle completes our data collection
                    dataValid <= 1'b1;
                    cycleCount <= 0;
                end else begin
                    cycleCount <= cycleCount + 1;
                end
            end

            // Clear data valid if output acknowledged
            if (io_dataOut_valid && io_dataOut_ready) begin
                dataValid <= 0;
            end
        end
    end

endmodule
