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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 21:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 27:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 27:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 28:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 28:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 31:29]
    when do_enq : @[dut.scala 32:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 34:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 34:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 34:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 34:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 34:13]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 38:29]
    when do_deq : @[dut.scala 39:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 40:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 40:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 40:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 40:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 40:13]
    node _T = eq(do_deq, UInt<1>("h0")) @[dut.scala 44:18]
    node _T_1 = and(do_enq, _T) @[dut.scala 44:15]
    when _T_1 : @[dut.scala 44:27]
      maybe_full <= UInt<1>("h1") @[dut.scala 45:16]
    else :
      node _T_2 = eq(do_enq, UInt<1>("h0")) @[dut.scala 46:14]
      node _T_3 = and(_T_2, do_deq) @[dut.scala 46:22]
      when _T_3 : @[dut.scala 46:33]
        maybe_full <= UInt<1>("h0") @[dut.scala 47:16]
    node _diff_T = geq(enq_ptr, deq_ptr) @[dut.scala 60:26]
    node _diff_T_1 = sub(enq_ptr, deq_ptr) @[dut.scala 60:46]
    node _diff_T_2 = tail(_diff_T_1, 1) @[dut.scala 60:46]
    node _diff_T_3 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 60:68]
    node _diff_T_4 = tail(_diff_T_3, 1) @[dut.scala 60:68]
    node _diff_T_5 = sub(_diff_T_4, deq_ptr) @[dut.scala 60:79]
    node _diff_T_6 = tail(_diff_T_5, 1) @[dut.scala 60:79]
    node diff = mux(_diff_T, _diff_T_2, _diff_T_6) @[dut.scala 60:17]
    node _io_count_T = mux(full, UInt<5>("h10"), diff) @[dut.scala 61:18]
    io.count <= _io_count_T @[dut.scala 61:12]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 64:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 64:15]

