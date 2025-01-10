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
    wire shift : UInt<1> @[dut.scala 19:19]
    wire load : UInt<1> @[dut.scala 20:18]
    wire sendSel : UInt<1> @[dut.scala 21:21]
    node push_vld = and(io.enq.valid, io.enq.ready) @[dut.scala 24:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[dut.scala 25:30]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 28:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 28:15]
    shift <= UInt<1>("h0") @[dut.scala 31:9]
    load <= UInt<1>("h0") @[dut.scala 32:8]
    sendSel <= UInt<1>("h0") @[dut.scala 33:11]
    io.deq.valid <= UInt<1>("h0") @[dut.scala 35:16]
    io.enq.ready <= UInt<1>("h0") @[dut.scala 36:16]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 38:17]
    when _T : @[dut.scala 38:17]
      io.enq.ready <= UInt<1>("h1") @[dut.scala 40:20]
      when push_vld : @[dut.scala 41:22]
        hold_1 <= io.enq.bits @[dut.scala 42:16]
        state <= UInt<2>("h2") @[dut.scala 43:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 38:17]
      when _T_1 : @[dut.scala 38:17]
        io.deq.valid <= UInt<1>("h1") @[dut.scala 48:20]
        sendSel <= UInt<1>("h0") @[dut.scala 49:15]
        when pop_vld : @[dut.scala 50:21]
          state <= UInt<2>("h0") @[dut.scala 51:15]
        else :
          when push_vld : @[dut.scala 52:28]
            hold_1 <= io.enq.bits @[dut.scala 53:16]
            state <= UInt<2>("h3") @[dut.scala 54:15]
      else :
        node _T_2 = eq(UInt<2>("h2"), state) @[dut.scala 38:17]
        when _T_2 : @[dut.scala 38:17]
          io.deq.valid <= UInt<1>("h1") @[dut.scala 59:20]
          sendSel <= UInt<1>("h1") @[dut.scala 60:15]
          when pop_vld : @[dut.scala 61:21]
            state <= UInt<2>("h0") @[dut.scala 62:15]
          else :
            when push_vld : @[dut.scala 63:28]
              hold_0 <= io.enq.bits @[dut.scala 64:16]
              state <= UInt<2>("h3") @[dut.scala 65:15]
        else :
          node _T_3 = eq(UInt<2>("h3"), state) @[dut.scala 38:17]
          when _T_3 : @[dut.scala 38:17]
            io.deq.valid <= UInt<1>("h1") @[dut.scala 70:20]
            sendSel <= UInt<1>("h1") @[dut.scala 71:15]
            when pop_vld : @[dut.scala 72:21]
              hold_0 <= hold_1 @[dut.scala 73:16]
              io.enq.ready <= UInt<1>("h1") @[dut.scala 74:22]
              when push_vld : @[dut.scala 75:24]
                hold_1 <= io.enq.bits @[dut.scala 76:18]
              else :
                state <= UInt<2>("h1") @[dut.scala 78:17]


