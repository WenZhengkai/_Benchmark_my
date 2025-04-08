circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 15:16]
    reg enqPtr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 18:23]
    reg deqPtr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:23]
    node ptrMatch = eq(enqPtr, deqPtr) @[dut.scala 20:25]
    reg maybeFull : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:26]
    node _empty_T = eq(maybeFull, UInt<1>("h0")) @[dut.scala 24:27]
    node empty = and(ptrMatch, _empty_T) @[dut.scala 24:24]
    node full = and(ptrMatch, maybeFull) @[dut.scala 25:23]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 28:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 28:16]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 29:23]
      write mport MPORT = ram[enqPtr], clock
      MPORT <= io.enq.bits
      node _enqPtr_T = add(enqPtr, UInt<1>("h1")) @[dut.scala 31:22]
      node _enqPtr_T_1 = tail(_enqPtr_T, 1) @[dut.scala 31:22]
      enqPtr <= _enqPtr_T_1 @[dut.scala 31:12]
      node _T_1 = eq(enqPtr, UInt<4>("hf")) @[dut.scala 32:17]
      when _T_1 : @[dut.scala 32:38]
        enqPtr <= UInt<1>("h0") @[dut.scala 33:14]
      node _T_2 = eq(io.deq.valid, UInt<1>("h0")) @[dut.scala 35:26]
      node _T_3 = and(io.deq.ready, _T_2) @[dut.scala 35:23]
      when _T_3 : @[dut.scala 35:41]
        maybeFull <= UInt<1>("h0") @[dut.scala 36:17]
      else :
        maybeFull <= UInt<1>("h1") @[dut.scala 38:17]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 43:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 43:16]
    read mport io_deq_bits_MPORT = ram[deqPtr], clock @[dut.scala 44:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 44:15]
    node _T_4 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when _T_4 : @[dut.scala 45:23]
      node _deqPtr_T = add(deqPtr, UInt<1>("h1")) @[dut.scala 46:22]
      node _deqPtr_T_1 = tail(_deqPtr_T, 1) @[dut.scala 46:22]
      deqPtr <= _deqPtr_T_1 @[dut.scala 46:12]
      node _T_5 = eq(deqPtr, UInt<4>("hf")) @[dut.scala 47:17]
      when _T_5 : @[dut.scala 47:38]
        deqPtr <= UInt<1>("h0") @[dut.scala 48:14]
      node _T_6 = eq(io.enq.ready, UInt<1>("h0")) @[dut.scala 50:26]
      node _T_7 = and(io.enq.valid, _T_6) @[dut.scala 50:23]
      when _T_7 : @[dut.scala 50:41]
        maybeFull <= UInt<1>("h1") @[dut.scala 51:17]
      else :
        maybeFull <= UInt<1>("h0") @[dut.scala 53:17]
    node _diff_T = sub(enqPtr, deqPtr) @[dut.scala 67:21]
    node diff = tail(_diff_T, 1) @[dut.scala 67:21]
    node _io_count_T = lt(diff, UInt<1>("h0")) @[dut.scala 68:50]
    node _io_count_T_1 = add(UInt<5>("h10"), diff) @[dut.scala 68:67]
    node _io_count_T_2 = tail(_io_count_T_1, 1) @[dut.scala 68:67]
    node _io_count_T_3 = mux(_io_count_T, _io_count_T_2, diff) @[dut.scala 68:44]
    node _io_count_T_4 = mux(maybeFull, UInt<5>("h10"), _io_count_T_3) @[dut.scala 68:18]
    io.count <= _io_count_T_4 @[dut.scala 68:12]

