circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    node _grant_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 36:68]
    node _grant_T_1 = or(_grant_T, io.in[2].valid) @[dut.scala 36:68]
    node grant_1 = eq(io.in[0].valid, UInt<1>("h0")) @[dut.scala 36:78]
    node grant_2 = eq(_grant_T, UInt<1>("h0")) @[dut.scala 36:78]
    node grant_3 = eq(_grant_T_1, UInt<1>("h0")) @[dut.scala 36:78]
    io.chosen <= UInt<2>("h3") @[dut.scala 18:13]
    io.out.bits <= io.in[3].bits @[dut.scala 19:15]
    when io.in[2].valid : @[dut.scala 21:22]
      io.chosen <= UInt<2>("h2") @[dut.scala 22:17]
      io.out.bits <= io.in[2].bits @[dut.scala 23:19]
    when io.in[1].valid : @[dut.scala 21:22]
      io.chosen <= UInt<1>("h1") @[dut.scala 22:17]
      io.out.bits <= io.in[1].bits @[dut.scala 23:19]
    when io.in[0].valid : @[dut.scala 21:22]
      io.chosen <= UInt<1>("h0") @[dut.scala 22:17]
      io.out.bits <= io.in[0].bits @[dut.scala 23:19]
    node _io_out_valid_T = and(io.in[0].valid, UInt<1>("h1")) @[dut.scala 28:67]
    node _io_out_valid_T_1 = and(io.in[1].valid, grant_1) @[dut.scala 28:67]
    node _io_out_valid_T_2 = and(io.in[2].valid, grant_2) @[dut.scala 28:67]
    node _io_out_valid_T_3 = and(io.in[3].valid, grant_3) @[dut.scala 28:67]
    node _io_out_valid_T_4 = or(_io_out_valid_T, _io_out_valid_T_1) @[dut.scala 28:83]
    node _io_out_valid_T_5 = or(_io_out_valid_T_4, _io_out_valid_T_2) @[dut.scala 28:83]
    node _io_out_valid_T_6 = or(_io_out_valid_T_5, _io_out_valid_T_3) @[dut.scala 28:83]
    io.out.valid <= _io_out_valid_T_6 @[dut.scala 28:16]
    node _io_in_0_ready_T = and(io.out.ready, UInt<1>("h1")) @[dut.scala 29:71]
    io.in[0].ready <= _io_in_0_ready_T @[dut.scala 29:55]
    node _io_in_1_ready_T = and(io.out.ready, grant_1) @[dut.scala 29:71]
    io.in[1].ready <= _io_in_1_ready_T @[dut.scala 29:55]
    node _io_in_2_ready_T = and(io.out.ready, grant_2) @[dut.scala 29:71]
    io.in[2].ready <= _io_in_2_ready_T @[dut.scala 29:55]
    node _io_in_3_ready_T = and(io.out.ready, grant_3) @[dut.scala 29:71]
    io.in[3].ready <= _io_in_3_ready_T @[dut.scala 29:55]

