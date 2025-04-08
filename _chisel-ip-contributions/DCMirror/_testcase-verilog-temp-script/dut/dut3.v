module dut (
    input wire clock,
    input wire reset,
    input wire [4:0] io_dst,
    output wire io_c_ready,
    input wire io_c_valid,
    input wire [7:0] io_c_bits,
    input wire io_p_0_ready,
    output reg io_p_0_valid,
    output reg [7:0] io_p_0_bits,
    input wire io_p_1_ready,
    output reg io_p_1_valid,
    output reg [7:0] io_p_1_bits,
    input wire io_p_2_ready,
    output reg io_p_2_valid,
    output reg [7:0] io_p_2_bits,
    input wire io_p_3_ready,
    output reg io_p_3_valid,
    output reg [7:0] io_p_3_bits,
    input wire io_p_4_ready,
    output reg io_p_4_valid,
    output reg [7:0] io_p_4_bits
);

    reg [7:0] pData;
    reg [4:0] pValid;
    wire [4:0] pReady;

    assign pReady = {io_p_4_ready, io_p_3_ready, io_p_2_ready, io_p_1_ready, io_p_0_ready};

    wire nxtAccept = (pValid == 5'b00000) || ((pValid & pReady) == pValid);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pValid <= 5'b00000;
        end else begin
            if (nxtAccept) begin
                pData <= io_c_bits; // Capture new data
                pValid <= io_dst & {5{io_c_valid}}; // Update valid signals
            end else begin
                pValid <= pValid & ~pReady; // Deassert valid bits for accepted outputs
            end
        end
    end

    assign io_c_ready = nxtAccept;

    always @(*) begin
        io_p_0_valid = pValid[0];
        io_p_1_valid = pValid[1];
        io_p_2_valid = pValid[2];
        io_p_3_valid = pValid[3];
        io_p_4_valid = pValid[4];

        io_p_0_bits = pData;
        io_p_1_bits = pData;
        io_p_2_bits = pData;
        io_p_3_bits = pData;
        io_p_4_bits = pData;
    end
endmodule
