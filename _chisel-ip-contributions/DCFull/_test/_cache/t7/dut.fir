circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[dut.scala 11:19]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[dut.scala 12:19]
    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:22]
    wire shift : UInt<1> @[dut.scala 19:19]
    wire load : UInt<1> @[dut.scala 20:18]
    wire sendSel : UInt<1> @[dut.scala 21:21]
    wire push_vld : UInt<1> @[dut.scala 22:22]
    wire pop_vld : UInt<1> @[dut.scala 23:21]
    node _push_vld_T = and(io.enq.valid, io.enq.ready) @[dut.scala 26:28]
    push_vld <= _push_vld_T @[dut.scala 26:12]
    node _pop_vld_T = and(io.deq.valid, io.deq.ready) @[dut.scala 27:27]
    pop_vld <= _pop_vld_T @[dut.scala 27:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 30:17]
    when _T : @[dut.scala 30:17]
      when push_vld : @[dut.scala 32:22]
        state <= UInt<2>("h1") @[dut.scala 33:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 30:17]
      when _T_1 : @[dut.scala 30:17]
        when push_vld : @[dut.scala 37:22]
          state <= UInt<2>("h3") @[dut.scala 38:15]
        else :
          when pop_vld : @[dut.scala 39:27]
            state <= UInt<2>("h2") @[dut.scala 40:15]
      else :
        node _T_2 = eq(UInt<2>("h2"), state) @[dut.scala 30:17]
        when _T_2 : @[dut.scala 30:17]
          when pop_vld : @[dut.scala 44:21]
            state <= UInt<2>("h0") @[dut.scala 45:15]
        else :
          node _T_3 = eq(UInt<2>("h3"), state) @[dut.scala 30:17]
          when _T_3 : @[dut.scala 30:17]
            when pop_vld : @[dut.scala 49:21]
              state <= UInt<2>("h1") @[dut.scala 50:15]
    node _load_T = eq(state, UInt<2>("h0")) @[dut.scala 56:18]
    node _load_T_1 = and(_load_T, push_vld) @[dut.scala 56:28]
    load <= _load_T_1 @[dut.scala 56:8]
    node _shift_T = eq(state, UInt<2>("h1")) @[dut.scala 57:19]
    node _shift_T_1 = and(_shift_T, pop_vld) @[dut.scala 57:29]
    shift <= _shift_T_1 @[dut.scala 57:9]
    when load : @[dut.scala 59:14]
      hold_0 <= io.enq.bits @[dut.scala 60:12]
    else :
      when shift : @[dut.scala 61:21]
        hold_0 <= hold_1 @[dut.scala 62:12]
    node _T_4 = eq(state, UInt<2>("h1")) @[dut.scala 65:14]
    node _T_5 = and(_T_4, push_vld) @[dut.scala 65:24]
    when _T_5 : @[dut.scala 65:37]
      hold_1 <= io.enq.bits @[dut.scala 66:12]
    node _sendSel_T = eq(state, UInt<2>("h3")) @[dut.scala 70:21]
    sendSel <= _sendSel_T @[dut.scala 70:11]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 72:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 72:15]
    node _io_deq_valid_T = eq(state, UInt<2>("h1")) @[dut.scala 73:26]
    node _io_deq_valid_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 73:45]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 73:36]
    node _io_deq_valid_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 73:64]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 73:55]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 73:16]
    node _io_enq_ready_T = neq(state, UInt<2>("h3")) @[dut.scala 76:26]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 76:16]

