circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    wire _hold_0_WIRE : UInt<8> @[dut.scala 11:36]
    _hold_0_WIRE <= UInt<1>("h0") @[dut.scala 11:36]
    reg hold_0 : UInt, clock with :
      reset => (reset, _hold_0_WIRE) @[dut.scala 11:23]
    wire _hold_1_WIRE : UInt<8> @[dut.scala 12:36]
    _hold_1_WIRE <= UInt<1>("h0") @[dut.scala 12:36]
    reg hold_1 : UInt, clock with :
      reset => (reset, _hold_1_WIRE) @[dut.scala 12:23]
    wire push_vld : UInt<1> @[dut.scala 15:22]
    wire pop_vld : UInt<1> @[dut.scala 16:21]
    wire shift : UInt<1> @[dut.scala 17:19]
    wire load : UInt<1> @[dut.scala 18:18]
    wire sendSel : UInt<1> @[dut.scala 19:21]
    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 23:22]
    node _push_vld_T = and(io.enq.valid, io.enq.ready) @[dut.scala 26:28]
    push_vld <= _push_vld_T @[dut.scala 26:12]
    node _pop_vld_T = and(io.deq.valid, io.deq.ready) @[dut.scala 27:27]
    pop_vld <= _pop_vld_T @[dut.scala 27:11]
    node _shift_T = eq(state, UInt<2>("h1")) @[dut.scala 29:19]
    node _shift_T_1 = and(_shift_T, pop_vld) @[dut.scala 29:29]
    node _shift_T_2 = eq(state, UInt<2>("h3")) @[dut.scala 29:51]
    node _shift_T_3 = and(_shift_T_2, pop_vld) @[dut.scala 29:61]
    node _shift_T_4 = or(_shift_T_1, _shift_T_3) @[dut.scala 29:41]
    shift <= _shift_T_4 @[dut.scala 29:9]
    node _load_T = eq(state, UInt<2>("h0")) @[dut.scala 30:17]
    node _load_T_1 = and(_load_T, push_vld) @[dut.scala 30:27]
    load <= _load_T_1 @[dut.scala 30:8]
    node _io_enq_ready_T = eq(state, UInt<2>("h0")) @[dut.scala 32:25]
    node _io_enq_ready_T_1 = eq(state, UInt<2>("h1")) @[dut.scala 32:44]
    node _io_enq_ready_T_2 = or(_io_enq_ready_T, _io_enq_ready_T_1) @[dut.scala 32:35]
    io.enq.ready <= _io_enq_ready_T_2 @[dut.scala 32:16]
    node _io_deq_valid_T = eq(state, UInt<2>("h1")) @[dut.scala 33:25]
    node _io_deq_valid_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 33:44]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 33:35]
    node _io_deq_valid_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 33:63]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 33:54]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 33:16]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 36:17]
    when _T : @[dut.scala 36:17]
      when push_vld : @[dut.scala 38:22]
        state <= UInt<2>("h1") @[dut.scala 39:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 36:17]
      when _T_1 : @[dut.scala 36:17]
        node _T_2 = and(push_vld, pop_vld) @[dut.scala 43:21]
        when _T_2 : @[dut.scala 43:33]
          state <= UInt<2>("h1") @[dut.scala 44:15]
        else :
          when push_vld : @[dut.scala 45:28]
            state <= UInt<2>("h3") @[dut.scala 46:15]
          else :
            when pop_vld : @[dut.scala 47:27]
              state <= UInt<2>("h0") @[dut.scala 48:15]
      else :
        node _T_3 = eq(UInt<2>("h2"), state) @[dut.scala 36:17]
        when _T_3 : @[dut.scala 36:17]
          node _T_4 = and(push_vld, pop_vld) @[dut.scala 52:21]
          when _T_4 : @[dut.scala 52:33]
            state <= UInt<2>("h2") @[dut.scala 53:15]
          else :
            when push_vld : @[dut.scala 54:28]
              state <= UInt<2>("h1") @[dut.scala 55:15]
            else :
              when pop_vld : @[dut.scala 56:27]
                state <= UInt<2>("h0") @[dut.scala 57:15]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 36:17]
          when _T_5 : @[dut.scala 36:17]
            when pop_vld : @[dut.scala 61:21]
              state <= UInt<2>("h1") @[dut.scala 62:15]
    when load : @[dut.scala 68:14]
      hold_1 <= io.enq.bits @[dut.scala 69:12]
    when shift : @[dut.scala 71:15]
      hold_0 <= hold_1 @[dut.scala 72:12]
    node _sendSel_T = eq(state, UInt<2>("h2")) @[dut.scala 76:21]
    node _sendSel_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 76:42]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 76:32]
    sendSel <= _sendSel_T_2 @[dut.scala 76:11]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 77:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 77:15]

