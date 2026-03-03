module CSR(
  input         clock,
  input         reset,
  output [31:0] io_out_bits,
  input         io_in_valid,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  input  [6:0]  io_in_bits_fuOpType,
  input  [31:0] io_cfIn_inst,
  input  [31:0] io_cfIn_pc,
  output        io_jmp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mtvec; // @[CSR.scala 183:24]
  reg [31:0] mcause; // @[CSR.scala 184:25]
  reg [31:0] mepc; // @[CSR.scala 186:23]
  reg [31:0] mstatus; // @[CSR.scala 190:26]
  wire  isEcall = io_cfIn_inst == 32'h73; // @[CSR.scala 194:29]
  wire  isMret = io_cfIn_inst == 32'h30200073; // @[CSR.scala 195:29]
  wire  isEbreak = io_cfIn_inst == 32'h100073; // @[CSR.scala 196:30]
  wire [31:0] _csr_T_1 = 32'h305 == io_in_bits_srcb ? mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_3 = 32'h342 == io_in_bits_srcb ? mcause : _csr_T_1; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_5 = 32'h341 == io_in_bits_srcb ? mepc : _csr_T_3; // @[Mux.scala 81:58]
  wire [31:0] csr = 32'h300 == io_in_bits_srcb ? mstatus : _csr_T_5; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T = io_in_bits_srca | csr; // @[CSR.scala 206:33]
  wire [31:0] _csrUpdate_T_1 = ~io_in_bits_srca; // @[CSR.scala 207:26]
  wire [31:0] _csrUpdate_T_2 = _csrUpdate_T_1 & csr; // @[CSR.scala 207:32]
  wire [31:0] _csrUpdate_T_4 = 7'h1 == io_in_bits_fuOpType ? io_in_bits_srca : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T_6 = 7'h2 == io_in_bits_fuOpType ? _csrUpdate_T : _csrUpdate_T_4; // @[Mux.scala 81:58]
  wire [31:0] csrUpdate = 7'h3 == io_in_bits_fuOpType ? _csrUpdate_T_2 : _csrUpdate_T_6; // @[Mux.scala 81:58]
  wire  csrWen = io_in_valid & io_in_bits_fuOpType != 7'h0; // @[CSR.scala 209:24]
  wire [31:0] _io_out_bits_T_2 = isMret ? mepc : csr; // @[Mux.scala 101:16]
  assign io_out_bits = isEcall ? mtvec : _io_out_bits_T_2; // @[Mux.scala 101:16]
  assign io_jmp = io_in_valid & io_in_bits_fuOpType == 7'h0 & ~isEbreak; // @[CSR.scala 230:53]
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 183:24]
      mtvec <= 32'h0; // @[CSR.scala 183:24]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h305) begin // @[CSR.scala 211:33]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mtvec <= _csrUpdate_T_2;
        end else begin
          mtvec <= _csrUpdate_T_6;
        end
      end
    end
    if (reset) begin // @[CSR.scala 184:25]
      mcause <= 32'h0; // @[CSR.scala 184:25]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[CSR.scala 225:62]
      mcause <= 32'hb; // @[CSR.scala 226:15]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h342) begin // @[CSR.scala 214:34]
        mcause <= csrUpdate; // @[CSR.scala 215:16]
      end
    end
    if (reset) begin // @[CSR.scala 186:23]
      mepc <= 32'h0; // @[CSR.scala 186:23]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[CSR.scala 225:62]
      mepc <= io_cfIn_pc; // @[CSR.scala 227:15]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h341) begin // @[CSR.scala 217:32]
        mepc <= csrUpdate; // @[CSR.scala 218:15]
      end
    end
    if (reset) begin // @[CSR.scala 190:26]
      mstatus <= 32'h1800; // @[CSR.scala 190:26]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h300) begin // @[CSR.scala 220:35]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mstatus <= _csrUpdate_T_2;
        end else begin
          mstatus <= _csrUpdate_T_6;
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
  mtvec = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mcause = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mstatus = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
