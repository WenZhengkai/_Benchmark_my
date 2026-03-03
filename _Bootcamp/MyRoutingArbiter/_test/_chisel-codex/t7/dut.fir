circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 15:47]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 15:47]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 15:47]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 15:16]
    node _selectedChannel_T = mux(io.in[2].valid, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _selectedChannel_T_1 = mux(io.in[1].valid, UInt<2>("h1"), _selectedChannel_T) @[Mux.scala 47:70]
    node selectedChannel = mux(io.in[0].valid, UInt<2>("h0"), _selectedChannel_T_1) @[Mux.scala 47:70]
    io.out.bits <= io.in[selectedChannel].bits @[dut.scala 23:15]
    node _io_in_0_ready_T = and(io.out.ready, io.out.valid) @[dut.scala 27:36]
    node _io_in_0_ready_T_1 = eq(selectedChannel, UInt<1>("h0")) @[dut.scala 27:72]
    node _io_in_0_ready_T_2 = and(_io_in_0_ready_T, _io_in_0_ready_T_1) @[dut.scala 27:52]
    io.in[0].ready <= _io_in_0_ready_T_2 @[dut.scala 27:20]
    node _io_in_1_ready_T = and(io.out.ready, io.out.valid) @[dut.scala 27:36]
    node _io_in_1_ready_T_1 = eq(selectedChannel, UInt<1>("h1")) @[dut.scala 27:72]
    node _io_in_1_ready_T_2 = and(_io_in_1_ready_T, _io_in_1_ready_T_1) @[dut.scala 27:52]
    io.in[1].ready <= _io_in_1_ready_T_2 @[dut.scala 27:20]
    node _io_in_2_ready_T = and(io.out.ready, io.out.valid) @[dut.scala 27:36]
    node _io_in_2_ready_T_1 = eq(selectedChannel, UInt<2>("h2")) @[dut.scala 27:72]
    node _io_in_2_ready_T_2 = and(_io_in_2_ready_T, _io_in_2_ready_T_1) @[dut.scala 27:52]
    io.in[2].ready <= _io_in_2_ready_T_2 @[dut.scala 27:20]
    node _io_in_3_ready_T = and(io.out.ready, io.out.valid) @[dut.scala 27:36]
    node _io_in_3_ready_T_1 = eq(selectedChannel, UInt<2>("h3")) @[dut.scala 27:72]
    node _io_in_3_ready_T_2 = and(_io_in_3_ready_T, _io_in_3_ready_T_1) @[dut.scala 27:52]
    io.in[3].ready <= _io_in_3_ready_T_2 @[dut.scala 27:20]

