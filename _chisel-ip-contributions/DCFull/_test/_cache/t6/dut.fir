circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:25]
    wire _hold_0_WIRE : UInt<8> @[dut.scala 16:36]
    _hold_0_WIRE <= UInt<1>("h0") @[dut.scala 16:36]
    reg hold_0 : UInt, clock with :
      reset => (reset, _hold_0_WIRE) @[dut.scala 16:23]
    wire _hold_1_WIRE : UInt<8> @[dut.scala 17:36]
    _hold_1_WIRE <= UInt<1>("h0") @[dut.scala 17:36]
    reg hold_1 : UInt, clock with :
      reset => (reset, _hold_1_WIRE) @[dut.scala 17:23]
    wire shift : UInt<1> @[dut.scala 20:19]
    wire load : UInt<1> @[dut.scala 21:18]
    wire sendSel : UInt<1> @[dut.scala 22:21]
    wire push_vld : UInt<1> @[dut.scala 23:22]
    wire pop_vld : UInt<1> @[dut.scala 24:21]
    node _push_vld_T = eq(stateReg, UInt<2>("h0")) @[dut.scala 27:41]
    node _push_vld_T_1 = eq(stateReg, UInt<2>("h1")) @[dut.scala 27:63]
    node _push_vld_T_2 = or(_push_vld_T, _push_vld_T_1) @[dut.scala 27:51]
    node _push_vld_T_3 = and(io.enq.valid, _push_vld_T_2) @[dut.scala 27:28]
    push_vld <= _push_vld_T_3 @[dut.scala 27:12]
    node _pop_vld_T = eq(stateReg, UInt<2>("h2")) @[dut.scala 28:40]
    node _pop_vld_T_1 = eq(stateReg, UInt<2>("h3")) @[dut.scala 28:62]
    node _pop_vld_T_2 = or(_pop_vld_T, _pop_vld_T_1) @[dut.scala 28:50]
    node _pop_vld_T_3 = and(io.deq.ready, _pop_vld_T_2) @[dut.scala 28:27]
    pop_vld <= _pop_vld_T_3 @[dut.scala 28:11]
    node _shift_T = eq(stateReg, UInt<2>("h1")) @[dut.scala 30:22]
    node _shift_T_1 = and(_shift_T, io.enq.valid) @[dut.scala 30:33]
    node _shift_T_2 = and(_shift_T_1, io.deq.ready) @[dut.scala 30:49]
    shift <= _shift_T_2 @[dut.scala 30:9]
    node _load_T = eq(stateReg, UInt<2>("h0")) @[dut.scala 31:21]
    node _load_T_1 = and(_load_T, io.enq.valid) @[dut.scala 31:32]
    load <= _load_T_1 @[dut.scala 31:8]
    node _sendSel_T = eq(stateReg, UInt<2>("h2")) @[dut.scala 34:23]
    node _sendSel_T_1 = eq(stateReg, UInt<2>("h3")) @[dut.scala 34:45]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 34:33]
    sendSel <= _sendSel_T_2 @[dut.scala 34:11]
    node _T = eq(UInt<2>("h0"), stateReg) @[dut.scala 37:20]
    when _T : @[dut.scala 37:20]
      when io.enq.valid : @[dut.scala 39:26]
        stateReg <= UInt<2>("h1") @[dut.scala 40:18]
    else :
      node _T_1 = eq(UInt<2>("h1"), stateReg) @[dut.scala 37:20]
      when _T_1 : @[dut.scala 37:20]
        node _T_2 = and(io.enq.valid, io.deq.ready) @[dut.scala 44:25]
        when _T_2 : @[dut.scala 44:42]
          stateReg <= UInt<2>("h3") @[dut.scala 45:18]
        else :
          when io.enq.valid : @[dut.scala 46:32]
            stateReg <= UInt<2>("h2") @[dut.scala 47:18]
          else :
            when io.deq.ready : @[dut.scala 48:32]
              stateReg <= UInt<2>("h0") @[dut.scala 49:18]
      else :
        node _T_3 = eq(UInt<2>("h2"), stateReg) @[dut.scala 37:20]
        when _T_3 : @[dut.scala 37:20]
          when io.deq.ready : @[dut.scala 53:26]
            stateReg <= UInt<2>("h0") @[dut.scala 54:18]
        else :
          node _T_4 = eq(UInt<2>("h3"), stateReg) @[dut.scala 37:20]
          when _T_4 : @[dut.scala 37:20]
            when io.deq.ready : @[dut.scala 58:26]
              stateReg <= UInt<2>("h1") @[dut.scala 59:18]
    when load : @[dut.scala 65:14]
      hold_0 <= io.enq.bits @[dut.scala 66:12]
    when shift : @[dut.scala 68:15]
      hold_0 <= hold_1 @[dut.scala 69:12]
      hold_1 <= io.enq.bits @[dut.scala 70:12]
    else :
      node _T_5 = eq(stateReg, UInt<2>("h0")) @[dut.scala 71:23]
      node _T_6 = and(_T_5, io.enq.valid) @[dut.scala 71:33]
      when _T_6 : @[dut.scala 71:50]
        hold_1 <= io.enq.bits @[dut.scala 72:12]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[dut.scala 76:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 76:15]
    io.enq.ready <= push_vld @[dut.scala 79:16]
    io.deq.valid <= pop_vld @[dut.scala 80:16]

