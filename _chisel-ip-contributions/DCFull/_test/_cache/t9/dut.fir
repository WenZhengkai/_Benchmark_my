circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:22]
    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[dut.scala 16:19]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[dut.scala 17:19]
    wire shift : UInt<1> @[dut.scala 20:19]
    wire load : UInt<1> @[dut.scala 21:18]
    wire sendSel : UInt<1> @[dut.scala 22:21]
    wire push_vld : UInt<1> @[dut.scala 23:22]
    wire pop_vld : UInt<1> @[dut.scala 24:21]
    node _push_vld_T = and(io.enq.valid, io.enq.ready) @[dut.scala 27:28]
    push_vld <= _push_vld_T @[dut.scala 27:12]
    node _pop_vld_T = and(io.deq.valid, io.deq.ready) @[dut.scala 28:27]
    pop_vld <= _pop_vld_T @[dut.scala 28:11]
    shift <= UInt<1>("h0") @[dut.scala 30:9]
    load <= UInt<1>("h0") @[dut.scala 31:8]
    sendSel <= UInt<1>("h0") @[dut.scala 32:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 34:17]
    when _T : @[dut.scala 34:17]
      when push_vld : @[dut.scala 36:22]
        load <= UInt<1>("h1") @[dut.scala 37:14]
        state <= UInt<2>("h1") @[dut.scala 38:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 34:17]
      when _T_1 : @[dut.scala 34:17]
        node _T_2 = and(push_vld, pop_vld) @[dut.scala 42:21]
        when _T_2 : @[dut.scala 42:33]
          shift <= UInt<1>("h1") @[dut.scala 43:15]
          load <= UInt<1>("h1") @[dut.scala 44:14]
          state <= UInt<2>("h1") @[dut.scala 45:15]
        else :
          when push_vld : @[dut.scala 46:28]
            load <= UInt<1>("h1") @[dut.scala 47:14]
            state <= UInt<2>("h3") @[dut.scala 48:15]
          else :
            when pop_vld : @[dut.scala 49:27]
              shift <= UInt<1>("h1") @[dut.scala 50:15]
              state <= UInt<2>("h0") @[dut.scala 51:15]
      else :
        node _T_3 = eq(UInt<2>("h2"), state) @[dut.scala 34:17]
        when _T_3 : @[dut.scala 34:17]
          node _T_4 = and(push_vld, pop_vld) @[dut.scala 55:21]
          when _T_4 : @[dut.scala 55:33]
            load <= UInt<1>("h1") @[dut.scala 56:14]
            shift <= UInt<1>("h1") @[dut.scala 57:15]
            state <= UInt<2>("h1") @[dut.scala 58:15]
          else :
            when push_vld : @[dut.scala 59:28]
              state <= UInt<2>("h3") @[dut.scala 60:15]
              shift <= UInt<1>("h1") @[dut.scala 61:15]
            else :
              when pop_vld : @[dut.scala 62:27]
                state <= UInt<2>("h0") @[dut.scala 63:15]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 34:17]
          when _T_5 : @[dut.scala 34:17]
            when pop_vld : @[dut.scala 67:21]
              shift <= UInt<1>("h1") @[dut.scala 68:15]
              state <= UInt<2>("h1") @[dut.scala 69:15]
    when load : @[dut.scala 75:14]
      hold_1 <= io.enq.bits @[dut.scala 76:12]
    when shift : @[dut.scala 78:15]
      hold_0 <= hold_1 @[dut.scala 79:12]
    node _sendSel_T = eq(state, UInt<2>("h2")) @[dut.scala 83:20]
    node _sendSel_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 83:39]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 83:30]
    sendSel <= _sendSel_T_2 @[dut.scala 83:11]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 84:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 84:15]
    node _io_enq_ready_T = eq(state, UInt<2>("h0")) @[dut.scala 87:25]
    node _io_enq_ready_T_1 = eq(state, UInt<2>("h1")) @[dut.scala 87:44]
    node _io_enq_ready_T_2 = or(_io_enq_ready_T, _io_enq_ready_T_1) @[dut.scala 87:35]
    node _io_enq_ready_T_3 = eq(state, UInt<2>("h2")) @[dut.scala 87:63]
    node _io_enq_ready_T_4 = or(_io_enq_ready_T_2, _io_enq_ready_T_3) @[dut.scala 87:54]
    io.enq.ready <= _io_enq_ready_T_4 @[dut.scala 87:16]
    node _io_deq_valid_T = eq(state, UInt<2>("h1")) @[dut.scala 88:25]
    node _io_deq_valid_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 88:44]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 88:35]
    node _io_deq_valid_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 88:63]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 88:54]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 88:16]

