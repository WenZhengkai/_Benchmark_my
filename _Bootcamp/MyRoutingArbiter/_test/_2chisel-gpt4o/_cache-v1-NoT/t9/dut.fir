circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 12:47]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 12:47]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 12:47]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 12:16]
    node _selectedIndex_T = mux(io.in[2].valid, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _selectedIndex_T_1 = mux(io.in[1].valid, UInt<1>("h1"), _selectedIndex_T) @[Mux.scala 47:70]
    node selectedIndex = mux(io.in[0].valid, UInt<1>("h0"), _selectedIndex_T_1) @[Mux.scala 47:70]
    node _io_out_bits_T = mux(io.in[0].valid, io.in[0].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_1 = mux(io.in[1].valid, io.in[1].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_2 = mux(io.in[2].valid, io.in[2].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_3 = mux(io.in[3].valid, io.in[3].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_4 = or(_io_out_bits_T, _io_out_bits_T_1) @[Mux.scala 27:73]
    node _io_out_bits_T_5 = or(_io_out_bits_T_4, _io_out_bits_T_2) @[Mux.scala 27:73]
    node _io_out_bits_T_6 = or(_io_out_bits_T_5, _io_out_bits_T_3) @[Mux.scala 27:73]
    wire _io_out_bits_WIRE : UInt<8> @[Mux.scala 27:73]
    _io_out_bits_WIRE <= _io_out_bits_T_6 @[Mux.scala 27:73]
    io.out.bits <= _io_out_bits_WIRE @[dut.scala 22:15]
    node _io_in_0_ready_T = eq(selectedIndex, UInt<1>("h0")) @[dut.scala 27:55]
    node _io_in_0_ready_T_1 = and(io.out.ready, _io_in_0_ready_T) @[dut.scala 27:37]
    io.in[0].ready <= _io_in_0_ready_T_1 @[dut.scala 27:21]
    node _io_in_1_ready_T = eq(selectedIndex, UInt<1>("h1")) @[dut.scala 27:55]
    node _io_in_1_ready_T_1 = and(io.out.ready, _io_in_1_ready_T) @[dut.scala 27:37]
    io.in[1].ready <= _io_in_1_ready_T_1 @[dut.scala 27:21]
    node _io_in_2_ready_T = eq(selectedIndex, UInt<2>("h2")) @[dut.scala 27:55]
    node _io_in_2_ready_T_1 = and(io.out.ready, _io_in_2_ready_T) @[dut.scala 27:37]
    io.in[2].ready <= _io_in_2_ready_T_1 @[dut.scala 27:21]
    node _io_in_3_ready_T = eq(selectedIndex, UInt<2>("h3")) @[dut.scala 27:55]
    node _io_in_3_ready_T_1 = and(io.out.ready, _io_in_3_ready_T) @[dut.scala 27:37]
    io.in[3].ready <= _io_in_3_ready_T_1 @[dut.scala 27:21]

