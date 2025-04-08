circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<4>}

    cmem ram : UInt<8> [16] @[dut.scala 22:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 26:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 27:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 31:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 34:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 35:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 35:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 37:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 37:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 38:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 38:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 41:29]
    when do_enq : @[dut.scala 43:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 44:8]
      MPORT <= io.enq.bits @[dut.scala 44:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 45:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 45:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 45:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 45:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 45:13]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 49:29]
    when do_deq : @[dut.scala 51:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 52:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 52:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 52:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 52:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 52:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 56:15]
    when _T : @[dut.scala 56:27]
      maybe_full <= do_enq @[dut.scala 57:16]
    node _diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 70:22]
    node diff = tail(_diff_T, 1) @[dut.scala 70:22]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 73:8]
    node _io_count_T_1 = gt(enq_ptr, deq_ptr) @[dut.scala 74:17]
    node _io_count_T_2 = sub(UInt<5>("h10"), deq_ptr) @[dut.scala 74:44]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 74:44]
    node _io_count_T_4 = add(_io_count_T_3, enq_ptr) @[dut.scala 74:54]
    node _io_count_T_5 = tail(_io_count_T_4, 1) @[dut.scala 74:54]
    node _io_count_T_6 = mux(_io_count_T_1, diff, _io_count_T_5) @[dut.scala 74:8]
    node _io_count_T_7 = mux(ptr_match, _io_count_T, _io_count_T_6) @[dut.scala 72:18]
    io.count <= _io_count_T_7 @[dut.scala 72:12]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 77:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 77:15]

