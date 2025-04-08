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

  // Default assignments
  assign io_p_0_bits = io_c_bits;
  assign io_p_1_bits = io_c_bits;
  assign io_p_2_bits = io_c_bits;
  assign io_p_3_bits = io_c_bits;
  assign io_p_4_bits = io_c_bits;

  // Control logic for demultiplexing based on selector io_sel
  always @(*) begin
    io_p_0_valid = 1'b0;
    io_p_1_valid = 1'b0;
    io_p_2_valid = 1'b0;
    io_p_3_valid = 1'b0;
    io_p_4_valid = 1'b0;
    case (io_sel)
      3'b000: begin
        io_p_0_valid = io_c_valid;
        io_c_ready = io_p_0_ready;
      end
      3'b001: begin
        io_p_1_valid = io_c_valid;
        io_c_ready = io_p_1_ready;
      end
      3'b010: begin
        io_p_2_valid = io_c_valid;
        io_c_ready = io_p_2_ready;
      end
      3'b011: begin
        io_p_3_valid = io_c_valid;
        io_c_ready = io_p_3_ready;
      end
      3'b100: begin
        io_p_4_valid = io_c_valid;
        io_c_ready = io_p_4_ready;
      end
      default: begin
        io_c_ready = 1'b0;
      end
    endcase
  end

endmodule
