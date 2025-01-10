circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, chosen : UInt<2>}

    node _grants_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 38:59]
    node _grants_T_1 = or(_grants_T, io.in[2].valid) @[dut.scala 38:59]
    node _grants_T_2 = or(_grants_T_1, io.in[3].valid) @[dut.scala 38:59]
    node grants_1 = eq(io.in[0].valid, UInt<1>("h0")) @[dut.scala 38:69]
    node grants_2 = eq(_grants_T, UInt<1>("h0")) @[dut.scala 38:69]
    node grants_3 = eq(_grants_T_1, UInt<1>("h0")) @[dut.scala 38:69]
    node grants_4 = eq(_grants_T_2, UInt<1>("h0")) @[dut.scala 38:69]
    node _io_chosen_T = mux(io.in[2].valid, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _io_chosen_T_1 = mux(io.in[1].valid, UInt<1>("h1"), _io_chosen_T) @[Mux.scala 47:70]
    node _io_chosen_T_2 = mux(io.in[0].valid, UInt<1>("h0"), _io_chosen_T_1) @[Mux.scala 47:70]
    io.chosen <= _io_chosen_T_2 @[dut.scala 18:13]
    node _io_out_bits_T = mux(grants_2, io.in[2].bits, io.in[3].bits) @[Mux.scala 47:70]
    node _io_out_bits_T_1 = mux(grants_1, io.in[1].bits, _io_out_bits_T) @[Mux.scala 47:70]
    node _io_out_bits_T_2 = mux(UInt<1>("h1"), io.in[0].bits, _io_out_bits_T_1) @[Mux.scala 47:70]
    io.out.bits <= _io_out_bits_T_2 @[dut.scala 21:15]
    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 24:34]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 24:34]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 24:34]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 24:16]
    node _io_in_0_ready_T = and(UInt<1>("h1"), io.out.ready) @[dut.scala 28:33]
    io.in[0].ready <= _io_in_0_ready_T @[dut.scala 28:20]
    node _io_in_1_ready_T = and(grants_1, io.out.ready) @[dut.scala 28:33]
    io.in[1].ready <= _io_in_1_ready_T @[dut.scala 28:20]
    node _io_in_2_ready_T = and(grants_2, io.out.ready) @[dut.scala 28:33]
    io.in[2].ready <= _io_in_2_ready_T @[dut.scala 28:20]
    node _io_in_3_ready_T = and(grants_3, io.out.ready) @[dut.scala 28:33]
    io.in[3].ready <= _io_in_3_ready_T @[dut.scala 28:20]

