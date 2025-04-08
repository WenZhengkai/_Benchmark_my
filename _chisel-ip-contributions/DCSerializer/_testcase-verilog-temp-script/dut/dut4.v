module dut (
    input       clock,
    input       reset,
    output      io_dataIn_ready,
    input       io_dataIn_valid,
    input [7:0] io_dataIn_bits,
    input       io_dataOut_ready,
    output      io_dataOut_valid,
    output [4:0] io_dataOut_bits
);

    // Parameters
    parameter WIDTH = 5;
    parameter DATA_WIDTH = 8; // Width of input data

    // Internal signals
    reg [31:0] cycleCount; // Assumed cycle count large enough to cover the division
    
    // Number of cycles calculated as ceil(DATA_WIDTH / WIDTH)
    wire [31:0] cycles = (DATA_WIDTH + WIDTH - 1) / WIDTH;
    
    // Data buffer for holding serialized words - assumed to be of appropriate size
    reg [DATA_WIDTH-1:0] dataBuffer;
    reg [WIDTH-1:0] dataSelect[0: (DATA_WIDTH+WIDTH-1)/WIDTH - 1];
    
    // Handshaking signals
    assign io_dataIn_ready = (cycleCount == cycles - 1) & io_dataOut_ready;
    assign io_dataOut_valid = io_dataIn_valid & (cycleCount < cycles);

    // Data selection logic
    assign io_dataOut_bits = dataSelect[cycleCount];

    // Counter and data management
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            cycleCount <= 0;
            dataBuffer <= 0;
        end else if (io_dataIn_ready && io_dataIn_valid) begin
            dataBuffer <= io_dataIn_bits;
            cycleCount <= 0;
        end else if (io_dataOut_ready && io_dataOut_valid) begin
            cycleCount <= cycleCount + 1;
        end
    end

    // Logic to divide input into segments of WIDTH bits
    always @* begin
        integer i;
        for (i = 0; i < cycles; i = i + 1) begin
            dataSelect[i] = dataBuffer >> (i * WIDTH);
        end
    end

endmodule
