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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 25:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 28:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 29:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 29:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 30:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 30:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 31:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 31:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 34:29]
    when do_enq : @[dut.scala 35:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 37:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 37:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 37:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 37:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 37:13]
    node _T = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 41:18]
    node _T_2 = and(do_enq, _T_1) @[dut.scala 41:15]
    when _T_2 : @[dut.scala 41:32]
      maybe_full <= UInt<1>("h1") @[dut.scala 42:16]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 46:29]
    when do_deq : @[dut.scala 47:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 48:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 48:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 48:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 48:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 48:13]
    node _T_3 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[dut.scala 52:18]
    node _T_5 = and(do_deq, _T_4) @[dut.scala 52:15]
    when _T_5 : @[dut.scala 52:32]
      maybe_full <= UInt<1>("h0") @[dut.scala 53:16]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 57:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 57:15]
    node _diff_T = geq(enq_ptr, deq_ptr) @[dut.scala 70:13]
    node _diff_T_1 = sub(enq_ptr, deq_ptr) @[dut.scala 71:13]
    node _diff_T_2 = tail(_diff_T_1, 1) @[dut.scala 71:13]
    node _diff_T_3 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 72:16]
    node _diff_T_4 = tail(_diff_T_3, 1) @[dut.scala 72:16]
    node _diff_T_5 = sub(_diff_T_4, deq_ptr) @[dut.scala 72:27]
    node _diff_T_6 = tail(_diff_T_5, 1) @[dut.scala 72:27]
    node diff = mux(_diff_T, _diff_T_2, _diff_T_6) @[dut.scala 69:17]
    node _io_count_T = mux(full, UInt<5>("h10"), diff) @[dut.scala 74:18]
    io.count <= _io_count_T @[dut.scala 74:12]

