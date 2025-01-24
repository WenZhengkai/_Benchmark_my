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
    node _shift_T = eq(state, UInt<2>("h2")) @[dut.scala 19:22]
    node _shift_T_1 = and(_shift_T, io.deq.ready) @[dut.scala 19:32]
    node shift = and(_shift_T_1, io.deq.valid) @[dut.scala 19:48]
    node _load_T = eq(state, UInt<2>("h0")) @[dut.scala 20:37]
    node _load_T_1 = eq(state, UInt<2>("h1")) @[dut.scala 20:56]
    node _load_T_2 = or(_load_T, _load_T_1) @[dut.scala 20:47]
    node _load_T_3 = eq(state, UInt<2>("h2")) @[dut.scala 20:75]
    node _load_T_4 = or(_load_T_2, _load_T_3) @[dut.scala 20:66]
    node load = and(io.enq.valid, _load_T_4) @[dut.scala 20:27]
    node _sendSel_T = eq(state, UInt<2>("h1")) @[dut.scala 21:24]
    node _sendSel_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 21:43]
    node sendSel = or(_sendSel_T, _sendSel_T_1) @[dut.scala 21:34]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 24:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 24:15]
    node _io_enq_ready_T = eq(state, UInt<2>("h0")) @[dut.scala 27:26]
    node _io_enq_ready_T_1 = eq(state, UInt<2>("h1")) @[dut.scala 27:45]
    node _io_enq_ready_T_2 = or(_io_enq_ready_T, _io_enq_ready_T_1) @[dut.scala 27:36]
    io.enq.ready <= _io_enq_ready_T_2 @[dut.scala 27:16]
    node _io_deq_valid_T = eq(state, UInt<2>("h1")) @[dut.scala 28:26]
    node _io_deq_valid_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 28:45]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 28:36]
    node _io_deq_valid_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 28:64]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 28:55]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 28:16]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 31:17]
    when _T : @[dut.scala 31:17]
      when load : @[dut.scala 33:18]
        hold_1 <= io.enq.bits @[dut.scala 34:16]
        state <= UInt<2>("h2") @[dut.scala 35:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 31:17]
      when _T_1 : @[dut.scala 31:17]
        when io.deq.ready : @[dut.scala 39:26]
          state <= UInt<2>("h0") @[dut.scala 40:15]
      else :
        node _T_2 = eq(UInt<2>("h2"), state) @[dut.scala 31:17]
        when _T_2 : @[dut.scala 31:17]
          when io.deq.ready : @[dut.scala 44:26]
            state <= UInt<2>("h1") @[dut.scala 45:15]
          else :
            when load : @[dut.scala 46:24]
              hold_0 <= hold_1 @[dut.scala 47:16]
              hold_1 <= io.enq.bits @[dut.scala 48:16]
              state <= UInt<2>("h3") @[dut.scala 49:15]
        else :
          node _T_3 = eq(UInt<2>("h3"), state) @[dut.scala 31:17]
          when _T_3 : @[dut.scala 31:17]
            when io.deq.ready : @[dut.scala 53:26]
              hold_0 <= hold_1 @[dut.scala 54:16]
              state <= UInt<2>("h1") @[dut.scala 55:15]


