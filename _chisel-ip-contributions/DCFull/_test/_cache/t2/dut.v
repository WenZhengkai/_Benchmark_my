module dut(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 12:22]
  reg [7:0] hold_0; // @[dut.scala 15:19]
  reg [7:0] hold_1; // @[dut.scala 16:19]
  wire  _shift_T = state == 2'h2; // @[dut.scala 19:22]
  wire  _load_T = state == 2'h0; // @[dut.scala 20:37]
  wire  _load_T_1 = state == 2'h1; // @[dut.scala 20:56]
  wire  load = io_enq_valid & (state == 2'h0 | state == 2'h1 | _shift_T); // @[dut.scala 20:27]
  wire  _sendSel_T_1 = state == 2'h3; // @[dut.scala 21:43]
  wire  sendSel = _load_T_1 | state == 2'h3; // @[dut.scala 21:34]
  wire [7:0] _GEN_0 = load ? io_enq_bits : hold_1; // @[dut.scala 33:18 34:16 16:19]
  wire [7:0] _GEN_3 = load ? hold_1 : hold_0; // @[dut.scala 46:24 47:16 15:19]
  wire [1:0] _GEN_4 = load ? 2'h3 : state; // @[dut.scala 46:24 49:15 12:22]
  wire [1:0] _GEN_5 = io_deq_ready ? 2'h1 : _GEN_4; // @[dut.scala 44:26 45:15]
  wire [7:0] _GEN_8 = io_deq_ready ? hold_1 : hold_0; // @[dut.scala 53:26 54:16 15:19]
  wire [1:0] _GEN_9 = io_deq_ready ? 2'h1 : state; // @[dut.scala 53:26 55:15 12:22]
  wire [1:0] _GEN_11 = 2'h3 == state ? _GEN_9 : state; // @[dut.scala 31:17 12:22]
  assign io_enq_ready = _load_T | _load_T_1; // @[dut.scala 27:36]
  assign io_deq_valid = _load_T_1 | _shift_T | _sendSel_T_1; // @[dut.scala 28:55]
  assign io_deq_bits = sendSel ? hold_1 : hold_0; // @[dut.scala 24:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      state <= 2'h0; // @[dut.scala 12:22]
    end else if (2'h0 == state) begin // @[dut.scala 31:17]
      if (load) begin // @[dut.scala 33:18]
        state <= 2'h2; // @[dut.scala 35:15]
      end
    end else if (2'h1 == state) begin // @[dut.scala 31:17]
      if (io_deq_ready) begin // @[dut.scala 39:26]
        state <= 2'h0; // @[dut.scala 40:15]
      end
    end else if (2'h2 == state) begin // @[dut.scala 31:17]
      state <= _GEN_5;
    end else begin
      state <= _GEN_11;
    end
    if (!(2'h0 == state)) begin // @[dut.scala 31:17]
      if (!(2'h1 == state)) begin // @[dut.scala 31:17]
        if (2'h2 == state) begin // @[dut.scala 31:17]
          if (!(io_deq_ready)) begin // @[dut.scala 44:26]
            hold_0 <= _GEN_3;
          end
        end else if (2'h3 == state) begin // @[dut.scala 31:17]
          hold_0 <= _GEN_8;
        end
      end
    end
    if (2'h0 == state) begin // @[dut.scala 31:17]
      hold_1 <= _GEN_0;
    end else if (!(2'h1 == state)) begin // @[dut.scala 31:17]
      if (2'h2 == state) begin // @[dut.scala 31:17]
        if (!(io_deq_ready)) begin // @[dut.scala 44:26]
          hold_1 <= _GEN_0;
        end
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  hold_0 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  hold_1 = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
