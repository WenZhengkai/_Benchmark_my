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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 23:28]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 28:29]
    node do_deq = and(io.deq.valid, io.deq.ready) @[dut.scala 29:29]
    when do_enq : @[dut.scala 32:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 33:8]
      MPORT <= io.enq.bits @[dut.scala 33:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 34:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 34:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 34:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 34:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 34:13]
    when do_deq : @[dut.scala 38:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 39:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 39:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 39:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 39:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 39:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 43:15]
    when _T : @[dut.scala 43:27]
      maybe_full <= do_enq @[dut.scala 44:16]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 57:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 57:26]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 59:8]
    node _io_count_T_1 = gt(enq_ptr, deq_ptr) @[dut.scala 60:17]
    node _io_count_T_2 = add(UInt<5>("h10"), ptr_diff) @[dut.scala 60:48]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 60:48]
    node _io_count_T_4 = mux(_io_count_T_1, ptr_diff, _io_count_T_3) @[dut.scala 60:8]
    node _io_count_T_5 = mux(ptr_match, _io_count_T, _io_count_T_4) @[dut.scala 58:18]
    io.count <= _io_count_T_5 @[dut.scala 58:12]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 64:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 64:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 65:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 65:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 66:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 66:15]

