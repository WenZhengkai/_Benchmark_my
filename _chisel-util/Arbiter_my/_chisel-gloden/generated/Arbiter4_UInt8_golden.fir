circuit Arbiter4_UInt8_golden :
  module Arbiter4_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    io.chosen <= UInt<2>("h3") @[golden.scala 36:13]
    io.out.bits <= io.in[3].bits @[golden.scala 37:15]
    when io.in[2].valid : @[golden.scala 39:26]
      io.chosen <= UInt<2>("h2") @[golden.scala 40:17]
      io.out.bits <= io.in[2].bits @[golden.scala 41:19]
    when io.in[1].valid : @[golden.scala 39:26]
      io.chosen <= UInt<1>("h1") @[golden.scala 40:17]
      io.out.bits <= io.in[1].bits @[golden.scala 41:19]
    when io.in[0].valid : @[golden.scala 39:26]
      io.chosen <= UInt<1>("h0") @[golden.scala 40:17]
      io.out.bits <= io.in[0].bits @[golden.scala 41:19]
    node _grant_T = or(io.in[0].valid, io.in[1].valid) @[golden.scala 10:68]
    node _grant_T_1 = or(_grant_T, io.in[2].valid) @[golden.scala 10:68]
    node grant_1 = eq(io.in[0].valid, UInt<1>("h0")) @[golden.scala 10:78]
    node grant_2 = eq(_grant_T, UInt<1>("h0")) @[golden.scala 10:78]
    node grant_3 = eq(_grant_T_1, UInt<1>("h0")) @[golden.scala 10:78]
    node _io_in_0_ready_T = and(UInt<1>("h1"), io.out.ready) @[golden.scala 47:19]
    io.in[0].ready <= _io_in_0_ready_T @[golden.scala 47:14]
    node _io_in_1_ready_T = and(grant_1, io.out.ready) @[golden.scala 47:19]
    io.in[1].ready <= _io_in_1_ready_T @[golden.scala 47:14]
    node _io_in_2_ready_T = and(grant_2, io.out.ready) @[golden.scala 47:19]
    io.in[2].ready <= _io_in_2_ready_T @[golden.scala 47:14]
    node _io_in_3_ready_T = and(grant_3, io.out.ready) @[golden.scala 47:19]
    io.in[3].ready <= _io_in_3_ready_T @[golden.scala 47:14]
    node _io_out_valid_T = eq(grant_3, UInt<1>("h0")) @[golden.scala 48:19]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[3].valid) @[golden.scala 48:31]
    io.out.valid <= _io_out_valid_T_1 @[golden.scala 48:16]

