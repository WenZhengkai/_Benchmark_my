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

    parameter WIDTH = 5;
    localparam CYCLES = (8 % WIDTH != 0) ? (8 / WIDTH) + 1 : 8 / WIDTH;

    reg [2:0] cycleCount; // Because CYCLES can be up to 2^3-1 = 7 cycles for given width and input size

    reg [7:0] dataSelect; // Buffer for incoming data

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            io_dataIn_ready <= 1'b0;
            io_dataOut_valid <= 1'b0;
        end else begin
            // Handshaking: Output is valid if input is valid
            io_dataOut_valid <= io_dataIn_valid;

            // Calculate when the input ready signal should be high
            io_dataIn_ready <= (cycleCount == (CYCLES - 1)) && io_dataOut_ready;

            if (io_dataIn_valid && io_dataIn_ready) begin
                // Capture new input transaction
                dataSelect <= io_dataIn_bits;
                cycleCount <= 0;
            end else if (io_dataOut_ready && io_dataOut_valid) begin
                // Increment cycle count on valid transmission
                if (cycleCount < CYCLES - 1) begin
                    cycleCount <= cycleCount + 1;
                end

                // Shift and select part of data based on cycleCount for output
                case (cycleCount)
                    3'd0: io_dataOut_bits <= dataSelect[WIDTH-1:0];
                    3'd1: io_dataOut_bits <= dataSelect[8-1:WIDTH];
                    // Add more cases if needed for different cycle count handling
                endcase
            end            
        end
    end
endmodule
