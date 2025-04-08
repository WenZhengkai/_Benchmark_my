module dut (
    input wire        clock,
    input wire        reset,
    output reg        io_dataIn_ready,
    input wire        io_dataIn_valid,
    input wire [7:0]  io_dataIn_bits,
    input wire        io_dataOut_ready,
    output reg        io_dataOut_valid,
    output reg [4:0]  io_dataOut_bits
);
    
    // Parameters
    localparam WIDTH = 5;
    
    // Internal signals
    reg [3:0] cycleCount;  // Enough to count up to needed cycles
    reg [7:0] dataBuffer;  // Buffer for incoming data
    integer cycles;
    
    // Calculate the number of cycles needed to serialize input data
    always @(*) begin
        if (8 % WIDTH != 0)
            cycles = 8 / WIDTH + 1;
        else
            cycles = 8 / WIDTH;
    end
    
    // Cycle Counter Logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
        end else if (io_dataIn_valid && io_dataOut_ready && (cycleCount < cycles)) begin
            cycleCount <= cycleCount + 1;
        end else if (cycleCount == cycles - 1 && io_dataOut_ready) begin
            cycleCount <= 0; // Reset counter after last cycle
        end
    end
    
    // Data buffering and selection
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            dataBuffer <= 8'b0;
        end else if (io_dataIn_valid && cycleCount == 0) begin
            dataBuffer <= io_dataIn_bits;
        end
    end
    
    // MUX to select the right word to send
    always @(*) begin
        case (cycleCount)
            0: io_dataOut_bits = dataBuffer[4:0];
            1: io_dataOut_bits = dataBuffer[7:5];
            default: io_dataOut_bits = 5'b0;
        endcase
    end
    
    // Handshaking logic
    always @(*) begin
        io_dataIn_ready = (cycleCount == cycles - 1 && io_dataOut_ready);
        io_dataOut_valid = io_dataIn_valid;
    end
    
endmodule
