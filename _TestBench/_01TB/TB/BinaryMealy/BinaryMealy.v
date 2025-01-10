module BinaryMealy(
  input   clock,
  input   reset,
  input   io_in,
  output  io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[FSM.scala 24:22]
  wire [2:0] _GEN_2 = state == 3'h0 ? {{2'd0}, io_in} : state; // @[FSM.scala 24:22 29:26]
  wire [1:0] _GEN_4 = io_in ? 2'h1 : 2'h2; // @[FSM.scala 30:20 31:16 34:16]
  wire [2:0] _GEN_5 = state == 3'h1 ? {{1'd0}, _GEN_4} : _GEN_2; // @[FSM.scala 29:26]
  wire [1:0] _GEN_7 = io_in ? 2'h1 : 2'h3; // @[FSM.scala 30:20 31:16 34:16]
  assign io_out = state == 3'h4; // @[FSM.scala 29:17]
  always @(posedge clock) begin
    if (reset) begin // @[FSM.scala 24:22]
      state <= 3'h0; // @[FSM.scala 24:22]
    end else if (state == 3'h4) begin // @[FSM.scala 29:26]
      state <= {{2'd0}, io_in};
    end else if (state == 3'h3) begin // @[FSM.scala 29:26]
      if (io_in) begin // @[FSM.scala 30:20]
        state <= 3'h4; // @[FSM.scala 31:16]
      end else begin
        state <= 3'h0; // @[FSM.scala 34:16]
      end
    end else if (state == 3'h2) begin // @[FSM.scala 29:26]
      state <= {{1'd0}, _GEN_7};
    end else begin
      state <= _GEN_5;
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
  state = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
