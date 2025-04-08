module dut(
    input wire clock,
    input wire reset,
    input wire [2:0] io_sel,
    output wire io_c_ready,
    input wire io_c_valid,
    input wire [7:0] io_c_bits,
    input wire io_p_0_ready,
    output wire io_p_0_valid,
    output wire [7:0] io_p_0_bits,
    input wire io_p_1_ready,
    output wire io_p_1_valid,
    output wire [7:0] io_p_1_bits,
    input wire io_p_2_ready,
    output wire io_p_2_valid,
    output wire [7:0] io_p_2_bits,
    input wire io_p_3_ready,
    output wire io_p_3_valid,
    output wire [7:0] io_p_3_bits,
    input wire io_p_4_ready,
    output wire io_p_4_valid,
    output wire [7:0] io_p_4_bits
);

// Default assignments
assign io_p_0_bits = io_c_bits;
assign io_p_1_bits = io_c_bits;
assign io_p_2_bits = io_c_bits;
assign io_p_3_bits = io_c_bits;
assign io_p_4_bits = io_c_bits;

// Valid signals
assign io_p_0_valid = (io_sel == 3'd0) ? io_c_valid : 1'b0;
assign io_p_1_valid = (io_sel == 3'd1) ? io_c_valid : 1'b0;
assign io_p_2_valid = (io_sel == 3'd2) ? io_c_valid : 1'b0;
assign io_p_3_valid = (io_sel == 3'd3) ? io_c_valid : 1'b0;
assign io_p_4_valid = (io_sel == 3'd4) ? io_c_valid : 1'b0;

// Ready signal
assign io_c_ready = (io_sel == 3'd0) ? io_p_0_ready :
                    (io_sel == 3'd1) ? io_p_1_ready :
                    (io_sel == 3'd2) ? io_p_2_ready :
                    (io_sel == 3'd3) ? io_p_3_ready :
                    (io_sel == 3'd4) ? io_p_4_ready : 1'b0;

endmodule
