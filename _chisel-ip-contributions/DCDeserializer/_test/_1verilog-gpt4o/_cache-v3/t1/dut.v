module dut(
    input wire clock,
    input wire reset,
    output reg io_dataIn_ready,
    input wire io_dataIn_valid,
    input wire [4:0] io_dataIn_bits,
    input wire io_dataOut_ready,
    output reg io_dataOut_valid,
    output reg [7:0] io_dataOut_bits
);
    // Parameter for cycle calculation
    localparam TOTAL_WIDTH = 8;
    localparam SERIAL_WIDTH = 5;
    localparam CYCLES = (TOTAL_WIDTH + SERIAL_WIDTH - 1) / SERIAL_WIDTH;
    
    // Register declarations
    reg [$clog2(CYCLES)-1:0] cycleCount;
    reg [TOTAL_WIDTH-1:0] dataSelect;
    reg dataValid;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            dataSelect <= 0;
            dataValid <= 0;
            io_dataIn_ready <= 1;  // Ready to accept data after reset
            io_dataOut_valid <= 0;
        end else begin
            // Handling data input
            if (io_dataIn_valid && io_dataIn_ready) begin
                // Store the incoming serialized data into the appropriate segment of dataSelect
                dataSelect[cycleCount*SERIAL_WIDTH +: SERIAL_WIDTH] <= io_dataIn_bits;
                cycleCount <= cycleCount + 1;
                
                if (cycleCount == (CYCLES - 1)) begin
                    // Last segment received, set data valid
                    dataValid <= 1;
                    io_dataIn_ready <= 0; // Stop accepting more data until current is processed
                    cycleCount <= 0; // Reset cycle count for next data
                end
            end

            // Handling data output
            if (dataValid && io_dataOut_ready) begin
                io_dataOut_bits <= dataSelect;
                io_dataOut_valid <= 1;
                dataValid <= 0; // Data is now consumed
                io_dataIn_ready <= 1; // Ready to accept new serialized data
            end else begin
                io_dataOut_valid <= 0;
            end
        end
    end
    
endmodule
