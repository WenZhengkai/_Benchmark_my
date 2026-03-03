circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 11:22]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 12:26]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:26]
    reg maybeFull : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:26]
    node ptrMatch = eq(enq_ptr, deq_ptr) @[dut.scala 21:26]
    node _empty_T = eq(maybeFull, UInt<1>("h0")) @[dut.scala 22:30]
    node empty = and(ptrMatch, _empty_T) @[dut.scala 22:27]
    node full = and(ptrMatch, maybeFull) @[dut.scala 23:27]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 25:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 25:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 26:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 26:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 27:22]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 27:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 29:29]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 30:29]
    when do_enq : @[dut.scala 32:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 33:8]
      MPORT <= io.enq.bits @[dut.scala 33:18]
      node _enq_ptr_T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 18:18]
      node _enq_ptr_T_1 = add(enq_ptr, UInt<1>("h1")) @[dut.scala 18:48]
      node _enq_ptr_T_2 = tail(_enq_ptr_T_1, 1) @[dut.scala 18:48]
      node _enq_ptr_T_3 = mux(_enq_ptr_T, UInt<1>("h0"), _enq_ptr_T_2) @[dut.scala 18:13]
      enq_ptr <= _enq_ptr_T_3 @[dut.scala 34:13]
    when do_deq : @[dut.scala 37:16]
      node _deq_ptr_T = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 18:18]
      node _deq_ptr_T_1 = add(deq_ptr, UInt<1>("h1")) @[dut.scala 18:48]
      node _deq_ptr_T_2 = tail(_deq_ptr_T_1, 1) @[dut.scala 18:48]
      node _deq_ptr_T_3 = mux(_deq_ptr_T, UInt<1>("h0"), _deq_ptr_T_2) @[dut.scala 18:13]
      deq_ptr <= _deq_ptr_T_3 @[dut.scala 38:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 41:15]
    when _T : @[dut.scala 41:27]
      maybeFull <= do_enq @[dut.scala 42:15]
    wire countWire : UInt<5> @[dut.scala 54:23]
    node _wrappedDistance_T = cvt(deq_ptr) @[dut.scala 56:58]
    node _wrappedDistance_T_1 = asUInt(_wrappedDistance_T) @[dut.scala 56:63]
    node _wrappedDistance_T_2 = sub(UInt<5>("h10"), _wrappedDistance_T_1) @[dut.scala 56:48]
    node _wrappedDistance_T_3 = tail(_wrappedDistance_T_2, 1) @[dut.scala 56:48]
    node _wrappedDistance_T_4 = bits(_wrappedDistance_T_3, 4, 0) @[dut.scala 56:70]
    node _wrappedDistance_T_5 = add(_wrappedDistance_T_4, enq_ptr) @[dut.scala 56:88]
    node wrappedDistance = tail(_wrappedDistance_T_5, 1) @[dut.scala 56:88]
    node _linearDistance_T = sub(enq_ptr, deq_ptr) @[dut.scala 57:33]
    node linearDistance = tail(_linearDistance_T, 1) @[dut.scala 57:33]
    when ptrMatch : @[dut.scala 59:18]
      node _countWire_T = mux(maybeFull, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 60:21]
      countWire <= _countWire_T @[dut.scala 60:15]
    else :
      node _T_1 = gt(deq_ptr, enq_ptr) @[dut.scala 61:22]
      when _T_1 : @[dut.scala 61:33]
        countWire <= wrappedDistance @[dut.scala 62:15]
      else :
        countWire <= linearDistance @[dut.scala 64:15]
    io.count <= countWire @[dut.scala 67:12]

