circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 11:47]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 11:47]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 11:47]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 11:16]
    wire channelValids : UInt<1>[4] @[dut.scala 14:30]
    channelValids[0] <= io.in[0].valid @[dut.scala 14:30]
    channelValids[1] <= io.in[1].valid @[dut.scala 14:30]
    channelValids[2] <= io.in[2].valid @[dut.scala 14:30]
    channelValids[3] <= io.in[3].valid @[dut.scala 14:30]
    node _selectedChannel_T = mux(channelValids[2], UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _selectedChannel_T_1 = mux(channelValids[1], UInt<1>("h1"), _selectedChannel_T) @[Mux.scala 47:70]
    node selectedChannel = mux(channelValids[0], UInt<1>("h0"), _selectedChannel_T_1) @[Mux.scala 47:70]
    io.out.bits <= io.in[selectedChannel].bits @[dut.scala 21:15]
    node _io_in_0_ready_T = eq(UInt<1>("h0"), selectedChannel) @[dut.scala 26:44]
    node _io_in_0_ready_T_1 = and(io.out.ready, _io_in_0_ready_T) @[dut.scala 26:36]
    io.in[0].ready <= _io_in_0_ready_T_1 @[dut.scala 26:20]
    node _io_in_1_ready_T = eq(UInt<1>("h1"), selectedChannel) @[dut.scala 26:44]
    node _io_in_1_ready_T_1 = and(io.out.ready, _io_in_1_ready_T) @[dut.scala 26:36]
    io.in[1].ready <= _io_in_1_ready_T_1 @[dut.scala 26:20]
    node _io_in_2_ready_T = eq(UInt<2>("h2"), selectedChannel) @[dut.scala 26:44]
    node _io_in_2_ready_T_1 = and(io.out.ready, _io_in_2_ready_T) @[dut.scala 26:36]
    io.in[2].ready <= _io_in_2_ready_T_1 @[dut.scala 26:20]
    node _io_in_3_ready_T = eq(UInt<2>("h3"), selectedChannel) @[dut.scala 26:44]
    node _io_in_3_ready_T_1 = and(io.out.ready, _io_in_3_ready_T) @[dut.scala 26:36]
    io.in[3].ready <= _io_in_3_ready_T_1 @[dut.scala 26:20]

