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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 21:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 22:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 23:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 23:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 26:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 26:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 27:23]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 28:8]
      MPORT <= io.enq.bits @[dut.scala 28:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 29:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 29:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 29:13]
      node _T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 30:18]
      node _T_2 = tail(_T_1, 1) @[dut.scala 30:18]
      node _T_3 = eq(_T_2, deq_ptr) @[dut.scala 30:24]
      when _T_3 : @[dut.scala 30:37]
        maybe_full <= UInt<1>("h1") @[dut.scala 31:18]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 36:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 36:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 37:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 37:15]
    node _T_4 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when _T_4 : @[dut.scala 38:23]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 39:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 39:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 39:13]
      maybe_full <= UInt<1>("h0") @[dut.scala 40:16]
    node _io_count_T = geq(enq_ptr, deq_ptr) @[dut.scala 53:48]
    node _io_count_T_1 = sub(enq_ptr, deq_ptr) @[dut.scala 53:68]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 53:68]
    node _io_count_T_3 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 53:89]
    node _io_count_T_4 = tail(_io_count_T_3, 1) @[dut.scala 53:89]
    node _io_count_T_5 = sub(_io_count_T_4, deq_ptr) @[dut.scala 53:99]
    node _io_count_T_6 = tail(_io_count_T_5, 1) @[dut.scala 53:99]
    node _io_count_T_7 = mux(_io_count_T, _io_count_T_2, _io_count_T_6) @[dut.scala 53:39]
    node _io_count_T_8 = mux(full, UInt<5>("h10"), _io_count_T_7) @[dut.scala 53:18]
    io.count <= _io_count_T_8 @[dut.scala 53:12]

