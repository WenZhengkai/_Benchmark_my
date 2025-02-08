circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 17:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 20:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 21:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 25:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 28:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 29:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 29:25]
    node _do_enq_T = eq(full, UInt<1>("h0")) @[dut.scala 32:32]
    node do_enq = and(io.enq.valid, _do_enq_T) @[dut.scala 32:29]
    node _do_deq_T = eq(empty, UInt<1>("h0")) @[dut.scala 33:32]
    node do_deq = and(io.deq.ready, _do_deq_T) @[dut.scala 33:29]
    when do_enq : @[dut.scala 35:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 36:8]
      MPORT <= io.enq.bits @[dut.scala 36:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 37:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 37:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 37:13]
    when do_deq : @[dut.scala 40:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 41:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 41:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 41:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 44:15]
    when _T : @[dut.scala 44:27]
      maybe_full <= do_enq @[dut.scala 45:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 58:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 58:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 59:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 59:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 60:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 60:15]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 63:33]
    node _io_count_T_1 = gt(deq_ptr, enq_ptr) @[dut.scala 64:28]
    node _io_count_T_2 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 64:49]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 64:49]
    node _io_count_T_4 = sub(_io_count_T_3, deq_ptr) @[dut.scala 64:59]
    node _io_count_T_5 = tail(_io_count_T_4, 1) @[dut.scala 64:59]
    node _io_count_T_6 = sub(enq_ptr, deq_ptr) @[dut.scala 64:78]
    node _io_count_T_7 = tail(_io_count_T_6, 1) @[dut.scala 64:78]
    node _io_count_T_8 = mux(_io_count_T_1, _io_count_T_5, _io_count_T_7) @[dut.scala 64:19]
    node _io_count_T_9 = mux(ptr_match, _io_count_T, _io_count_T_8) @[dut.scala 63:18]
    io.count <= _io_count_T_9 @[dut.scala 63:12]

