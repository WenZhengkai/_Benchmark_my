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
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 25:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 26:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 27:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 27:25]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 30:29]
    node do_deq = and(io.deq.valid, io.deq.ready) @[dut.scala 31:29]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 34:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 34:26]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 36:8]
    node _io_count_T_1 = gt(enq_ptr, deq_ptr) @[dut.scala 37:17]
    node _io_count_T_2 = add(UInt<5>("h10"), ptr_diff) @[dut.scala 37:48]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 37:48]
    node _io_count_T_4 = mux(_io_count_T_1, ptr_diff, _io_count_T_3) @[dut.scala 37:8]
    node _io_count_T_5 = mux(ptr_match, _io_count_T, _io_count_T_4) @[dut.scala 35:18]
    io.count <= _io_count_T_5 @[dut.scala 35:12]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 41:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 41:16]
    when do_enq : @[dut.scala 42:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 44:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 44:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 44:13]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 48:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 48:16]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 49:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 49:15]
    when do_deq : @[dut.scala 50:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 51:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 51:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 51:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 55:15]
    when _T : @[dut.scala 55:27]
      maybe_full <= do_enq @[dut.scala 56:16]


