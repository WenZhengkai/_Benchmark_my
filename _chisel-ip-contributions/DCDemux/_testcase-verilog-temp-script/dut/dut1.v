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
    
    // Initialize output data bits to be the same as input
    assign io_p_0_bits = io_c_bits;
    assign io_p_1_bits = io_c_bits;
    assign io_p_2_bits = io_c_bits;
    assign io_p_3_bits = io_c_bits;
    assign io_p_4_bits = io_c_bits;
    
    // Initialize default values for valid signals and the ready signal for input
    assign io_p_0_valid = (io_sel == 3'b000) ? io_c_valid : 1'b0;
    assign io_p_1_valid = (io_sel == 3'b001) ? io_c_valid : 1'b0;
    assign io_p_2_valid = (io_sel == 3'b010) ? io_c_valid : 1'b0;
    assign io_p_3_valid = (io_sel == 3'b011) ? io_c_valid : 1'b0;
    assign io_p_4_valid = (io_sel == 3'b100) ? io_c_valid : 1'b0;
    
    // Decide the ready signal based on the selected output and its readiness
    assign io_c_ready = (io_sel == 3'b000) ? io_p_0_ready :
                        (io_sel == 3'b001) ? io_p_1_ready :
                        (io_sel == 3'b010) ? io_p_2_ready :
                        (io_sel == 3'b011) ? io_p_3_ready :
                        (io_sel == 3'b100) ? io_p_4_ready : 1'b0;

endmodule
