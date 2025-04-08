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
    node full = and(ptr_match, maybe_full) @[dut.scala 26:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 27:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 27:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 29:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 29:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 30:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 30:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 33:29]
    when do_enq : @[dut.scala 34:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 36:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 36:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 36:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 36:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 36:13]
      node _T = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 37:10]
      node _T_1 = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 37:27]
      node _T_2 = or(_T, _T_1) @[dut.scala 37:24]
      when _T_2 : @[dut.scala 37:42]
        maybe_full <= UInt<1>("h1") @[dut.scala 38:18]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 43:29]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 44:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 44:15]
    when do_deq : @[dut.scala 45:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 46:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 46:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 46:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 46:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 46:13]
      node _T_3 = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 47:10]
      node _T_4 = eq(io.enq.ready, UInt<1>("h0")) @[dut.scala 47:27]
      node _T_5 = or(_T_3, _T_4) @[dut.scala 47:24]
      when _T_5 : @[dut.scala 47:42]
        maybe_full <= UInt<1>("h0") @[dut.scala 48:18]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 63:20]
    node _io_count_T_1 = add(_io_count_T, enq_ptr) @[dut.scala 63:49]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 63:49]
    node _io_count_T_3 = sub(_io_count_T_2, deq_ptr) @[dut.scala 63:59]
    node _io_count_T_4 = tail(_io_count_T_3, 1) @[dut.scala 63:59]
    io.count <= _io_count_T_4 @[dut.scala 63:14]

