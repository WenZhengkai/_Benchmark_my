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
    node full = and(ptr_match, maybe_full) @[dut.scala 28:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 29:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 29:25]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 32:29]
    when do_enq : @[dut.scala 33:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 35:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 35:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 35:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 35:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 35:13]
    node do_deq = and(io.deq.valid, io.deq.ready) @[dut.scala 39:29]
    when do_deq : @[dut.scala 40:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 41:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 41:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 41:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 41:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 41:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 45:15]
    when _T : @[dut.scala 45:27]
      maybe_full <= do_enq @[dut.scala 46:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 59:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 59:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 62:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 62:16]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 63:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 63:15]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 68:8]
    node _io_count_T_1 = gt(deq_ptr, enq_ptr) @[dut.scala 69:17]
    node _io_count_T_2 = add(UInt<5>("h10"), enq_ptr) @[dut.scala 69:38]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 69:38]
    node _io_count_T_4 = sub(_io_count_T_3, deq_ptr) @[dut.scala 69:48]
    node _io_count_T_5 = tail(_io_count_T_4, 1) @[dut.scala 69:48]
    node _io_count_T_6 = sub(enq_ptr, deq_ptr) @[dut.scala 69:67]
    node _io_count_T_7 = tail(_io_count_T_6, 1) @[dut.scala 69:67]
    node _io_count_T_8 = mux(_io_count_T_1, _io_count_T_5, _io_count_T_7) @[dut.scala 69:8]
    node _io_count_T_9 = mux(ptr_match, _io_count_T, _io_count_T_8) @[dut.scala 66:18]
    io.count <= _io_count_T_9 @[dut.scala 66:12]

