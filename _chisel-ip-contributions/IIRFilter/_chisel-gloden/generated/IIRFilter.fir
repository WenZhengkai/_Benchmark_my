circuit IIRFilter :
  module IIRFilter :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip input : { flip ready : UInt<1>, valid : UInt<1>, bits : SInt<4>}, flip num : SInt<3>[4], flip den : SInt<3>[2], output : { flip ready : UInt<1>, valid : UInt<1>, bits : SInt<11>}}

    reg coefNum : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[golden.scala 62:24]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 68:22]
    node _T = asUInt(UInt<1>("h0")) @[golden.scala 70:17]
    node _T_1 = asUInt(state) @[golden.scala 70:17]
    node _T_2 = eq(_T, _T_1) @[golden.scala 70:17]
    when _T_2 : @[golden.scala 70:17]
      when io.input.valid : @[golden.scala 72:28]
        state <= UInt<1>("h1") @[golden.scala 73:15]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[golden.scala 70:17]
      node _T_4 = asUInt(state) @[golden.scala 70:17]
      node _T_5 = eq(_T_3, _T_4) @[golden.scala 70:17]
      when _T_5 : @[golden.scala 70:17]
        node _T_6 = eq(coefNum, UInt<2>("h3")) @[golden.scala 77:20]
        when _T_6 : @[golden.scala 77:46]
          state <= UInt<2>("h2") @[golden.scala 78:15]
      else :
        node _T_7 = asUInt(UInt<2>("h2")) @[golden.scala 70:17]
        node _T_8 = asUInt(state) @[golden.scala 70:17]
        node _T_9 = eq(_T_7, _T_8) @[golden.scala 70:17]
        when _T_9 : @[golden.scala 70:17]
          node _T_10 = eq(coefNum, UInt<1>("h1")) @[golden.scala 82:20]
          when _T_10 : @[golden.scala 82:48]
            state <= UInt<3>("h4") @[golden.scala 83:15]
        else :
          node _T_11 = asUInt(UInt<3>("h4")) @[golden.scala 70:17]
          node _T_12 = asUInt(state) @[golden.scala 70:17]
          node _T_13 = eq(_T_11, _T_12) @[golden.scala 70:17]
          when _T_13 : @[golden.scala 70:17]
            state <= UInt<2>("h3") @[golden.scala 87:13]
          else :
            node _T_14 = asUInt(UInt<2>("h3")) @[golden.scala 70:17]
            node _T_15 = asUInt(state) @[golden.scala 70:17]
            node _T_16 = eq(_T_14, _T_15) @[golden.scala 70:17]
            when _T_16 : @[golden.scala 70:17]
              when io.output.ready : @[golden.scala 90:29]
                state <= UInt<1>("h0") @[golden.scala 91:15]
    node _T_17 = eq(state, UInt<1>("h0")) @[golden.scala 96:15]
    node _T_18 = and(_T_17, io.input.valid) @[golden.scala 96:40]
    when _T_18 : @[golden.scala 96:59]
      coefNum <= UInt<1>("h1") @[golden.scala 97:13]
    else :
      node _T_19 = eq(state, UInt<1>("h1")) @[golden.scala 98:20]
      when _T_19 : @[golden.scala 98:51]
        node _T_20 = eq(coefNum, UInt<2>("h3")) @[golden.scala 99:18]
        when _T_20 : @[golden.scala 99:44]
          coefNum <= UInt<1>("h0") @[golden.scala 100:15]
        else :
          node _coefNum_T = add(coefNum, UInt<1>("h1")) @[golden.scala 102:26]
          node _coefNum_T_1 = tail(_coefNum_T, 1) @[golden.scala 102:26]
          coefNum <= _coefNum_T_1 @[golden.scala 102:15]
      else :
        node _T_21 = eq(state, UInt<2>("h2")) @[golden.scala 104:20]
        when _T_21 : @[golden.scala 104:51]
          node _T_22 = eq(coefNum, UInt<1>("h1")) @[golden.scala 105:18]
          when _T_22 : @[golden.scala 105:46]
            coefNum <= UInt<1>("h0") @[golden.scala 106:15]
          else :
            node _coefNum_T_2 = add(coefNum, UInt<1>("h1")) @[golden.scala 108:26]
            node _coefNum_T_3 = tail(_coefNum_T_2, 1) @[golden.scala 108:26]
            coefNum <= _coefNum_T_3 @[golden.scala 108:15]
        else :
          coefNum <= UInt<1>("h0") @[golden.scala 111:13]
    reg inputReg : SInt<4>, clock with :
      reset => (reset, asSInt(UInt<4>("h0"))) @[golden.scala 114:25]
    cmem inputMem : SInt<4> [3] @[golden.scala 115:21]
    reg inputMemAddr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[golden.scala 116:29]
    wire inputMemOut : SInt<4> @[golden.scala 117:25]
    infer mport inputRdWr = inputMem[inputMemAddr], clock @[golden.scala 118:27]
    inputMemOut is invalid @[golden.scala 120:15]
    node _T_23 = eq(state, UInt<3>("h4")) @[golden.scala 122:14]
    when _T_23 : @[golden.scala 122:44]
      inputRdWr <= inputReg @[golden.scala 123:15]
    else :
      node _T_24 = eq(state, UInt<1>("h0")) @[golden.scala 124:21]
      node _T_25 = and(_T_24, io.input.valid) @[golden.scala 124:46]
      when _T_25 : @[golden.scala 124:65]
        inputReg <= io.input.bits @[golden.scala 125:14]
        inputMemOut <= inputRdWr @[golden.scala 126:17]
      else :
        inputMemOut <= inputRdWr @[golden.scala 128:17]
    node _T_26 = eq(state, UInt<1>("h1")) @[golden.scala 131:15]
    node _T_27 = lt(coefNum, UInt<2>("h3")) @[golden.scala 131:58]
    node _T_28 = and(_T_26, _T_27) @[golden.scala 131:46]
    when _T_28 : @[golden.scala 131:83]
      node _T_29 = eq(inputMemAddr, UInt<2>("h2")) @[golden.scala 132:23]
      when _T_29 : @[golden.scala 132:49]
        inputMemAddr <= UInt<1>("h0") @[golden.scala 133:20]
      else :
        node _inputMemAddr_T = add(inputMemAddr, UInt<1>("h1")) @[golden.scala 135:36]
        node _inputMemAddr_T_1 = tail(_inputMemAddr_T, 1) @[golden.scala 135:36]
        inputMemAddr <= _inputMemAddr_T_1 @[golden.scala 135:20]
    cmem outputMem : SInt<11> [2] @[golden.scala 139:22]
    reg outputMemAddr : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[golden.scala 140:30]
    wire outputMemOut : SInt<11> @[golden.scala 141:26]
    infer mport outputRdWr = outputMem[outputMemAddr], clock @[golden.scala 142:29]
    outputMemOut is invalid @[golden.scala 144:16]
    node _T_30 = eq(state, UInt<2>("h3")) @[golden.scala 146:15]
    reg REG : UInt<3>, clock with :
      reset => (UInt<1>("h0"), REG) @[golden.scala 146:52]
    REG <= state @[golden.scala 146:52]
    node _T_31 = eq(REG, UInt<3>("h4")) @[golden.scala 146:60]
    node _T_32 = and(_T_30, _T_31) @[golden.scala 146:41]
    when _T_32 : @[golden.scala 146:91]
      outputRdWr <= io.output.bits @[golden.scala 147:16]
    else :
      outputMemOut <= outputRdWr @[golden.scala 149:18]
    node _T_33 = eq(state, UInt<2>("h2")) @[golden.scala 152:15]
    node _T_34 = lt(coefNum, UInt<1>("h1")) @[golden.scala 152:58]
    node _T_35 = and(_T_33, _T_34) @[golden.scala 152:46]
    when _T_35 : @[golden.scala 152:85]
      node _T_36 = eq(outputMemAddr, UInt<1>("h1")) @[golden.scala 153:24]
      when _T_36 : @[golden.scala 153:52]
        outputMemAddr <= UInt<1>("h0") @[golden.scala 154:21]
      else :
        node _outputMemAddr_T = add(outputMemAddr, UInt<1>("h1")) @[golden.scala 156:38]
        node _outputMemAddr_T_1 = tail(_outputMemAddr_T, 1) @[golden.scala 156:38]
        outputMemAddr <= _outputMemAddr_T_1 @[golden.scala 156:21]
    reg inputSum : SInt<9>, clock with :
      reset => (reset, asSInt(UInt<9>("h0"))) @[golden.scala 160:25]
    reg outputSum : SInt<15>, clock with :
      reset => (reset, asSInt(UInt<15>("h0"))) @[golden.scala 161:26]
    wire multOut : SInt<14> @[golden.scala 163:21]
    reg multOutReg : SInt<14>, clock with :
      reset => (reset, asSInt(UInt<14>("h0"))) @[golden.scala 164:27]
    wire multIn : SInt<11> @[golden.scala 165:20]
    wire multCoef : SInt<3> @[golden.scala 166:22]
    node _T_37 = eq(state, UInt<1>("h0")) @[golden.scala 168:15]
    node _T_38 = and(_T_37, io.input.valid) @[golden.scala 168:40]
    when _T_38 : @[golden.scala 168:59]
      multOutReg <= multOut @[golden.scala 169:16]
      outputSum <= asSInt(UInt<1>("h0")) @[golden.scala 170:15]
      inputSum <= asSInt(UInt<1>("h0")) @[golden.scala 171:14]
    else :
      node _T_39 = eq(state, UInt<1>("h1")) @[golden.scala 172:20]
      when _T_39 : @[golden.scala 172:51]
        multOutReg <= multOut @[golden.scala 173:16]
        node _inputSum_T = add(inputSum, multOutReg) @[golden.scala 174:26]
        inputSum <= _inputSum_T @[golden.scala 174:14]
      else :
        node _T_40 = eq(state, UInt<2>("h2")) @[golden.scala 175:20]
        when _T_40 : @[golden.scala 175:51]
          multOutReg <= multOut @[golden.scala 176:16]
          node _T_41 = eq(coefNum, UInt<1>("h0")) @[golden.scala 178:18]
          when _T_41 : @[golden.scala 178:27]
            node _inputSum_T_1 = add(inputSum, multOutReg) @[golden.scala 180:28]
            inputSum <= _inputSum_T_1 @[golden.scala 180:16]
          else :
            node _outputSum_T = add(outputSum, multOutReg) @[golden.scala 182:30]
            outputSum <= _outputSum_T @[golden.scala 182:17]
        else :
          node _T_42 = eq(state, UInt<3>("h4")) @[golden.scala 184:20]
          when _T_42 : @[golden.scala 184:50]
            node _outputSum_T_1 = add(outputSum, multOutReg) @[golden.scala 185:28]
            outputSum <= _outputSum_T_1 @[golden.scala 185:15]
    node _T_43 = eq(state, UInt<1>("h1")) @[golden.scala 188:14]
    when _T_43 : @[golden.scala 188:45]
      multIn <= inputMemOut @[golden.scala 189:12]
    else :
      node _T_44 = eq(state, UInt<2>("h2")) @[golden.scala 190:20]
      when _T_44 : @[golden.scala 190:51]
        multIn <= outputMemOut @[golden.scala 191:12]
      else :
        multIn <= io.input.bits @[golden.scala 193:12]
    node _T_45 = eq(state, UInt<2>("h2")) @[golden.scala 196:14]
    when _T_45 : @[golden.scala 196:45]
      node _multCoef_T = bits(coefNum, 0, 0)
      multCoef <= io.den[_multCoef_T] @[golden.scala 197:14]
    else :
      multCoef <= io.num[coefNum] @[golden.scala 199:14]
    node _multOut_T = mul(multIn, multCoef) @[golden.scala 202:21]
    multOut <= _multOut_T @[golden.scala 202:11]
    node _io_input_ready_T = eq(state, UInt<1>("h0")) @[golden.scala 204:27]
    io.input.ready <= _io_input_ready_T @[golden.scala 204:18]
    node _io_output_valid_T = eq(state, UInt<2>("h3")) @[golden.scala 205:28]
    io.output.valid <= _io_output_valid_T @[golden.scala 205:19]
    node _io_output_bits_T = shr(outputSum, 0) @[golden.scala 206:44]
    node _io_output_bits_T_1 = sub(inputSum, _io_output_bits_T) @[golden.scala 206:30]
    io.output.bits <= _io_output_bits_T_1 @[golden.scala 206:18]

