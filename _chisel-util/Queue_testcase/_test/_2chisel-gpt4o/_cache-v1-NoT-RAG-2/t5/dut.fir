circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 20:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 23:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 24:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:27]
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
      node _T = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 40:10]
      node _T_1 = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 40:27]
      node _T_2 = or(_T, _T_1) @[dut.scala 40:24]
      when _T_2 : @[dut.scala 40:42]
        maybe_full <= UInt<1>("h1") @[dut.scala 41:18]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 46:29]
    when do_deq : @[dut.scala 47:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 48:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 48:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 48:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 48:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 48:13]
      node _T_3 = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 49:10]
      node _T_4 = eq(io.enq.ready, UInt<1>("h0")) @[dut.scala 49:27]
      node _T_5 = or(_T_3, _T_4) @[dut.scala 49:24]
      when _T_5 : @[dut.scala 49:42]
        maybe_full <= UInt<1>("h0") @[dut.scala 50:18]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 54:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 54:15]
    node _diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 67:24]
    node diff = tail(_diff_T, 1) @[dut.scala 67:24]
    node _io_count_T = mux(full, UInt<5>("h10"), diff) @[dut.scala 68:20]
    io.count <= _io_count_T @[dut.scala 68:14]

