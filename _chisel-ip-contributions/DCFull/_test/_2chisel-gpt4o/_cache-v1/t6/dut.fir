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
    wire shift : UInt<1> @[dut.scala 21:19]
    wire load : UInt<1> @[dut.scala 22:18]
    wire sendSel : UInt<1> @[dut.scala 23:21]
    shift <= UInt<1>("h0") @[dut.scala 26:9]
    load <= UInt<1>("h0") @[dut.scala 27:8]
    sendSel <= UInt<1>("h0") @[dut.scala 28:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 31:17]
    when _T : @[dut.scala 31:17]
      when push_vld : @[dut.scala 33:22]
        state <= UInt<2>("h1") @[dut.scala 34:15]
        load <= UInt<1>("h1") @[dut.scala 35:14]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 31:17]
      when _T_1 : @[dut.scala 31:17]
        node _T_2 = and(push_vld, pop_vld) @[dut.scala 39:21]
        when _T_2 : @[dut.scala 39:33]
          state <= UInt<2>("h1") @[dut.scala 40:15]
          shift <= UInt<1>("h1") @[dut.scala 41:15]
          load <= UInt<1>("h1") @[dut.scala 42:14]
        else :
          when push_vld : @[dut.scala 43:29]
            state <= UInt<2>("h3") @[dut.scala 44:15]
            load <= UInt<1>("h1") @[dut.scala 45:14]
          else :
            when pop_vld : @[dut.scala 46:28]
              state <= UInt<2>("h0") @[dut.scala 47:15]
      else :
        node _T_3 = eq(UInt<2>("h2"), state) @[dut.scala 31:17]
        when _T_3 : @[dut.scala 31:17]
          node _T_4 = and(push_vld, pop_vld) @[dut.scala 51:21]
          when _T_4 : @[dut.scala 51:33]
            state <= UInt<2>("h1") @[dut.scala 52:15]
            shift <= UInt<1>("h1") @[dut.scala 53:15]
            load <= UInt<1>("h1") @[dut.scala 54:14]
          else :
            when push_vld : @[dut.scala 55:29]
              state <= UInt<2>("h3") @[dut.scala 56:15]
              shift <= UInt<1>("h1") @[dut.scala 57:15]
              load <= UInt<1>("h1") @[dut.scala 58:14]
            else :
              when pop_vld : @[dut.scala 59:28]
                state <= UInt<2>("h0") @[dut.scala 60:15]
                shift <= UInt<1>("h1") @[dut.scala 61:15]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 31:17]
          when _T_5 : @[dut.scala 31:17]
            when pop_vld : @[dut.scala 65:21]
              state <= UInt<2>("h1") @[dut.scala 66:15]
              shift <= UInt<1>("h1") @[dut.scala 67:15]
    when shift : @[dut.scala 73:15]
      hold_0 <= hold_1 @[dut.scala 74:12]
    when load : @[dut.scala 76:14]
      hold_1 <= io.enq.bits @[dut.scala 77:12]
    node _sendSel_T = eq(state, UInt<2>("h2")) @[dut.scala 81:21]
    node _sendSel_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 81:40]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 81:31]
    sendSel <= _sendSel_T_2 @[dut.scala 81:11]
    node _io_enq_ready_T = neq(state, UInt<2>("h3")) @[dut.scala 84:26]
    io.enq.ready <= _io_enq_ready_T @[dut.scala 84:16]
    node _io_deq_valid_T = eq(state, UInt<2>("h1")) @[dut.scala 85:26]
    node _io_deq_valid_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 85:45]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 85:36]
    node _io_deq_valid_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 85:64]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 85:55]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 85:16]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 86:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 86:15]

