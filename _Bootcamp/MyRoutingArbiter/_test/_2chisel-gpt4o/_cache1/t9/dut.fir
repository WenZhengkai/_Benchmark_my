circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    io.out.valid <= UInt<1>("h0") @[dut.scala 11:16]
    io.out.bits <= UInt<1>("h0") @[dut.scala 12:15]
    wire validIndexes : UInt<1>[4] @[dut.scala 15:29]
    validIndexes[0] <= io.in[0].valid @[dut.scala 15:29]
    validIndexes[1] <= io.in[1].valid @[dut.scala 15:29]
    validIndexes[2] <= io.in[2].valid @[dut.scala 15:29]
    validIndexes[3] <= io.in[3].valid @[dut.scala 15:29]
    node _selectedChannel_T = mux(validIndexes[2], UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _selectedChannel_T_1 = mux(validIndexes[1], UInt<1>("h1"), _selectedChannel_T) @[Mux.scala 47:70]
    node selectedChannel = mux(validIndexes[0], UInt<1>("h0"), _selectedChannel_T_1) @[Mux.scala 47:70]
    node _T = or(validIndexes[0], validIndexes[1]) @[dut.scala 19:30]
    node _T_1 = or(_T, validIndexes[2]) @[dut.scala 19:30]
    node _T_2 = or(_T_1, validIndexes[3]) @[dut.scala 19:30]
    when _T_2 : @[dut.scala 19:37]
      io.out.valid <= UInt<1>("h1") @[dut.scala 20:18]
      io.out.bits <= io.in[selectedChannel].bits @[dut.scala 21:17]
    node _io_in_0_ready_T = eq(selectedChannel, UInt<1>("h0")) @[dut.scala 26:56]
    node _io_in_0_ready_T_1 = and(io.out.ready, _io_in_0_ready_T) @[dut.scala 26:36]
    io.in[0].ready <= _io_in_0_ready_T_1 @[dut.scala 26:20]
    node _io_in_1_ready_T = eq(selectedChannel, UInt<1>("h1")) @[dut.scala 26:56]
    node _io_in_1_ready_T_1 = and(io.out.ready, _io_in_1_ready_T) @[dut.scala 26:36]
    io.in[1].ready <= _io_in_1_ready_T_1 @[dut.scala 26:20]
    node _io_in_2_ready_T = eq(selectedChannel, UInt<2>("h2")) @[dut.scala 26:56]
    node _io_in_2_ready_T_1 = and(io.out.ready, _io_in_2_ready_T) @[dut.scala 26:36]
    io.in[2].ready <= _io_in_2_ready_T_1 @[dut.scala 26:20]
    node _io_in_3_ready_T = eq(selectedChannel, UInt<2>("h3")) @[dut.scala 26:56]
    node _io_in_3_ready_T_1 = and(io.out.ready, _io_in_3_ready_T) @[dut.scala 26:36]
    io.in[3].ready <= _io_in_3_ready_T_1 @[dut.scala 26:20]

