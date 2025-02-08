circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 13:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 16:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 17:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 20:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 23:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 24:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 24:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 26:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 26:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 27:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 27:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 30:23]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 31:8]
      MPORT <= io.enq.bits @[dut.scala 31:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 32:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 32:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 32:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 32:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 32:13]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 36:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 36:15]
    node _T_1 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when _T_1 : @[dut.scala 37:23]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 38:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 38:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 38:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 38:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 38:13]
    node _T_2 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node _T_3 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    node _T_4 = neq(_T_2, _T_3) @[dut.scala 42:22]
    when _T_4 : @[dut.scala 42:41]
      node _maybe_full_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
      maybe_full <= _maybe_full_T @[dut.scala 43:16]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 56:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 56:26]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 57:18]
    node _io_count_T_1 = add(_io_count_T, ptr_diff) @[dut.scala 57:47]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 57:47]
    io.count <= _io_count_T_2 @[dut.scala 57:12]

