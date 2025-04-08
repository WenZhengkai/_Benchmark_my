module dut(
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

    // Initialize all output valid signals to zero
    assign io_p_0_valid = 0;
    assign io_p_1_valid = 0;
    assign io_p_2_valid = 0;
    assign io_p_3_valid = 0;
    assign io_p_4_valid = 0;

    // Assign bits from input to outputs
    assign io_p_0_bits = io_c_bits;
    assign io_p_1_bits = io_c_bits;
    assign io_p_2_bits = io_c_bits;
    assign io_p_3_bits = io_c_bits;
    assign io_p_4_bits = io_c_bits;

    // Internal signal to propagate ready signal correctly
    wire ready_signal;

    // Main logic to route the data based on selector
    always @(*) begin
        // Default ready signal to 0
        ready_signal = 0;

        case (io_sel)
            3'b000: if (io_c_valid && io_p_0_ready) begin
                        io_p_0_valid = io_c_valid;
                        ready_signal = io_p_0_ready;
                    end
            3'b001: if (io_c_valid && io_p_1_ready) begin
                        io_p_1_valid = io_c_valid;
                        ready_signal = io_p_1_ready;
                    end
            3'b010: if (io_c_valid && io_p_2_ready) begin
                        io_p_2_valid = io_c_valid;
                        ready_signal = io_p_2_ready;
                    end
            3'b011: if (io_c_valid && io_p_3_ready) begin
                        io_p_3_valid = io_c_valid;
                        ready_signal = io_p_3_ready;
                    end
            3'b100: if (io_c_valid && io_p_4_ready) begin
                        io_p_4_valid = io_c_valid;
                        ready_signal = io_p_4_ready;
                    end
            default: ;
        endcase
    end

    assign io_c_ready = ready_signal;

endmodule
