circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:22]
    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[dut.scala 19:19]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[dut.scala 20:19]
    wire shift : UInt<1> @[dut.scala 23:26]
    shift <= UInt<1>("h0") @[dut.scala 23:26]
    wire load : UInt<1> @[dut.scala 24:25]
    load <= UInt<1>("h0") @[dut.scala 24:25]
    node push_vld = and(io.enq.valid, io.enq.ready) @[dut.scala 27:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[dut.scala 28:30]
    wire sendSel : UInt<1> @[dut.scala 29:28]
    sendSel <= UInt<1>("h0") @[dut.scala 29:28]
    node _io_enq_ready_T = eq(state, UInt<1>("h0")) @[dut.scala 32:25]
    node _io_enq_ready_T_1 = eq(state, UInt<1>("h1")) @[dut.scala 32:50]
    node _io_enq_ready_T_2 = or(_io_enq_ready_T, _io_enq_ready_T_1) @[dut.scala 32:41]
    io.enq.ready <= _io_enq_ready_T_2 @[dut.scala 32:16]
    node _io_deq_valid_T = eq(state, UInt<1>("h1")) @[dut.scala 33:25]
    node _io_deq_valid_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 33:50]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 33:41]
    node _io_deq_valid_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 33:75]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 33:66]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 33:16]
    node _sendSel_T = eq(state, UInt<2>("h2")) @[dut.scala 36:20]
    node _sendSel_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 36:45]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 36:36]
    sendSel <= _sendSel_T_2 @[dut.scala 36:11]
    node _io_deq_bits_T = mux(sendSel, hold_0, hold_1) @[dut.scala 37:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 37:15]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 40:17]
    node _T_1 = asUInt(state) @[dut.scala 40:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 40:17]
    when _T_2 : @[dut.scala 40:17]
      when push_vld : @[dut.scala 42:22]
        load <= UInt<1>("h1") @[dut.scala 43:14]
        state <= UInt<1>("h1") @[dut.scala 44:15]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[dut.scala 40:17]
      node _T_4 = asUInt(state) @[dut.scala 40:17]
      node _T_5 = eq(_T_3, _T_4) @[dut.scala 40:17]
      when _T_5 : @[dut.scala 40:17]
        node _T_6 = and(push_vld, pop_vld) @[dut.scala 48:21]
        when _T_6 : @[dut.scala 48:33]
          shift <= UInt<1>("h1") @[dut.scala 49:15]
          state <= UInt<1>("h1") @[dut.scala 50:15]
        else :
          when push_vld : @[dut.scala 51:28]
            shift <= UInt<1>("h1") @[dut.scala 52:15]
            load <= UInt<1>("h1") @[dut.scala 53:14]
            state <= UInt<2>("h3") @[dut.scala 54:15]
          else :
            when pop_vld : @[dut.scala 55:27]
              state <= UInt<1>("h0") @[dut.scala 56:15]
      else :
        node _T_7 = asUInt(UInt<2>("h2")) @[dut.scala 40:17]
        node _T_8 = asUInt(state) @[dut.scala 40:17]
        node _T_9 = eq(_T_7, _T_8) @[dut.scala 40:17]
        when _T_9 : @[dut.scala 40:17]
          when pop_vld : @[dut.scala 60:21]
            state <= UInt<1>("h0") @[dut.scala 61:15]
          else :
            when push_vld : @[dut.scala 62:28]
              load <= UInt<1>("h1") @[dut.scala 63:14]
              state <= UInt<2>("h3") @[dut.scala 64:15]
        else :
          node _T_10 = asUInt(UInt<2>("h3")) @[dut.scala 40:17]
          node _T_11 = asUInt(state) @[dut.scala 40:17]
          node _T_12 = eq(_T_10, _T_11) @[dut.scala 40:17]
          when _T_12 : @[dut.scala 40:17]
            when pop_vld : @[dut.scala 68:21]
              state <= UInt<1>("h1") @[dut.scala 69:15]
    when load : @[dut.scala 75:14]
      hold_1 <= io.enq.bits @[dut.scala 76:12]
    when shift : @[dut.scala 78:15]
      hold_0 <= hold_1 @[dut.scala 79:12]


