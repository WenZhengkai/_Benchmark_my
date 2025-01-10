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
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 28:29]
    node do_deq = and(io.deq.valid, io.deq.ready) @[dut.scala 29:29]
    node _T = eq(do_deq, UInt<1>("h0")) @[dut.scala 31:19]
    node _T_1 = and(do_enq, _T) @[dut.scala 31:16]
    when _T_1 : @[dut.scala 31:28]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 32:8]
      MPORT <= io.enq.bits @[dut.scala 32:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 33:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 33:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 33:13]
    else :
      node _T_2 = eq(do_enq, UInt<1>("h0")) @[dut.scala 34:15]
      node _T_3 = and(_T_2, do_deq) @[dut.scala 34:23]
      when _T_3 : @[dut.scala 34:34]
        node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 35:24]
        node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 35:24]
        deq_ptr <= _deq_ptr_T_1 @[dut.scala 35:13]
    node _T_4 = neq(do_enq, do_deq) @[dut.scala 38:16]
    when _T_4 : @[dut.scala 38:28]
      maybe_full <= do_enq @[dut.scala 39:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 43:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 43:15]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 44:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 44:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 45:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 45:16]
    node _io_count_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 57:32]
    node _io_count_T_1 = and(ptr_match, _io_count_T) @[dut.scala 57:29]
    node _io_count_T_2 = leq(deq_ptr, enq_ptr) @[dut.scala 57:62]
    node _io_count_T_3 = sub(enq_ptr, deq_ptr) @[dut.scala 57:82]
    node _io_count_T_4 = tail(_io_count_T_3, 1) @[dut.scala 57:82]
    node _io_count_T_5 = sub(UInt<5>("h10"), deq_ptr) @[dut.scala 57:103]
    node _io_count_T_6 = tail(_io_count_T_5, 1) @[dut.scala 57:103]
    node _io_count_T_7 = add(_io_count_T_6, enq_ptr) @[dut.scala 57:113]
    node _io_count_T_8 = tail(_io_count_T_7, 1) @[dut.scala 57:113]
    node _io_count_T_9 = mux(_io_count_T_2, _io_count_T_4, _io_count_T_8) @[dut.scala 57:53]
    node _io_count_T_10 = mux(_io_count_T_1, UInt<1>("h0"), _io_count_T_9) @[dut.scala 57:18]
    io.count <= _io_count_T_10 @[dut.scala 57:12]

