circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<5>}

    cmem ram : UInt<8> [16] @[dut.scala 20:16]
    reg enq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 23:24]
    reg deq_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 24:24]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:27]
    node ptr_match = eq(enq_ptr, deq_ptr) @[dut.scala 27:27]
    node full = and(ptr_match, maybe_full) @[dut.scala 30:24]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[dut.scala 31:28]
    node empty = and(ptr_match, _empty_T) @[dut.scala 31:25]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[dut.scala 33:19]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 33:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[dut.scala 34:19]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 34:16]
    node do_enq = and(io.enq.valid, io.enq.ready) @[dut.scala 37:29]
    when do_enq : @[dut.scala 38:16]
      write mport MPORT = ram[enq_ptr], clock
      MPORT <= io.enq.bits
      node _enq_ptr_T = add(enq_ptr, UInt<1>("h1")) @[dut.scala 40:24]
      node _enq_ptr_T_1 = tail(_enq_ptr_T, 1) @[dut.scala 40:24]
      enq_ptr <= _enq_ptr_T_1 @[dut.scala 40:13]
      node _T = eq(enq_ptr, UInt<4>("hf")) @[dut.scala 41:18]
      when _T : @[dut.scala 41:39]
        enq_ptr <= UInt<1>("h0") @[dut.scala 42:15]
    node do_deq = and(io.deq.ready, io.deq.valid) @[dut.scala 47:29]
    when do_deq : @[dut.scala 48:16]
      node _deq_ptr_T = add(deq_ptr, UInt<1>("h1")) @[dut.scala 49:24]
      node _deq_ptr_T_1 = tail(_deq_ptr_T, 1) @[dut.scala 49:24]
      deq_ptr <= _deq_ptr_T_1 @[dut.scala 49:13]
      node _T_1 = eq(deq_ptr, UInt<4>("hf")) @[dut.scala 50:18]
      when _T_1 : @[dut.scala 50:39]
        deq_ptr <= UInt<1>("h0") @[dut.scala 51:15]
    node _T_2 = eq(do_deq, UInt<1>("h0")) @[dut.scala 56:18]
    node _T_3 = and(do_enq, _T_2) @[dut.scala 56:15]
    when _T_3 : @[dut.scala 56:27]
      maybe_full <= UInt<1>("h1") @[dut.scala 57:16]
    else :
      node _T_4 = eq(do_enq, UInt<1>("h0")) @[dut.scala 58:14]
      node _T_5 = and(_T_4, do_deq) @[dut.scala 58:22]
      when _T_5 : @[dut.scala 58:33]
        maybe_full <= UInt<1>("h0") @[dut.scala 59:16]
    node _io_count_diff_T = sub(enq_ptr, deq_ptr) @[dut.scala 73:24]
    node io_count_diff = tail(_io_count_diff_T, 1) @[dut.scala 73:24]
    node _io_count_T = mux(maybe_full, UInt<5>("h10"), UInt<1>("h0")) @[dut.scala 74:23]
    node _io_count_T_1 = gt(enq_ptr, deq_ptr) @[dut.scala 74:65]
    node _io_count_T_2 = sub(UInt<5>("h10"), io_count_diff) @[dut.scala 74:92]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[dut.scala 74:92]
    node _io_count_T_4 = mux(_io_count_T_1, io_count_diff, _io_count_T_3) @[dut.scala 74:56]
    node _io_count_T_5 = mux(ptr_match, _io_count_T, _io_count_T_4) @[dut.scala 74:8]
    io.count <= _io_count_T_5 @[dut.scala 72:12]
    read mport io_deq_bits_MPORT = ram[deq_ptr], clock @[dut.scala 78:26]
    io.deq.bits <= io_deq_bits_MPORT @[dut.scala 78:15]

