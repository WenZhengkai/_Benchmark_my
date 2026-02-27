circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 11:47]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 11:47]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 11:47]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 11:16]
    node _selectChannel_T = mux(io.in[2].valid, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _selectChannel_T_1 = mux(io.in[1].valid, UInt<1>("h1"), _selectChannel_T) @[Mux.scala 47:70]
    node selectChannel = mux(io.in[0].valid, UInt<1>("h0"), _selectChannel_T_1) @[Mux.scala 47:70]
    io.out.bits <= io.in[selectChannel].bits @[dut.scala 21:15]
    node _io_in_0_ready_T = eq(selectChannel, UInt<1>("h0")) @[dut.scala 26:54]
    node _io_in_0_ready_T_1 = and(io.out.ready, _io_in_0_ready_T) @[dut.scala 26:36]
    io.in[0].ready <= _io_in_0_ready_T_1 @[dut.scala 26:20]
    node _io_in_1_ready_T = eq(selectChannel, UInt<1>("h1")) @[dut.scala 26:54]
    node _io_in_1_ready_T_1 = and(io.out.ready, _io_in_1_ready_T) @[dut.scala 26:36]
    io.in[1].ready <= _io_in_1_ready_T_1 @[dut.scala 26:20]
    node _io_in_2_ready_T = eq(selectChannel, UInt<2>("h2")) @[dut.scala 26:54]
    node _io_in_2_ready_T_1 = and(io.out.ready, _io_in_2_ready_T) @[dut.scala 26:36]
    io.in[2].ready <= _io_in_2_ready_T_1 @[dut.scala 26:20]
    node _io_in_3_ready_T = eq(selectChannel, UInt<2>("h3")) @[dut.scala 26:54]
    node _io_in_3_ready_T_1 = and(io.out.ready, _io_in_3_ready_T) @[dut.scala 26:36]
    io.in[3].ready <= _io_in_3_ready_T_1 @[dut.scala 26:20]

