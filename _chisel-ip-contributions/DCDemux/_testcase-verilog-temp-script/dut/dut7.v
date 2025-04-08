module dut (
    input wire        clock,
    input wire        reset,
    input wire [2:0]  io_sel,
    output wire       io_c_ready,
    input wire        io_c_valid,
    input wire [7:0]  io_c_bits,
    input wire        io_p_0_ready,
    output reg        io_p_0_valid,
    output reg [7:0]  io_p_0_bits,
    input wire        io_p_1_ready,
    output reg        io_p_1_valid,
    output reg [7:0]  io_p_1_bits,
    input wire        io_p_2_ready,
    output reg        io_p_2_valid,
    output reg [7:0]  io_p_2_bits,
    input wire        io_p_3_ready,
    output reg        io_p_3_valid,
    output reg [7:0]  io_p_3_bits,
    input wire        io_p_4_ready,
    output reg        io_p_4_valid,
    output reg [7:0]  io_p_4_bits
);

always @(*) begin
    // Initialize all outputs
    io_p_0_valid = 0;
    io_p_1_valid = 0;
    io_p_2_valid = 0;
    io_p_3_valid = 0;
    io_p_4_valid = 0;
    io_p_0_bits  = 8'd0;
    io_p_1_bits  = 8'd0;
    io_p_2_bits  = 8'd0;
    io_p_3_bits  = 8'd0;
    io_p_4_bits  = 8'd0;

    // Default ready signal
    assign io_c_ready = 0;

    if (io_c_valid) begin
        case (io_sel)
            3'd0: begin
                io_p_0_bits = io_c_bits;
                io_p_0_valid = io_c_valid;
                io_c_ready = io_p_0_ready;
            end
            3'd1: begin
                io_p_1_bits = io_c_bits;
                io_p_1_valid = io_c_valid;
                io_c_ready = io_p_1_ready;
            end
            3'd2: begin
                io_p_2_bits = io_c_bits;
                io_p_2_valid = io_c_valid;
                io_c_ready = io_p_2_ready;
            end
            3'd3: begin
                io_p_3_bits = io_c_bits;
                io_p_3_valid = io_c_valid;
                io_c_ready = io_p_3_ready;
            end
            3'd4: begin
                io_p_4_bits = io_c_bits;
                io_p_4_valid = io_c_valid;
                io_c_ready = io_p_4_ready;
            end
            default: ; // Do nothing if sel is out of range
        endcase
    end
end

endmodule
