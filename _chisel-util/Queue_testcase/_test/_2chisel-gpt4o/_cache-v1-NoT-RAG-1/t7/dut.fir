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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 22:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 25:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 26:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 26:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 28:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 28:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 29:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 29:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 32:29]
    when do_enq : @[dut.scala 33:17]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 34:8]
      MPORT <= io.enq.bits @[dut.scala 34:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 35:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 35:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 35:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 35:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 35:13]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 39:29]
    when do_deq : @[dut.scala 40:17]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 41:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 41:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 41:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 41:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 41:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 45:16]
    when _T : @[dut.scala 45:28]
      maybe_full <= do_enq @[dut.scala 46:16]
    wire count : UInt<5> @[dut.scala 59:19]
    when ptr_match : @[dut.scala 60:20]
      node _count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 61:17]
      count <= _count_T @[dut.scala 61:11]
    else :
      node _T_1 = gt(enq_ptr, deq_ptr) @[dut.scala 62:22]
      when _T_1 : @[dut.scala 62:33]
        node _count_T_1 = sub(enq_ptr, deq_ptr) @[dut.scala 63:22]
        node _count_T_2 = tail(_count_T_1, 1) @[dut.scala 63:22]
        count <= _count_T_2 @[dut.scala 63:11]
      else :
        node _count_T_3 = sub(UInt<5>("h10"), deq_ptr) @[dut.scala 65:24]
        node _count_T_4 = tail(_count_T_3, 1) @[dut.scala 65:24]
        node _count_T_5 = add(_count_T_4, enq_ptr) @[dut.scala 65:34]
        node _count_T_6 = tail(_count_T_5, 1) @[dut.scala 65:34]
        count <= _count_T_6 @[dut.scala 65:11]
    io.count <= count @[dut.scala 67:12]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 70:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 70:15]

