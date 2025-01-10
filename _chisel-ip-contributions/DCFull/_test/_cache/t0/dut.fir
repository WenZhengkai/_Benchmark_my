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
    node push_vld = and(io.enq.valid, io.enq.ready) @[dut.scala 19:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[dut.scala 20:30]
    wire sendSel : UInt<1> @[dut.scala 21:21]
    wire shift : UInt<1> @[dut.scala 22:19]
    wire load : UInt<1> @[dut.scala 23:18]
    io.enq.ready <= UInt<1>("h0") @[dut.scala 26:16]
    io.deq.valid <= UInt<1>("h0") @[dut.scala 27:16]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 28:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 28:15]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 31:17]
    when _T : @[dut.scala 31:17]
      io.enq.ready <= UInt<1>("h1") @[dut.scala 33:20]
      when push_vld : @[dut.scala 34:22]
        state <= UInt<2>("h1") @[dut.scala 35:15]
        hold_0 <= io.enq.bits @[dut.scala 36:16]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 31:17]
      when _T_1 : @[dut.scala 31:17]
        io.enq.ready <= UInt<1>("h1") @[dut.scala 40:20]
        io.deq.valid <= UInt<1>("h1") @[dut.scala 41:20]
        node _T_2 = eq(pop_vld, UInt<1>("h0")) @[dut.scala 42:24]
        node _T_3 = and(push_vld, _T_2) @[dut.scala 42:21]
        when _T_3 : @[dut.scala 42:34]
          state <= UInt<2>("h3") @[dut.scala 43:15]
          hold_1 <= io.enq.bits @[dut.scala 44:16]
        else :
          node _T_4 = eq(push_vld, UInt<1>("h0")) @[dut.scala 45:18]
          node _T_5 = and(_T_4, pop_vld) @[dut.scala 45:28]
          when _T_5 : @[dut.scala 45:40]
            state <= UInt<2>("h0") @[dut.scala 46:15]
          else :
            node _T_6 = and(push_vld, pop_vld) @[dut.scala 47:27]
            when _T_6 : @[dut.scala 47:39]
              state <= UInt<2>("h1") @[dut.scala 48:15]
              hold_0 <= io.enq.bits @[dut.scala 49:16]
      else :
        node _T_7 = eq(UInt<2>("h2"), state) @[dut.scala 31:17]
        when _T_7 : @[dut.scala 31:17]
          io.deq.valid <= UInt<1>("h1") @[dut.scala 53:20]
          when pop_vld : @[dut.scala 54:21]
            state <= UInt<2>("h0") @[dut.scala 55:15]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 31:17]
          when _T_8 : @[dut.scala 31:17]
            io.deq.valid <= UInt<1>("h1") @[dut.scala 59:20]
            io.enq.ready <= UInt<1>("h0") @[dut.scala 60:20]
            when pop_vld : @[dut.scala 61:21]
              state <= UInt<2>("h2") @[dut.scala 62:15]
              hold_0 <= hold_1 @[dut.scala 63:16]
    node _sendSel_T = eq(state, UInt<2>("h3")) @[dut.scala 69:20]
    node _sendSel_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 69:39]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 69:30]
    sendSel <= _sendSel_T_2 @[dut.scala 69:11]
    node _load_T = eq(state, UInt<2>("h1")) @[dut.scala 72:29]
    node _load_T_1 = and(push_vld, _load_T) @[dut.scala 72:20]
    load <= _load_T_1 @[dut.scala 72:8]
    node _shift_T = eq(state, UInt<2>("h3")) @[dut.scala 73:29]
    node _shift_T_1 = and(pop_vld, _shift_T) @[dut.scala 73:20]
    shift <= _shift_T_1 @[dut.scala 73:9]
    when load : @[dut.scala 76:14]
      hold_1 <= io.enq.bits @[dut.scala 77:12]
    when shift : @[dut.scala 81:15]
      hold_0 <= hold_1 @[dut.scala 82:12]


