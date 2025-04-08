module dut (
    input         clock,
    input         reset,
    output reg    io_dataIn_ready,
    input         io_dataIn_valid,
    input  [7:0]  io_dataIn_bits,
    input         io_dataOut_ready,
    output reg    io_dataOut_valid,
    output reg [4:0] io_dataOut_bits
);

    // Parameters
    localparam int DATA_WIDTH = 8;
    localparam int OUTPUT_WIDTH = 5;
    localparam int CYCLES = (DATA_WIDTH % OUTPUT_WIDTH != 0) ? (DATA_WIDTH / OUTPUT_WIDTH + 1) : (DATA_WIDTH / OUTPUT_WIDTH);

    // Internal Registers
    reg [DATA_WIDTH-1:0] data_in_reg;
    reg [$clog2(CYCLES):0] cycleCount; // Cycle counter

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            io_dataIn_ready <= 1'b1;
            io_dataOut_valid <= 1'b0;
        end else begin
            if (io_dataIn_valid && io_dataIn_ready) begin
                // Latching the input data when input is ready and valid
                data_in_reg <= io_dataIn_bits;
                cycleCount <= 0;
                io_dataIn_ready <= 1'b0; // Not ready until current data is processed
            end 

            if (io_dataOut_ready && io_dataOut_valid) begin
                cycleCount <= cycleCount + 1;
            end
            
            if (cycleCount == (CYCLES - 1)) begin
                io_dataIn_ready <= 1'b1; // Ready for next data when serialization completes
            end

            // Select output word based on cycle count
            // Cycle-based selection logic
            case(cycleCount)
                0: io_dataOut_bits <= data_in_reg[4:0];
                1: io_dataOut_bits <= data_in_reg[7:5];
                default: io_dataOut_bits <= 5'b0;
            endcase

            io_dataOut_valid <= io_dataIn_valid && !io_dataIn_ready;
        end
    end

endmodule
