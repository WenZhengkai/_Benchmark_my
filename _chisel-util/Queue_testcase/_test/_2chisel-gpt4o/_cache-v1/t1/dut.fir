circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 16:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 18:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:24]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 21:27]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node _do_enq_T = eq(full, UInt<1>("h0")) @[dut.scala 28:32]
    node do_enq = and(io.enq.valid, _do_enq_T) @[dut.scala 28:29]
    when do_enq : @[dut.scala 29:17]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 30:8]
      MPORT <= io.enq.bits @[dut.scala 30:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 31:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 31:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 31:13]
    node _do_deq_T = eq(empty, UInt<1>("h0")) @[dut.scala 35:32]
    node do_deq = and(io.deq.ready, _do_deq_T) @[dut.scala 35:29]
    when do_deq : @[dut.scala 36:17]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 37:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 37:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 37:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 41:16]
    when _T : @[dut.scala 41:28]
      maybe_full <= do_enq @[dut.scala 42:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 55:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 55:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 56:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 56:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 57:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 57:15]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 60:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 60:26]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 61:18]
    node _io_count_T_1 = add(_io_count_T, ptr_diff) @[dut.scala 61:47]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 61:47]
    io.count <= _io_count_T_2 @[dut.scala 61:12]

