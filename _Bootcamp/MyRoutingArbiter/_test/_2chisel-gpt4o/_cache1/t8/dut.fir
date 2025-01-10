circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}[4], out : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    node _io_out_valid_T = or(io.in[0].valid, io.in[1].valid) @[dut.scala 11:47]
    node _io_out_valid_T_1 = or(_io_out_valid_T, io.in[2].valid) @[dut.scala 11:47]
    node _io_out_valid_T_2 = or(_io_out_valid_T_1, io.in[3].valid) @[dut.scala 11:47]
    io.out.valid <= _io_out_valid_T_2 @[dut.scala 11:16]
    node _priorityIdx_T = mux(io.in[2].valid, UInt<2>("h2"), UInt<2>("h3")) @[Mux.scala 47:70]
    node _priorityIdx_T_1 = mux(io.in[1].valid, UInt<1>("h1"), _priorityIdx_T) @[Mux.scala 47:70]
    node priorityIdx = mux(io.in[0].valid, UInt<1>("h0"), _priorityIdx_T_1) @[Mux.scala 47:70]
    node _io_out_bits_T = eq(UInt<1>("h1"), priorityIdx) @[Mux.scala 81:61]
    node _io_out_bits_T_1 = mux(_io_out_bits_T, io.in[1].bits, io.in[0].bits) @[Mux.scala 81:58]
    node _io_out_bits_T_2 = eq(UInt<2>("h2"), priorityIdx) @[Mux.scala 81:61]
    node _io_out_bits_T_3 = mux(_io_out_bits_T_2, io.in[2].bits, _io_out_bits_T_1) @[Mux.scala 81:58]
    node _io_out_bits_T_4 = eq(UInt<2>("h3"), priorityIdx) @[Mux.scala 81:61]
    node _io_out_bits_T_5 = mux(_io_out_bits_T_4, io.in[3].bits, _io_out_bits_T_3) @[Mux.scala 81:58]
    io.out.bits <= _io_out_bits_T_5 @[dut.scala 17:15]
    node _io_in_0_ready_T = eq(priorityIdx, UInt<1>("h0")) @[dut.scala 23:46]
    node _io_in_0_ready_T_1 = and(io.out.ready, _io_in_0_ready_T) @[dut.scala 23:30]
    io.in[0].ready <= _io_in_0_ready_T_1 @[dut.scala 23:14]
    node _io_in_1_ready_T = eq(priorityIdx, UInt<1>("h1")) @[dut.scala 23:46]
    node _io_in_1_ready_T_1 = and(io.out.ready, _io_in_1_ready_T) @[dut.scala 23:30]
    io.in[1].ready <= _io_in_1_ready_T_1 @[dut.scala 23:14]
    node _io_in_2_ready_T = eq(priorityIdx, UInt<2>("h2")) @[dut.scala 23:46]
    node _io_in_2_ready_T_1 = and(io.out.ready, _io_in_2_ready_T) @[dut.scala 23:30]
    io.in[2].ready <= _io_in_2_ready_T_1 @[dut.scala 23:14]
    node _io_in_3_ready_T = eq(priorityIdx, UInt<2>("h3")) @[dut.scala 23:46]
    node _io_in_3_ready_T_1 = and(io.out.ready, _io_in_3_ready_T) @[dut.scala 23:30]
    io.in[3].ready <= _io_in_3_ready_T_1 @[dut.scala 23:14]

