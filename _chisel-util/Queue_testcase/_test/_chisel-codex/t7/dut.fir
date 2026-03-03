circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 9:16]
    reg enq_ptr_value : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[Counter.scala 61:40]
    reg deq_ptr_value : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[Counter.scala 61:40]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 13:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[dut.scala 15:33]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 16:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 16:25]
    node full = and(ptr_match, maybe_full) @[dut.scala 17:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 19:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 19:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 20:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 20:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr_value], clock @[dut.scala 21:22]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 21:16]
    node do_enq = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    node do_deq = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    when do_enq : @[dut.scala 26:16]
      infer mport MPORT = ram[enq_ptr_value], clock @[dut.scala 27:8]
      MPORT <= io.enq.bits @[dut.scala 27:24]
      node wrap = eq(enq_ptr_value, UInt<4>("hf")) @[Counter.scala 73:24]
      node _value_T = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 77:24]
      node _value_T_1 = tail(_value_T, 1) @[Counter.scala 77:24]
      enq_ptr_value <= _value_T_1 @[Counter.scala 77:15]
    when do_deq : @[dut.scala 31:16]
      node wrap_1 = eq(deq_ptr_value, UInt<4>("hf")) @[Counter.scala 73:24]
      node _value_T_2 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 77:24]
      node _value_T_3 = tail(_value_T_2, 1) @[Counter.scala 77:24]
      deq_ptr_value <= _value_T_3 @[Counter.scala 77:15]
    node _T = neq(do_enq, do_deq) @[dut.scala 35:15]
    when _T : @[dut.scala 35:27]
      maybe_full <= do_enq @[dut.scala 36:16]
    node _ptr_diff_T = sub(enq_ptr_value, deq_ptr_value) @[dut.scala 47:32]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 47:32]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 49:35]
    node _io_count_T_1 = mux(ptr_match, _io_count_T, ptr_diff) @[dut.scala 49:20]
    io.count <= _io_count_T_1 @[dut.scala 49:14]

