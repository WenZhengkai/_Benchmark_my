circuit dut :
  module Queue :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, count : UInt<3>}

    cmem ram : UInt<8> [5] @[Decoupled.scala 273:95]
    reg enq_ptr_value : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Counter.scala 61:40]
    reg deq_ptr_value : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Counter.scala 61:40]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 276:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 277:33]
    node _empty_T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 278:28]
    node empty = and(ptr_match, _empty_T) @[Decoupled.scala 278:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 279:24]
    node _do_enq_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 51:35]
    wire do_enq : UInt<1> @[Decoupled.scala 280:27]
    do_enq <= _do_enq_T @[Decoupled.scala 280:27]
    node _do_deq_T = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 51:35]
    wire do_deq : UInt<1> @[Decoupled.scala 281:27]
    do_deq <= _do_deq_T @[Decoupled.scala 281:27]
    when do_enq : @[Decoupled.scala 286:16]
      infer mport MPORT = ram[enq_ptr_value], clock @[Decoupled.scala 287:8]
      MPORT <= io.enq.bits @[Decoupled.scala 287:24]
      node wrap = eq(enq_ptr_value, UInt<3>("h4")) @[Counter.scala 73:24]
      node _value_T = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 77:24]
      node _value_T_1 = tail(_value_T, 1) @[Counter.scala 77:24]
      enq_ptr_value <= _value_T_1 @[Counter.scala 77:15]
      when wrap : @[Counter.scala 87:20]
        enq_ptr_value <= UInt<1>("h0") @[Counter.scala 87:28]
    when do_deq : @[Decoupled.scala 290:16]
      node wrap_1 = eq(deq_ptr_value, UInt<3>("h4")) @[Counter.scala 73:24]
      node _value_T_2 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 77:24]
      node _value_T_3 = tail(_value_T_2, 1) @[Counter.scala 77:24]
      deq_ptr_value <= _value_T_3 @[Counter.scala 77:15]
      when wrap_1 : @[Counter.scala 87:20]
        deq_ptr_value <= UInt<1>("h0") @[Counter.scala 87:28]
    node _T = neq(do_enq, do_deq) @[Decoupled.scala 293:15]
    when _T : @[Decoupled.scala 293:27]
      maybe_full <= do_enq @[Decoupled.scala 294:16]
    when UInt<1>("h0") : @[Decoupled.scala 296:15]
      enq_ptr_value <= UInt<1>("h0") @[Counter.scala 98:11]
      deq_ptr_value <= UInt<1>("h0") @[Counter.scala 98:11]
      maybe_full <= UInt<1>("h0") @[Decoupled.scala 299:16]
    node _io_deq_valid_T = eq(empty, UInt<1>("h0")) @[Decoupled.scala 302:19]
    io.deq.valid <= _io_deq_valid_T @[Decoupled.scala 302:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h0")) @[Decoupled.scala 303:19]
    io.enq.ready <= _io_enq_ready_T @[Decoupled.scala 303:16]
    infer mport io_deq_bits_MPORT = ram[deq_ptr_value], clock @[Decoupled.scala 310:23]
    io.deq.bits <= io_deq_bits_MPORT @[Decoupled.scala 310:17]
    node _ptr_diff_T = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 326:32]
    node ptr_diff = tail(_ptr_diff_T, 1) @[Decoupled.scala 326:32]
    node _io_count_T = mux(maybe_full, UInt<3>("h5"), UInt<1>("h0")) @[Decoupled.scala 333:10]
    node _io_count_T_1 = gt(deq_ptr_value, enq_ptr_value) @[Decoupled.scala 334:25]
    node _io_count_T_2 = add(UInt<3>("h5"), ptr_diff) @[Decoupled.scala 334:57]
    node _io_count_T_3 = tail(_io_count_T_2, 1) @[Decoupled.scala 334:57]
    node _io_count_T_4 = mux(_io_count_T_1, _io_count_T_3, ptr_diff) @[Decoupled.scala 334:10]
    node _io_count_T_5 = mux(ptr_match, _io_count_T, _io_count_T_4) @[Decoupled.scala 331:20]
    io.count <= _io_count_T_5 @[Decoupled.scala 331:14]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { valid : UInt<1>, flip credit : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, fifoCount : UInt<3>}

    inst outFifo of Queue @[dut.scala 18:23]
    outFifo.clock <= clock
    outFifo.reset <= reset
    reg ivalid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:23]
    ivalid <= io.enq.valid @[dut.scala 21:23]
    reg idata : UInt<8>, clock with :
      reset => (UInt<1>("h0"), idata) @[Reg.scala 19:16]
    when io.enq.valid : @[Reg.scala 20:18]
      idata <= io.enq.bits @[Reg.scala 20:22]
    reg ocredit : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    wire nextCredit : UInt<1> @[dut.scala 26:28]
    nextCredit <= UInt<1>("h0") @[dut.scala 26:28]
    node _outFifo_io_enq_valid_T = mux(io.deq.ready, UInt<1>("h0"), ivalid) @[dut.scala 29:30]
    outFifo.io.enq.valid <= _outFifo_io_enq_valid_T @[dut.scala 29:24]
    outFifo.io.enq.bits <= idata @[dut.scala 30:23]
    node _io_deq_valid_T = eq(outFifo.io.deq.valid, UInt<1>("h0")) @[dut.scala 33:23]
    node _io_deq_valid_T_1 = eq(outFifo.io.count, UInt<1>("h0")) @[dut.scala 33:65]
    node _io_deq_valid_T_2 = and(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 33:45]
    node _io_deq_valid_T_3 = mux(_io_deq_valid_T_2, ivalid, outFifo.io.deq.valid) @[dut.scala 33:22]
    io.deq.valid <= _io_deq_valid_T_3 @[dut.scala 33:16]
    node _io_deq_bits_T = eq(outFifo.io.deq.valid, UInt<1>("h0")) @[dut.scala 34:22]
    node _io_deq_bits_T_1 = eq(outFifo.io.count, UInt<1>("h0")) @[dut.scala 34:64]
    node _io_deq_bits_T_2 = and(_io_deq_bits_T, _io_deq_bits_T_1) @[dut.scala 34:44]
    node _io_deq_bits_T_3 = mux(_io_deq_bits_T_2, idata, outFifo.io.deq.bits) @[dut.scala 34:21]
    io.deq.bits <= _io_deq_bits_T_3 @[dut.scala 34:15]
    node _outFifo_io_deq_ready_T = and(io.deq.ready, outFifo.io.deq.valid) @[dut.scala 35:40]
    outFifo.io.deq.ready <= _outFifo_io_deq_ready_T @[dut.scala 35:24]
    node _nextCredit_T = eq(outFifo.io.deq.valid, UInt<1>("h0")) @[dut.scala 38:21]
    node _nextCredit_T_1 = eq(outFifo.io.count, UInt<1>("h0")) @[dut.scala 38:63]
    node _nextCredit_T_2 = and(_nextCredit_T, _nextCredit_T_1) @[dut.scala 38:43]
    node _nextCredit_T_3 = and(io.deq.ready, ivalid) @[dut.scala 38:85]
    node _nextCredit_T_4 = and(outFifo.io.deq.ready, outFifo.io.deq.valid) @[Decoupled.scala 51:35]
    node _nextCredit_T_5 = mux(_nextCredit_T_2, _nextCredit_T_3, _nextCredit_T_4) @[dut.scala 38:20]
    nextCredit <= _nextCredit_T_5 @[dut.scala 38:14]
    when io.deq.ready : @[dut.scala 39:22]
      ocredit <= nextCredit @[dut.scala 40:13]
    io.enq.credit <= ocredit @[dut.scala 42:17]
    io.fifoCount <= outFifo.io.count @[dut.scala 45:16]

