circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[dut.scala 17:19]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[dut.scala 18:19]
    wire shift : UInt<1> @[dut.scala 21:19]
    wire load : UInt<1> @[dut.scala 22:18]
    wire sendSel : UInt<1> @[dut.scala 23:21]
    node push_vld = and(io.enq.valid, io.enq.ready) @[dut.scala 26:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[dut.scala 27:31]
    shift <= UInt<1>("h0") @[dut.scala 30:9]
    load <= UInt<1>("h0") @[dut.scala 31:8]
    sendSel <= UInt<1>("h0") @[dut.scala 32:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 35:17]
    when _T : @[dut.scala 35:17]
      when push_vld : @[dut.scala 37:22]
        state <= UInt<2>("h1") @[dut.scala 38:15]
        load <= UInt<1>("h1") @[dut.scala 39:14]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 35:17]
      when _T_1 : @[dut.scala 35:17]
        node _T_2 = and(push_vld, pop_vld) @[dut.scala 43:21]
        when _T_2 : @[dut.scala 43:33]
          state <= UInt<2>("h1") @[dut.scala 44:15]
          load <= UInt<1>("h1") @[dut.scala 45:14]
          shift <= UInt<1>("h1") @[dut.scala 46:15]
        else :
          when push_vld : @[dut.scala 47:28]
            state <= UInt<2>("h3") @[dut.scala 48:15]
            load <= UInt<1>("h1") @[dut.scala 49:14]
          else :
            when pop_vld : @[dut.scala 50:27]
              state <= UInt<2>("h2") @[dut.scala 51:15]
              shift <= UInt<1>("h1") @[dut.scala 52:15]
      else :
        node _T_3 = eq(UInt<2>("h2"), state) @[dut.scala 35:17]
        when _T_3 : @[dut.scala 35:17]
          node _T_4 = and(push_vld, pop_vld) @[dut.scala 56:21]
          when _T_4 : @[dut.scala 56:33]
            state <= UInt<2>("h1") @[dut.scala 57:15]
            load <= UInt<1>("h1") @[dut.scala 58:14]
            shift <= UInt<1>("h1") @[dut.scala 59:15]
          else :
            when push_vld : @[dut.scala 60:28]
              state <= UInt<2>("h3") @[dut.scala 61:15]
              load <= UInt<1>("h1") @[dut.scala 62:14]
            else :
              when pop_vld : @[dut.scala 63:27]
                state <= UInt<2>("h0") @[dut.scala 64:15]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 35:17]
          when _T_5 : @[dut.scala 35:17]
            when pop_vld : @[dut.scala 68:21]
              state <= UInt<2>("h1") @[dut.scala 69:15]
              shift <= UInt<1>("h1") @[dut.scala 70:15]
    when load : @[dut.scala 76:14]
      hold_0 <= io.enq.bits @[dut.scala 77:12]
    when shift : @[dut.scala 79:15]
      hold_1 <= hold_0 @[dut.scala 80:12]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 84:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 84:15]
    node _sendSel_T = eq(state, UInt<2>("h2")) @[dut.scala 87:21]
    node _sendSel_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 87:40]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 87:31]
    sendSel <= _sendSel_T_2 @[dut.scala 87:11]
    node _io_enq_ready_T = neq(state, UInt<2>("h3")) @[dut.scala 90:25]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 90:16]
    node _io_deq_valid_T = neq(state, UInt<2>("h0")) @[dut.scala 91:25]
    io.deq.valid <= _io_deq_valid_T @[dut.scala 91:16]

