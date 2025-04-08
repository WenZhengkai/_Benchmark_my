module dut(
    input        clock,
    input        reset,
    output       io_in_0_ready,
    input        io_in_0_valid,
    input  [7:0] io_in_0_bits,
    output       io_in_1_ready,
    input        io_in_1_valid,
    input  [7:0] io_in_1_bits,
    output       io_in_2_ready,
    input        io_in_2_valid,
    input  [7:0] io_in_2_bits,
    output       io_in_3_ready,
    input        io_in_3_valid,
    input  [7:0] io_in_3_bits,
    input        io_out_ready,
    output       io_out_valid,
    output [7:0] io_out_bits
);

    // Internal wires to hold valid conditions
    wire priority_mux_0;
    wire priority_mux_1;
    wire priority_mux_2;
    wire priority_mux_3;

    // Priority Mux Logic
    // Find the first valid input channel
    assign priority_mux_0 = io_in_0_valid;
    assign priority_mux_1 = io_in_1_valid & ~io_in_0_valid;
    assign priority_mux_2 = io_in_2_valid & ~io_in_0_valid & ~io_in_1_valid;
    assign priority_mux_3 = io_in_3_valid & ~io_in_0_valid & ~io_in_1_valid & ~io_in_2_valid;
    
    // Output Validity Logic
    assign io_out_valid = io_in_0_valid || io_in_1_valid || io_in_2_valid || io_in_3_valid;

    // Data Routing Logic
    assign io_out_bits = (priority_mux_0) ? io_in_0_bits :
                         (priority_mux_1) ? io_in_1_bits :
                         (priority_mux_2) ? io_in_2_bits :
                         (priority_mux_3) ? io_in_3_bits : 8'b0;

    // Input Readiness Logic
    assign io_in_0_ready = io_out_ready & priority_mux_0;
    assign io_in_1_ready = io_out_ready & priority_mux_1;
    assign io_in_2_ready = io_out_ready & priority_mux_2;
    assign io_in_3_ready = io_out_ready & priority_mux_3;

endmodule
