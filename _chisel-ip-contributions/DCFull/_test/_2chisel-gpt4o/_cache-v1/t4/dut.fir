circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:22]
    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[dut.scala 15:19]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[dut.scala 16:19]
    wire shift : UInt<1> @[dut.scala 19:26]
    shift <= UInt<1>("h0") @[dut.scala 19:26]
    wire load : UInt<1> @[dut.scala 20:25]
    load <= UInt<1>("h0") @[dut.scala 20:25]
    wire sendSel : UInt<1> @[dut.scala 21:28]
    sendSel <= UInt<1>("h0") @[dut.scala 21:28]
    node push_vld = and(io.enq.valid, io.enq.ready) @[dut.scala 24:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[dut.scala 25:30]
    io.enq.ready <= UInt<1>("h0") @[dut.scala 28:16]
    io.deq.valid <= UInt<1>("h0") @[dut.scala 29:16]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 32:17]
    when _T : @[dut.scala 32:17]
      io.enq.ready <= UInt<1>("h1") @[dut.scala 34:20]
      when push_vld : @[dut.scala 35:22]
        hold_1 <= io.enq.bits @[dut.scala 36:16]
        state <= UInt<2>("h1") @[dut.scala 37:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 32:17]
      when _T_1 : @[dut.scala 32:17]
        io.enq.ready <= UInt<1>("h1") @[dut.scala 41:20]
        when push_vld : @[dut.scala 42:22]
          hold_0 <= hold_1 @[dut.scala 43:16]
          hold_1 <= io.enq.bits @[dut.scala 44:16]
          state <= UInt<2>("h3") @[dut.scala 45:15]
        when pop_vld : @[dut.scala 47:21]
          state <= UInt<2>("h2") @[dut.scala 47:29]
      else :
        node _T_2 = eq(UInt<2>("h2"), state) @[dut.scala 32:17]
        when _T_2 : @[dut.scala 32:17]
          io.deq.valid <= UInt<1>("h1") @[dut.scala 50:20]
          sendSel <= UInt<1>("h1") @[dut.scala 51:15]
          when pop_vld : @[dut.scala 52:21]
            state <= UInt<2>("h0") @[dut.scala 53:15]
        else :
          node _T_3 = eq(UInt<2>("h3"), state) @[dut.scala 32:17]
          when _T_3 : @[dut.scala 32:17]
            io.enq.ready <= UInt<1>("h0") @[dut.scala 57:20]
            io.deq.valid <= UInt<1>("h1") @[dut.scala 58:20]
            sendSel <= UInt<1>("h0") @[dut.scala 59:15]
            when pop_vld : @[dut.scala 60:21]
              hold_1 <= hold_0 @[dut.scala 61:16]
              state <= UInt<2>("h1") @[dut.scala 62:15]
    node _io_deq_bits_T = mux(sendSel, hold_0, hold_1) @[dut.scala 68:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 68:15]

