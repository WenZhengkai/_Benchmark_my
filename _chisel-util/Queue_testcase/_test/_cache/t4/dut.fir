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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 20:27]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node _do_enq_T = eq(full, UInt<1>("h0")) @[dut.scala 28:32]
    node do_enq = and(io.enq.valid, _do_enq_T) @[dut.scala 28:29]
    when do_enq : @[dut.scala 29:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 31:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 31:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 31:13]
      node _T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 32:18]
      node _T_1 = tail(_T, 1) @[dut.scala 32:18]
      node _T_2 = eq(_T_1, deq_ptr) @[dut.scala 32:24]
      when _T_2 : @[dut.scala 32:37]
        maybe_full <= UInt<1>("h1") @[dut.scala 33:18]
    node _do_deq_T = eq(empty, UInt<1>("h0")) @[dut.scala 38:32]
    node do_deq = and(io.deq.ready, _do_deq_T) @[dut.scala 38:29]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 39:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 39:15]
    when do_deq : @[dut.scala 40:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 41:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 41:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 41:13]
      node _T_3 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 42:18]
      node _T_4 = tail(_T_3, 1) @[dut.scala 42:18]
      node _T_5 = eq(_T_4, enq_ptr) @[dut.scala 42:24]
      when _T_5 : @[dut.scala 42:37]
        maybe_full <= UInt<1>("h0") @[dut.scala 43:18]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 57:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 57:26]
    node _io_count_T = geq(enq_ptr, deq_ptr) @[dut.scala 58:27]
    node _io_count_T_1 = add(UInt<5>("h10"), ptr_diff) @[dut.scala 58:59]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 58:59]
    node _io_count_T_3 = mux(_io_count_T, ptr_diff, _io_count_T_2) @[dut.scala 58:18]
    io.count <= _io_count_T_3 @[dut.scala 58:12]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 61:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 61:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 62:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 62:16]

