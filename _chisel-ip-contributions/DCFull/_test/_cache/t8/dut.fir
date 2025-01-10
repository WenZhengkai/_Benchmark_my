circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 12:25]
    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[dut.scala 15:19]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[dut.scala 16:19]
    wire shift : UInt<1> @[dut.scala 19:26]
    shift <= UInt<1>("h0") @[dut.scala 19:26]
    wire load : UInt<1> @[dut.scala 20:25]
    load <= UInt<1>("h0") @[dut.scala 20:25]
    wire sendSel : UInt<1> @[dut.scala 21:28]
    sendSel <= UInt<1>("h0") @[dut.scala 21:28]
    node push_vld = and(io.enq.valid, io.enq.ready) @[dut.scala 24:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[dut.scala 25:30]
    node _T = eq(UInt<2>("h0"), stateReg) @[dut.scala 28:20]
    when _T : @[dut.scala 28:20]
      when push_vld : @[dut.scala 30:22]
        load <= UInt<1>("h1") @[dut.scala 31:14]
        stateReg <= UInt<2>("h1") @[dut.scala 32:18]
    else :
      node _T_1 = eq(UInt<2>("h1"), stateReg) @[dut.scala 28:20]
      when _T_1 : @[dut.scala 28:20]
        node _T_2 = and(push_vld, pop_vld) @[dut.scala 36:21]
        when _T_2 : @[dut.scala 36:33]
          shift <= UInt<1>("h1") @[dut.scala 37:15]
          load <= UInt<1>("h1") @[dut.scala 38:14]
        else :
          when push_vld : @[dut.scala 39:28]
            load <= UInt<1>("h1") @[dut.scala 40:14]
            stateReg <= UInt<2>("h3") @[dut.scala 41:18]
          else :
            when pop_vld : @[dut.scala 42:27]
              shift <= UInt<1>("h1") @[dut.scala 43:15]
              stateReg <= UInt<2>("h0") @[dut.scala 44:18]
      else :
        node _T_3 = eq(UInt<2>("h2"), stateReg) @[dut.scala 28:20]
        when _T_3 : @[dut.scala 28:20]
          node _T_4 = and(push_vld, pop_vld) @[dut.scala 48:21]
          when _T_4 : @[dut.scala 48:33]
            load <= UInt<1>("h1") @[dut.scala 49:14]
          else :
            when push_vld : @[dut.scala 50:28]
              load <= UInt<1>("h1") @[dut.scala 51:14]
              stateReg <= UInt<2>("h3") @[dut.scala 52:18]
            else :
              when pop_vld : @[dut.scala 53:27]
                stateReg <= UInt<2>("h0") @[dut.scala 54:18]
        else :
          node _T_5 = eq(UInt<2>("h3"), stateReg) @[dut.scala 28:20]
          when _T_5 : @[dut.scala 28:20]
            when pop_vld : @[dut.scala 58:21]
              shift <= UInt<1>("h1") @[dut.scala 59:15]
              stateReg <= UInt<2>("h1") @[dut.scala 60:18]
    when shift : @[dut.scala 66:15]
      hold_0 <= hold_1 @[dut.scala 67:12]
    when load : @[dut.scala 69:14]
      hold_1 <= io.enq.bits @[dut.scala 70:12]
    node _sendSel_T = eq(stateReg, UInt<2>("h1")) @[dut.scala 74:24]
    node _sendSel_T_1 = eq(stateReg, UInt<2>("h3")) @[dut.scala 74:48]
    node _sendSel_T_2 = or(_sendSel_T, _sendSel_T_1) @[dut.scala 74:35]
    sendSel <= _sendSel_T_2 @[dut.scala 74:11]
    node _io_deq_bits_T = mux(sendSel, hold_0, hold_1) @[dut.scala 75:21]
    io.deq.bits <= _io_deq_bits_T @[dut.scala 75:15]
    node _io_deq_valid_T = eq(stateReg, UInt<2>("h1")) @[dut.scala 78:29]
    node _io_deq_valid_T_1 = eq(stateReg, UInt<2>("h2")) @[dut.scala 78:53]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[dut.scala 78:40]
    node _io_deq_valid_T_3 = eq(stateReg, UInt<2>("h3")) @[dut.scala 78:77]
    node _io_deq_valid_T_4 = or(_io_deq_valid_T_2, _io_deq_valid_T_3) @[dut.scala 78:64]
    io.deq.valid <= _io_deq_valid_T_4 @[dut.scala 78:16]
    node _io_enq_ready_T = eq(stateReg, UInt<2>("h0")) @[dut.scala 80:29]
    node _io_enq_ready_T_1 = eq(stateReg, UInt<2>("h2")) @[dut.scala 80:53]
    node _io_enq_ready_T_2 = or(_io_enq_ready_T, _io_enq_ready_T_1) @[dut.scala 80:40]
    io.enq.ready <= _io_enq_ready_T_2 @[dut.scala 80:16]

