module GrayCoder(
  input  [4:0] io_in,
  output [4:0] io_out,
  input        io_encode
);
  wire [4:0] _io_out_T = {{1'd0}, io_in[4:1]}; // @[AsyncFIFO.scala 15:30]
  wire [4:0] _io_out_T_1 = io_in ^ _io_out_T; // @[AsyncFIFO.scala 15:21]
  wire [4:0] _io_out_T_2 = {{4'd0}, io_in[4]}; // @[AsyncFIFO.scala 19:24]
  wire [4:0] _io_out_T_3 = io_in ^ _io_out_T_2; // @[AsyncFIFO.scala 19:18]
  wire [4:0] _io_out_T_4 = {{2'd0}, _io_out_T_3[4:2]}; // @[AsyncFIFO.scala 19:24]
  wire [4:0] _io_out_T_5 = _io_out_T_3 ^ _io_out_T_4; // @[AsyncFIFO.scala 19:18]
  wire [4:0] _io_out_T_6 = {{1'd0}, _io_out_T_5[4:1]}; // @[AsyncFIFO.scala 19:24]
  wire [4:0] _io_out_T_7 = _io_out_T_5 ^ _io_out_T_6; // @[AsyncFIFO.scala 19:18]
  assign io_out = io_encode ? _io_out_T_1 : _io_out_T_7; // @[AsyncFIFO.scala 14:20 15:12 17:12]
endmodule
module AsyncFIFO(
  input         clock,
  input         reset,
  input         io_write_clock,
  input         io_write_enable,
  input  [31:0] io_write_data,
  input         io_read_clock,
  input         io_read_enable,
  output [31:0] io_read_data,
  output        io_full,
  output        io_empty
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] encoder_io_in; // @[AsyncFIFO.scala 49:23]
  wire [4:0] encoder_io_out; // @[AsyncFIFO.scala 49:23]
  wire  encoder_io_encode; // @[AsyncFIFO.scala 49:23]
  wire [4:0] decoder_io_in; // @[AsyncFIFO.scala 57:23]
  wire [4:0] decoder_io_out; // @[AsyncFIFO.scala 57:23]
  wire  decoder_io_encode; // @[AsyncFIFO.scala 57:23]
  wire [4:0] grayCoderInc_io_in; // @[AsyncFIFO.scala 69:26]
  wire [4:0] grayCoderInc_io_out; // @[AsyncFIFO.scala 69:26]
  wire  grayCoderInc_io_encode; // @[AsyncFIFO.scala 69:26]
  reg [31:0] mem [0:15]; // @[AsyncFIFO.scala 84:42]
  wire  mem_io_read_data_MPORT_en; // @[AsyncFIFO.scala 84:42]
  wire [3:0] mem_io_read_data_MPORT_addr; // @[AsyncFIFO.scala 84:42]
  wire [31:0] mem_io_read_data_MPORT_data; // @[AsyncFIFO.scala 84:42]
  wire [31:0] mem_MPORT_data; // @[AsyncFIFO.scala 84:42]
  wire [3:0] mem_MPORT_addr; // @[AsyncFIFO.scala 84:42]
  wire  mem_MPORT_mask; // @[AsyncFIFO.scala 84:42]
  wire  mem_MPORT_en; // @[AsyncFIFO.scala 84:42]
  wire  _write_counter_T = ~io_full; // @[AsyncFIFO.scala 45:78]
  wire  _write_counter_T_1 = io_write_enable & ~io_full; // @[AsyncFIFO.scala 45:75]
  reg [4:0] write_counter; // @[Counter.scala 61:40]
  wire [4:0] _write_counter_wrap_value_T_1 = write_counter + 5'h1; // @[Counter.scala 77:24]
  wire  _read_counter_T = ~io_empty; // @[AsyncFIFO.scala 46:75]
  wire  _read_counter_T_1 = io_read_enable & ~io_empty; // @[AsyncFIFO.scala 46:72]
  reg [4:0] read_counter; // @[Counter.scala 61:40]
  wire [4:0] _read_counter_wrap_value_T_1 = read_counter + 5'h1; // @[Counter.scala 77:24]
  reg [4:0] sync_r; // @[Reg.scala 19:16]
  reg [4:0] read_pointer_gray_sync; // @[Reg.scala 19:16]
  reg [4:0] write_pointer_sync_r; // @[Reg.scala 19:16]
  reg [4:0] write_pointer_sync; // @[Reg.scala 19:16]
  GrayCoder encoder ( // @[AsyncFIFO.scala 49:23]
    .io_in(encoder_io_in),
    .io_out(encoder_io_out),
    .io_encode(encoder_io_encode)
  );
  GrayCoder decoder ( // @[AsyncFIFO.scala 57:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out),
    .io_encode(decoder_io_encode)
  );
  GrayCoder grayCoderInc ( // @[AsyncFIFO.scala 69:26]
    .io_in(grayCoderInc_io_in),
    .io_out(grayCoderInc_io_out),
    .io_encode(grayCoderInc_io_encode)
  );
  assign mem_io_read_data_MPORT_en = io_read_enable & _read_counter_T;
  assign mem_io_read_data_MPORT_addr = read_counter[3:0];
  assign mem_io_read_data_MPORT_data = mem[mem_io_read_data_MPORT_addr]; // @[AsyncFIFO.scala 84:42]
  assign mem_MPORT_data = io_write_data;
  assign mem_MPORT_addr = write_counter[3:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_write_enable & _write_counter_T;
  assign io_read_data = _read_counter_T_1 ? mem_io_read_data_MPORT_data : 32'h0; // @[AsyncFIFO.scala 92:14 93:35 94:16]
  assign io_full = grayCoderInc_io_out == read_pointer_gray_sync; // @[AsyncFIFO.scala 77:35]
  assign io_empty = write_pointer_sync == read_counter; // @[AsyncFIFO.scala 81:32]
  assign encoder_io_in = write_counter; // @[AsyncFIFO.scala 50:17]
  assign encoder_io_encode = 1'h1; // @[AsyncFIFO.scala 51:21]
  assign decoder_io_in = read_pointer_gray_sync; // @[AsyncFIFO.scala 58:17]
  assign decoder_io_encode = 1'h0; // @[AsyncFIFO.scala 59:21]
  assign grayCoderInc_io_in = encoder_io_out; // @[AsyncFIFO.scala 72:20]
  assign grayCoderInc_io_encode = 1'h1; // @[AsyncFIFO.scala 73:24]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[AsyncFIFO.scala 84:42]
    end
  end
  always @(posedge io_write_clock) begin
    if (reset) begin // @[Counter.scala 61:40]
      write_counter <= 5'h0; // @[Counter.scala 61:40]
    end else if (_write_counter_T_1) begin // @[Counter.scala 118:16]
      write_counter <= _write_counter_wrap_value_T_1; // @[Counter.scala 77:15]
    end
    write_pointer_sync_r <= encoder_io_out; // @[Reg.scala 19:16 20:{18,22}]
    write_pointer_sync <= write_pointer_sync_r; // @[Reg.scala 19:16 20:{18,22}]
  end
  always @(posedge io_read_clock) begin
    if (reset) begin // @[Counter.scala 61:40]
      read_counter <= 5'h0; // @[Counter.scala 61:40]
    end else if (_read_counter_T_1) begin // @[Counter.scala 118:16]
      read_counter <= _read_counter_wrap_value_T_1; // @[Counter.scala 77:15]
    end
    sync_r <= encoder_io_out; // @[Reg.scala 19:16 20:{18,22}]
    read_pointer_gray_sync <= sync_r; // @[Reg.scala 19:16 20:{18,22}]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  write_counter = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  read_counter = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  sync_r = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  read_pointer_gray_sync = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  write_pointer_sync_r = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  write_pointer_sync = _RAND_6[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
