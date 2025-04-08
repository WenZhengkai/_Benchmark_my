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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 21:28]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 26:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 26:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 27:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 27:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 30:29]
    when do_enq : @[dut.scala 31:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 33:28]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 33:62]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 33:62]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 33:19]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 33:13]
    node _T = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 37:18]
    node _T_2 = and(do_enq, _T_1) @[dut.scala 37:15]
    when _T_2 : @[dut.scala 37:34]
      maybe_full <= UInt<1>("h1") @[dut.scala 38:16]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 42:29]
    when do_deq : @[dut.scala 43:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 44:28]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 44:62]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 44:62]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 44:19]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 44:13]
    node _T_3 = eq(do_enq, UInt<1>("h0")) @[dut.scala 48:18]
    node _T_4 = and(do_deq, _T_3) @[dut.scala 48:15]
    when _T_4 : @[dut.scala 48:27]
      maybe_full <= UInt<1>("h0") @[dut.scala 49:16]
    wire count : UInt<5> @[dut.scala 62:19]
    node _count_T = sub(enq_ptr, deq_ptr) @[dut.scala 64:49]
    node _count_T_1 = tail(_count_T, 1) @[dut.scala 64:49]
    node _count_T_2 = mux(maybe_full, UInt<5>("h10"), _count_T_1) @[dut.scala 64:17]
    count <= _count_T_2 @[dut.scala 64:11]
    io.count <= count @[dut.scala 69:12]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 72:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 72:15]

