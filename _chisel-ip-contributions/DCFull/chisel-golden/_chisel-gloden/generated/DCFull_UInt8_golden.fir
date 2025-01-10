circuit DCFull_UInt8_golden :
  module DCFull_UInt8_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[golden.scala 43:22]
    wire nxt_state : UInt @[golden.scala 44:30]
    nxt_state <= state @[golden.scala 44:30]
    reg hold_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_1) @[golden.scala 46:19]
    reg hold_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), hold_0) @[golden.scala 47:19]
    wire nxtShift : UInt<1> @[golden.scala 48:29]
    nxtShift <= UInt<1>("h0") @[golden.scala 48:29]
    wire nxtLoad : UInt<1> @[golden.scala 49:28]
    nxtLoad <= UInt<1>("h0") @[golden.scala 49:28]
    wire nxtSendSel : UInt<1> @[golden.scala 50:31]
    nxtSendSel <= UInt<1>("h1") @[golden.scala 50:31]
    reg shift : UInt<1>, clock with :
      reset => (UInt<1>("h0"), shift) @[golden.scala 51:18]
    reg load : UInt<1>, clock with :
      reset => (UInt<1>("h0"), load) @[golden.scala 52:17]
    reg sendSel : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sendSel) @[golden.scala 53:20]
    reg enqReady : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[golden.scala 54:25]
    reg deqValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 55:25]
    io.enq.ready <= enqReady @[golden.scala 57:16]
    io.deq.valid <= deqValid @[golden.scala 58:16]
    node push_vld = and(io.enq.ready, io.enq.valid) @[golden.scala 61:31]
    node pop_vld = and(io.deq.valid, io.deq.ready) @[golden.scala 62:30]
    state <= nxt_state @[golden.scala 64:9]
    node _T = eq(UInt<2>("h0"), state) @[golden.scala 66:17]
    when _T : @[golden.scala 66:17]
      when push_vld : @[golden.scala 68:22]
        nxt_state <= UInt<2>("h1") @[golden.scala 69:19]
        enqReady <= UInt<1>("h1") @[golden.scala 70:18]
        deqValid <= UInt<1>("h1") @[golden.scala 71:18]
        nxtSendSel <= UInt<1>("h1") @[golden.scala 72:20]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[golden.scala 66:17]
      when _T_1 : @[golden.scala 66:17]
        node _T_2 = and(push_vld, io.deq.ready) @[golden.scala 77:21]
        when _T_2 : @[golden.scala 77:38]
          nxt_state <= UInt<2>("h1") @[golden.scala 78:19]
        else :
          node _T_3 = eq(io.deq.ready, UInt<1>("h0")) @[golden.scala 79:33]
          node _T_4 = and(push_vld, _T_3) @[golden.scala 79:29]
          when _T_4 : @[golden.scala 79:49]
            nxt_state <= UInt<2>("h3") @[golden.scala 80:19]
          else :
            node _T_5 = eq(push_vld, UInt<1>("h0")) @[golden.scala 81:19]
            node _T_6 = and(_T_5, io.deq.ready) @[golden.scala 81:30]
            when _T_6 : @[golden.scala 81:49]
              nxt_state <= UInt<2>("h0") @[golden.scala 82:19]
            else :
              node _T_7 = eq(push_vld, UInt<1>("h0")) @[golden.scala 83:19]
              node _T_8 = eq(io.deq.ready, UInt<1>("h0")) @[golden.scala 83:34]
              node _T_9 = and(_T_7, _T_8) @[golden.scala 83:30]
              when _T_9 : @[golden.scala 83:50]
                nxt_state <= UInt<2>("h2") @[golden.scala 84:19]
      else :
        node _T_10 = eq(UInt<2>("h2"), state) @[golden.scala 66:17]
        when _T_10 : @[golden.scala 66:17]
          node _T_11 = and(push_vld, io.deq.ready) @[golden.scala 88:21]
          when _T_11 : @[golden.scala 88:38]
            nxt_state <= UInt<2>("h1") @[golden.scala 89:19]
          else :
            node _T_12 = eq(io.deq.ready, UInt<1>("h0")) @[golden.scala 90:33]
            node _T_13 = and(push_vld, _T_12) @[golden.scala 90:29]
            when _T_13 : @[golden.scala 90:49]
              nxt_state <= UInt<2>("h3") @[golden.scala 91:19]
            else :
              node _T_14 = eq(push_vld, UInt<1>("h0")) @[golden.scala 92:19]
              node _T_15 = and(_T_14, io.deq.ready) @[golden.scala 92:30]
              when _T_15 : @[golden.scala 92:49]
                nxt_state <= UInt<2>("h0") @[golden.scala 93:19]
              else :
                node _T_16 = eq(push_vld, UInt<1>("h0")) @[golden.scala 94:19]
                node _T_17 = eq(io.deq.ready, UInt<1>("h0")) @[golden.scala 94:34]
                node _T_18 = and(_T_16, _T_17) @[golden.scala 94:30]
                when _T_18 : @[golden.scala 94:50]
                  nxt_state <= UInt<2>("h2") @[golden.scala 95:19]
        else :
          node _T_19 = eq(UInt<2>("h3"), state) @[golden.scala 66:17]
          when _T_19 : @[golden.scala 66:17]
            node _T_20 = eq(push_vld, UInt<1>("h0")) @[golden.scala 99:13]
            node _T_21 = and(_T_20, io.deq.ready) @[golden.scala 99:24]
            when _T_21 : @[golden.scala 99:43]
              nxt_state <= UInt<2>("h1") @[golden.scala 100:19]
    node _T_22 = eq(UInt<2>("h0"), nxt_state) @[golden.scala 105:21]
    when _T_22 : @[golden.scala 105:21]
      nxtShift <= UInt<1>("h0") @[golden.scala 107:16]
      nxtLoad <= UInt<1>("h1") @[golden.scala 108:15]
      enqReady <= UInt<1>("h1") @[golden.scala 109:16]
      deqValid <= UInt<1>("h0") @[golden.scala 110:16]
    else :
      node _T_23 = eq(UInt<2>("h2"), nxt_state) @[golden.scala 105:21]
      when _T_23 : @[golden.scala 105:21]
        nxtLoad <= UInt<1>("h1") @[golden.scala 113:15]
        enqReady <= UInt<1>("h1") @[golden.scala 114:16]
        deqValid <= UInt<1>("h1") @[golden.scala 115:16]
        nxtSendSel <= UInt<1>("h0") @[golden.scala 116:18]
      else :
        node _T_24 = eq(UInt<2>("h1"), nxt_state) @[golden.scala 105:21]
        when _T_24 : @[golden.scala 105:21]
          nxtShift <= UInt<1>("h1") @[golden.scala 119:16]
          nxtLoad <= UInt<1>("h1") @[golden.scala 120:15]
          enqReady <= UInt<1>("h1") @[golden.scala 121:16]
          deqValid <= UInt<1>("h1") @[golden.scala 122:16]
          nxtSendSel <= UInt<1>("h1") @[golden.scala 123:18]
        else :
          node _T_25 = eq(UInt<2>("h3"), nxt_state) @[golden.scala 105:21]
          when _T_25 : @[golden.scala 105:21]
            enqReady <= UInt<1>("h0") @[golden.scala 126:16]
            deqValid <= UInt<1>("h1") @[golden.scala 127:16]
            nxtSendSel <= UInt<1>("h0") @[golden.scala 128:18]
    shift <= nxtShift @[golden.scala 132:9]
    load <= nxtLoad @[golden.scala 133:8]
    sendSel <= nxtSendSel @[golden.scala 134:11]
    when shift : @[golden.scala 136:15]
      hold_0 <= hold_1 @[golden.scala 137:12]
    when load : @[golden.scala 139:14]
      hold_1 <= io.enq.bits @[golden.scala 140:12]
    node _io_deq_bits_T = mux(sendSel, hold_1, hold_0) @[golden.scala 142:21]
    io.deq.bits <= _io_deq_bits_T @[golden.scala 142:15]

