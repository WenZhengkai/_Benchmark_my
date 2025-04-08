circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 19:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 22:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 23:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 25:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 28:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 29:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 29:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 31:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 31:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 32:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 32:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 35:29]
    when do_enq : @[dut.scala 36:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 37:8]
      MPORT <= io.enq.bits @[dut.scala 37:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 38:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 38:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 38:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 38:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 38:13]
      node _T = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 39:10]
      node _T_1 = or(_T, empty) @[dut.scala 39:24]
      when _T_1 : @[dut.scala 39:34]
        maybe_full <= UInt<1>("h1") @[dut.scala 40:18]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 45:29]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 46:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 46:15]
    when do_deq : @[dut.scala 47:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 48:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 48:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 48:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 48:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 48:13]
      node _T_2 = eq(io.enq.valid, UInt<1>("h0")) @[dut.scala 49:10]
      node _T_3 = or(_T_2, full) @[dut.scala 49:24]
      when _T_3 : @[dut.scala 49:33]
        maybe_full <= UInt<1>("h0") @[dut.scala 50:18]
    node _io_count_T = sub(enq_ptr, deq_ptr) @[dut.scala 65:52]
    node _io_count_T_1 = tail(_io_count_T, 1) @[dut.scala 65:52]
    node _io_count_T_2 = mux(maybe_full, UInt<5>("h10"), _io_count_T_1) @[dut.scala 65:20]
    io.count <= _io_count_T_2 @[dut.scala 65:14]

