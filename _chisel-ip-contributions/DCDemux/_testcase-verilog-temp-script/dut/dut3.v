module dut (
    input        clock,
    input        reset,
    input  [2:0] io_sel,
    output       io_c_ready,
    input        io_c_valid,
    input  [7:0] io_c_bits,
    input        io_p_0_ready,
    output       io_p_0_valid,
    output [7:0] io_p_0_bits,
    input        io_p_1_ready,
    output       io_p_1_valid,
    output [7:0] io_p_1_bits,
    input        io_p_2_ready,
    output       io_p_2_valid,
    output [7:0] io_p_2_bits,
    input        io_p_3_ready,
    output       io_p_3_valid,
    output [7:0] io_p_3_bits,
    input        io_p_4_ready,
    output       io_p_4_valid,
    output [7:0] io_p_4_bits
);

    // Default values for outputs
    assign io_p_0_bits = io_c_bits;
    assign io_p_1_bits = io_c_bits;
    assign io_p_2_bits = io_c_bits;
    assign io_p_3_bits = io_c_bits;
    assign io_p_4_bits = io_c_bits;

    // Default values for valid signals
    assign io_p_0_valid = (io_sel == 3'd0) ? io_c_valid : 0;
    assign io_p_1_valid = (io_sel == 3'd1) ? io_c_valid : 0;
    assign io_p_2_valid = (io_sel == 3'd2) ? io_c_valid : 0;
    assign io_p_3_valid = (io_sel == 3'd3) ? io_c_valid : 0;
    assign io_p_4_valid = (io_sel == 3'd4) ? io_c_valid : 0;

    // Determine the ready signal for input based on selected output
    assign io_c_ready = ((io_sel == 3'd0) && io_p_0_ready) ||
                        ((io_sel == 3'd1) && io_p_1_ready) ||
                        ((io_sel == 3'd2) && io_p_2_ready) ||
                        ((io_sel == 3'd3) && io_p_3_ready) ||
                        ((io_sel == 3'd4) && io_p_4_ready);

endmodule
