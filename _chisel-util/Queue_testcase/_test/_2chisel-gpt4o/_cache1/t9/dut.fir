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
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 27:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 30:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 31:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 31:25]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 34:29]
    node do_deq = and(io.deq.valid, io.deq.ready) @[dut.scala 35:29]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 38:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 38:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 39:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 39:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 42:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 42:15]
    when do_enq : @[dut.scala 45:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 46:8]
      MPORT <= io.enq.bits @[dut.scala 46:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 47:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 47:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 47:13]
    when do_deq : @[dut.scala 51:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 52:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 52:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 52:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 56:15]
    when _T : @[dut.scala 56:27]
      maybe_full <= do_enq @[dut.scala 57:16]
    node _io_count_T = geq(enq_ptr, deq_ptr) @[dut.scala 71:13]
    node _io_count_T_1 = sub(enq_ptr, deq_ptr) @[dut.scala 72:13]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 72:13]
    node _io_count_T_3 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 73:15]
    node _io_count_T_4 = tail(_io_count_T_3, 1) @[dut.scala 73:15]
    node _io_count_T_5 = sub(_io_count_T_4, deq_ptr) @[dut.scala 73:25]
    node _io_count_T_6 = tail(_io_count_T_5, 1) @[dut.scala 73:25]
    node _io_count_T_7 = mux(_io_count_T, _io_count_T_2, _io_count_T_6) @[dut.scala 70:18]
    io.count <= _io_count_T_7 @[dut.scala 70:12]

