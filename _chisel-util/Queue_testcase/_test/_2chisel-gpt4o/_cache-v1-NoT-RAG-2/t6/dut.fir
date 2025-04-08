circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 16:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 20:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 23:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 28:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 28:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 29:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 29:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 32:29]
    when do_enq : @[dut.scala 33:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 35:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 35:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 35:13]
      node _T = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 36:10]
      node _T_1 = or(_T, empty) @[dut.scala 36:24]
      when _T_1 : @[dut.scala 36:34]
        maybe_full <= UInt<1>("h1") @[dut.scala 37:18]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 42:29]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 43:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 43:15]
    when do_deq : @[dut.scala 44:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 45:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 45:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 45:13]
      node _T_2 = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 46:10]
      node _T_3 = or(_T_2, full) @[dut.scala 46:24]
      when _T_3 : @[dut.scala 46:33]
        maybe_full <= UInt<1>("h0") @[dut.scala 47:18]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 61:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 61:26]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 62:33]
    node _io_count_T_1 = mux(ptr_match, _io_count_T, ptr_diff) @[dut.scala 62:18]
    io.count <= _io_count_T_1 @[dut.scala 62:12]

