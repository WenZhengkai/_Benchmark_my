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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 20:27]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 24:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 25:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 25:25]
    node _T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    when _T : @[dut.scala 28:23]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 29:8]
      MPORT <= io.enq.bits @[dut.scala 29:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 30:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 30:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 30:13]
      node _T_1 = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 31:18]
      when _T_1 : @[dut.scala 31:39]
        enq_ptr <= UInt<1>("h0") @[dut.scala 32:15]
      node _T_2 = eq(io.deq.ready, UInt<1>("h0")) @[dut.scala 34:23]
      when _T_2 : @[dut.scala 34:36]
        maybe_full <= UInt<1>("h1") @[dut.scala 35:18]
    wire _io_deq_bits_WIRE : UInt<8> @[dut.scala 40:30]
    _io_deq_bits_WIRE <= UInt<1>("h0") @[dut.scala 40:30]
    io.deq.bits <= _io_deq_bits_WIRE @[dut.scala 40:15]
    node _T_3 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when _T_3 : @[dut.scala 41:23]
      infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 42:23]
      io.deq.bits <= io_deq_bits_MPORT @[dut.scala 42:17]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 43:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 43:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 43:13]
      node _T_4 = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 44:18]
      when _T_4 : @[dut.scala 44:39]
        deq_ptr <= UInt<1>("h0") @[dut.scala 45:15]
      maybe_full <= UInt<1>("h0") @[dut.scala 47:16]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 60:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 60:26]
    node _io_count_T = and(maybe_full, ptr_match) @[dut.scala 61:30]
    node _io_count_T_1 = mux(_io_count_T, UInt<5>("h10"), ptr_diff) @[dut.scala 61:18]
    io.count <= _io_count_T_1 @[dut.scala 61:12]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 64:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 64:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 65:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 65:16]

