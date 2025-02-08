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
    node _T = and(io.enq.valid, io.enq.ready) @[dut.scala 29:21]
    when _T : @[dut.scala 29:38]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 30:8]
      MPORT <= io.enq.bits @[dut.scala 30:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 31:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 31:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 31:13]
      node _T_1 = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 32:18]
      when _T_1 : @[dut.scala 32:39]
        enq_ptr <= UInt<1>("h0") @[dut.scala 33:15]
      node _T_2 = eq(enq_ptr, deq_ptr) @[dut.scala 22:34]
      when _T_2 : @[dut.scala 35:20]
        maybe_full <= UInt<1>("h1") @[dut.scala 36:18]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 41:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 41:15]
    node _io_deq_valid_T = eq(enq_ptr, deq_ptr) @[dut.scala 22:34]
    node _io_deq_valid_T_1 = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:35]
    node _io_deq_valid_T_2 = and(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 25:32]
    node _io_deq_valid_T_3 = eq(_io_deq_valid_T_2, UInt<1>("h0")) @[dut.scala 42:19]
    io.deq.valid <= _io_deq_valid_T_3 @[dut.scala 42:16]
    node _T_3 = and(io.deq.ready, io.deq.valid) @[dut.scala 43:21]
    when _T_3 : @[dut.scala 43:38]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 44:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 44:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 44:13]
      node _T_4 = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 45:18]
      when _T_4 : @[dut.scala 45:39]
        deq_ptr <= UInt<1>("h0") @[dut.scala 46:15]
      node _T_5 = eq(enq_ptr, deq_ptr) @[dut.scala 22:34]
      when _T_5 : @[dut.scala 48:20]
        maybe_full <= UInt<1>("h0") @[dut.scala 49:18]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 63:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 63:26]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), ptr_diff) @[dut.scala 64:18]
    io.count <= _io_count_T @[dut.scala 64:12]
    node _io_enq_ready_T = eq(enq_ptr, deq_ptr) @[dut.scala 22:34]
    node _io_enq_ready_T_1 = and(_io_enq_ready_T, maybe_full) @[dut.scala 26:31]
    node _io_enq_ready_T_2 = eq(_io_enq_ready_T_1, UInt<1>("h0")) @[dut.scala 67:19]
    io.enq.ready <= _io_enq_ready_T_2 @[dut.scala 67:16]

