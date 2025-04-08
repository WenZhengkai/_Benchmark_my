circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 19:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 22:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 23:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 26:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 29:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 30:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 30:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 32:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 32:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 33:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 33:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 36:29]
    when do_enq : @[dut.scala 37:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 38:8]
      MPORT <= io.enq.bits @[dut.scala 38:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 39:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 39:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 39:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 39:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 39:13]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 43:29]
    when do_deq : @[dut.scala 44:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 45:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 45:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 45:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 45:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 45:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 49:15]
    when _T : @[dut.scala 49:27]
      maybe_full <= do_enq @[dut.scala 50:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 54:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 54:15]
    node _diff_T = geq(enq_ptr, deq_ptr) @[dut.scala 66:26]
    node _diff_T_1 = sub(enq_ptr, deq_ptr) @[dut.scala 66:46]
    node _diff_T_2 = tail(_diff_T_1, 1) @[dut.scala 66:46]
    node _diff_T_3 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 66:68]
    node _diff_T_4 = tail(_diff_T_3, 1) @[dut.scala 66:68]
    node _diff_T_5 = sub(_diff_T_4, deq_ptr) @[dut.scala 66:79]
    node _diff_T_6 = tail(_diff_T_5, 1) @[dut.scala 66:79]
    node diff = mux(_diff_T, _diff_T_2, _diff_T_6) @[dut.scala 66:17]
    node _io_count_T = mux(full, UInt<5>("h10"), diff) @[dut.scala 67:18]
    io.count <= _io_count_T @[dut.scala 67:12]

