circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    cmem ram : UInt<8> [16] @[dut.scala 15:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 16:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 17:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 20:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 21:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 22:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 22:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 24:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 24:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 25:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 25:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 27:24]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 28:8]
      MPORT <= io.enq.bits @[dut.scala 28:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 29:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 29:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 29:13]
      node _T_1 = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 30:19]
      when _T_1 : @[dut.scala 30:38]
        enq_ptr <= UInt<1>("h0") @[dut.scala 31:15]
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when _T_2 : @[dut.scala 35:24]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 36:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 36:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 36:13]
      node _T_3 = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 37:19]
      when _T_3 : @[dut.scala 37:38]
        deq_ptr <= UInt<1>("h0") @[dut.scala 38:15]
    node do_enq = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node do_deq = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    node _T_4 = neq(do_enq, do_deq) @[dut.scala 45:16]
    when _T_4 : @[dut.scala 45:28]
      maybe_full <= do_enq @[dut.scala 46:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 49:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 49:15]
    node _T_5 = and(UInt<1>("h0"), UInt<1>("h0")) @[dut.scala 51:19]
    when _T_5 : @[dut.scala 51:51]
      enq_ptr <= UInt<1>("h0") @[dut.scala 52:13]
      deq_ptr <= UInt<1>("h0") @[dut.scala 53:13]
      maybe_full <= UInt<1>("h0") @[dut.scala 54:16]


