circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 15:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 18:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 23:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 26:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 27:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 27:25]
    node do_enq = and(io.enq.ready, io.enq.valid) @[dut.scala 30:29]
    when do_enq : @[dut.scala 31:17]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 32:8]
      MPORT <= io.enq.bits @[dut.scala 32:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 33:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 33:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 33:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 33:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 33:13]
      maybe_full <= UInt<1>("h1") @[dut.scala 34:16]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 38:29]
    when do_deq : @[dut.scala 39:17]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 40:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 40:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 40:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 40:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 40:13]
      maybe_full <= UInt<1>("h0") @[dut.scala 41:16]
    node _count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 55:8]
    node _count_T_1 = gt(enq_ptr, deq_ptr) @[dut.scala 56:17]
    node _count_T_2 = sub(enq_ptr, deq_ptr) @[dut.scala 56:36]
    node _count_T_3 = tail(_count_T_2, 1) @[dut.scala 56:36]
    node _count_T_4 = sub(UInt<5>("h10"), deq_ptr) @[dut.scala 56:57]
    node _count_T_5 = tail(_count_T_4, 1) @[dut.scala 56:57]
    node _count_T_6 = add(_count_T_5, enq_ptr) @[dut.scala 56:67]
    node _count_T_7 = tail(_count_T_6, 1) @[dut.scala 56:67]
    node _count_T_8 = mux(_count_T_1, _count_T_3, _count_T_7) @[dut.scala 56:8]
    node count = mux(ptr_match, _count_T, _count_T_8) @[dut.scala 54:18]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 60:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 60:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 61:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 61:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 62:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 62:15]
    io.count <= count @[dut.scala 63:12]

