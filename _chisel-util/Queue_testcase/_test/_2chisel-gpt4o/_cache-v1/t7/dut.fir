circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 16:16]
    reg enqPtr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 17:23]
    reg deqPtr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 18:23]
    reg maybeFull : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:26]
    node ptrMatch = eq(enqPtr, deqPtr) @[dut.scala 21:25]
    node _empty_T = eq(maybeFull, UInt<1>("h0")) @[dut.scala 22:27]
    node empty = and(ptrMatch, _empty_T) @[dut.scala 22:24]
    node full = and(ptrMatch, maybeFull) @[dut.scala 23:23]
    node doEnq = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when doEnq : @[dut.scala 27:15]
      infer mport MPORT = ram[enqPtr], clock @[dut.scala 28:8]
      MPORT <= io.enq.bits @[dut.scala 28:17]
      node _enqPtr_T = add(enqPtr, UInt<1>("h1")) @[dut.scala 29:22]
      node _enqPtr_T_1 = tail(_enqPtr_T, 1) @[dut.scala 29:22]
      enqPtr <= _enqPtr_T_1 @[dut.scala 29:12]
      node _T = eq(enqPtr, UInt<4>("hf")) @[dut.scala 30:17]
      when _T : @[dut.scala 30:38]
        maybeFull <= UInt<1>("h1") @[dut.scala 31:17]
    node doDeq = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 37:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 37:16]
    infer mport io_deq_bits_MPORT = ram[deqPtr], clock @[dut.scala 38:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 38:15]
    when doDeq : @[dut.scala 39:15]
      node _deqPtr_T = add(deqPtr, UInt<1>("h1")) @[dut.scala 40:22]
      node _deqPtr_T_1 = tail(_deqPtr_T, 1) @[dut.scala 40:22]
      deqPtr <= _deqPtr_T_1 @[dut.scala 40:12]
      node _T_1 = eq(deqPtr, UInt<4>("hf")) @[dut.scala 41:17]
      when _T_1 : @[dut.scala 41:38]
        maybeFull <= UInt<1>("h0") @[dut.scala 42:17]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 46:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 46:16]
    node _ptrDiff_T = sub(enqPtr, deqPtr) @[dut.scala 58:24]
    node ptrDiff = tail(_ptrDiff_T, 1) @[dut.scala 58:24]
    node _io_count_T = mux(maybeFull, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 59:32]
    node _io_count_T_1 = gt(deqPtr, enqPtr) @[dut.scala 59:72]
    node _io_count_T_2 = add(UInt<5>("h10"), ptrDiff) @[dut.scala 59:92]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 59:92]
    node _io_count_T_4 = mux(_io_count_T_1, _io_count_T_3, ptrDiff) @[dut.scala 59:64]
    node _io_count_T_5 = mux(ptrMatch, _io_count_T, _io_count_T_4) @[dut.scala 59:18]
    io.count <= _io_count_T_5 @[dut.scala 59:12]

