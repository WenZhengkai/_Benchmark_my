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
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 23:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 26:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 27:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 27:25]
    node _do_enq_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    wire do_enq : UInt<1> @[dut.scala 30:27]
    do_enq <= _do_enq_T @[dut.scala 30:27]
    node _do_deq_T = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    wire do_deq : UInt<1> @[dut.scala 31:27]
    do_deq <= _do_deq_T @[dut.scala 31:27]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 34:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 34:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 35:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 35:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 38:21]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 38:15]
    when do_enq : @[dut.scala 41:16]
      infer mport MPORT = ram[enq_ptr], clock @[dut.scala 42:8]
      MPORT <= io.enq.bits @[dut.scala 42:18]
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 43:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 43:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 43:13]
    when do_deq : @[dut.scala 47:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 48:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 48:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 48:13]
    node _T = neq(do_enq, do_deq) @[dut.scala 52:15]
    when _T : @[dut.scala 52:27]
      maybe_full <= do_enq @[dut.scala 53:16]
    node _ptr_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 66:26]
    node ptr_diff = tail(_ptr_diff_T, 1) @[dut.scala 66:26]
    wire count : UInt<5> @[dut.scala 67:26]
    count <= UInt<5>("h0") @[dut.scala 67:26]
    node _T_1 = and(maybe_full, ptr_match) @[dut.scala 69:19]
    when _T_1 : @[dut.scala 69:33]
      count <= UInt<5>("h10") @[dut.scala 70:11]
    else :
      when ptr_match : @[dut.scala 71:25]
        count <= UInt<1>("h0") @[dut.scala 72:11]
      else :
        node _T_2 = gt(enq_ptr, deq_ptr) @[dut.scala 73:22]
        when _T_2 : @[dut.scala 73:33]
          count <= ptr_diff @[dut.scala 74:11]
        else :
          count <= ptr_diff @[dut.scala 79:13]
    io.count <= count @[dut.scala 85:12]

