circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    node _grant_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 19:70]
    node _grant_T_1 = or(_grant_T, io.in[2].valid) @[dut.scala 19:70]
    node grant_1 = eq(io.in[0].valid, UInt<1>("h0")) @[dut.scala 19:80]
    node grant_2 = eq(_grant_T, UInt<1>("h0")) @[dut.scala 19:80]
    node grant_3 = eq(_grant_T_1, UInt<1>("h0")) @[dut.scala 19:80]
    node _io_chosen_T = mux(io.in[2].valid, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _io_chosen_T_1 = mux(io.in[1].valid, UInt<1>("h1"), _io_chosen_T) @[Mux.scala 47:70]
    node _io_chosen_T_2 = mux(io.in[0].valid, UInt<1>("h0"), _io_chosen_T_1) @[Mux.scala 47:70]
    io.chosen <= _io_chosen_T_2 @[dut.scala 29:13]
    node _io_out_bits_T = mux(UInt<1>("h1"), io.in[0].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_1 = mux(grant_1, io.in[1].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_2 = mux(grant_2, io.in[2].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_3 = mux(grant_3, io.in[3].bits, UInt<1>("h0")) @[Mux.scala 27:73]
    node _io_out_bits_T_4 = or(_io_out_bits_T, _io_out_bits_T_1) @[Mux.scala 27:73]
    node _io_out_bits_T_5 = or(_io_out_bits_T_4, _io_out_bits_T_2) @[Mux.scala 27:73]
    node _io_out_bits_T_6 = or(_io_out_bits_T_5, _io_out_bits_T_3) @[Mux.scala 27:73]
    wire _io_out_bits_WIRE : UInt<8> @[Mux.scala 27:73]
    _io_out_bits_WIRE <= _io_out_bits_T_6 @[Mux.scala 27:73]
    io.out.bits <= _io_out_bits_WIRE @[dut.scala 30:15]
    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 33:36]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 33:36]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 33:36]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 33:16]
    node _io_in_0_ready_T = and(UInt<1>("h1"), io.out.ready) @[dut.scala 35:19]
    io.in[0].ready <= _io_in_0_ready_T @[dut.scala 35:14]
    node _io_in_1_ready_T = and(grant_1, io.out.ready) @[dut.scala 35:19]
    io.in[1].ready <= _io_in_1_ready_T @[dut.scala 35:14]
    node _io_in_2_ready_T = and(grant_2, io.out.ready) @[dut.scala 35:19]
    io.in[2].ready <= _io_in_2_ready_T @[dut.scala 35:14]
    node _io_in_3_ready_T = and(grant_3, io.out.ready) @[dut.scala 35:19]
    io.in[3].ready <= _io_in_3_ready_T @[dut.scala 35:14]

