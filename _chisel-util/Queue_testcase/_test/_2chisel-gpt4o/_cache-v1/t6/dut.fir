circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    cmem ram : UInt<8> [16] @[dut.scala 16:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 20:24]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 23:27]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 29:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 30:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 30:25]
    node do_enq = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when do_enq : @[dut.scala 34:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 35:8]
      MPORT <= io.enq.bits @[dut.scala 35:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 36:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 36:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 36:13]
      node _T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 37:18]
      when _T : @[dut.scala 37:39]
        enq_ptr <= UInt<1>("h0") @[dut.scala 38:15]
    node do_deq = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when do_deq : @[dut.scala 44:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 45:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 45:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 45:13]
      node _T_1 = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 46:18]
      when _T_1 : @[dut.scala 46:39]
        deq_ptr <= UInt<1>("h0") @[dut.scala 47:15]
    node _T_2 = neq(do_enq, do_deq) @[dut.scala 52:15]
    when _T_2 : @[dut.scala 52:27]
      maybe_full <= do_enq @[dut.scala 53:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 66:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 66:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 67:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 67:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 68:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 68:15]
    node _count_difference_T = sub(enq_ptr, deq_ptr) @[dut.scala 72:30]
    node count_difference = tail(_count_difference_T, 1) @[dut.scala 72:30]
    node _count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 74:10]
    node _count_T_1 = lt(enq_ptr, deq_ptr) @[dut.scala 75:19]
    node _count_T_2 = add(count_difference, UInt<5>("h10")) @[dut.scala 75:41]
    node _count_T_3 = tail(_count_T_2, 1) @[dut.scala 75:41]
    node _count_T_4 = mux(_count_T_1, _count_T_3, count_difference) @[dut.scala 75:10]
    node count = mux(ptr_match, _count_T, _count_T_4) @[dut.scala 73:8]

