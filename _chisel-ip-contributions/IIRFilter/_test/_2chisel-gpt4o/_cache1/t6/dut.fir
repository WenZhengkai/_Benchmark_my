circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip input : { flip ready : UInt<1>, valid : UInt<1>, bits : SInt<4>}, flip num : SInt<3>[4], flip den : SInt<3>[2], output : { flip ready : UInt<1>, valid : UInt<1>, bits : SInt<11>}}

    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 28:22]
    reg inputReg : SInt<4>, clock with :
      reset => (UInt<1>("h0"), inputReg) @[dut.scala 31:21]
    reg inputSum : SInt<10>, clock with :
      reset => (UInt<1>("h0"), inputSum) @[dut.scala 32:21]
    reg outputSum : SInt<9>, clock with :
      reset => (UInt<1>("h0"), outputSum) @[dut.scala 33:22]
    reg coefNum : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 34:24]
    reg inputMem : SInt<4>[4], clock with :
      reset => (UInt<1>("h0"), inputMem) @[dut.scala 37:21]
    reg outputMem : SInt<11>[2], clock with :
      reset => (UInt<1>("h0"), outputMem) @[dut.scala 38:22]
    reg inputMemAddr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 40:29]
    reg outputMemAddr : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 41:30]
    wire multIn : SInt<4> @[dut.scala 44:20]
    wire multCoef : SInt<3> @[dut.scala 45:22]
    wire multOut : SInt<7> @[dut.scala 46:21]
    node _multOut_T = mul(multIn, multCoef) @[dut.scala 47:21]
    multOut <= _multOut_T @[dut.scala 47:11]
    io.input.ready <= UInt<1>("h0") @[dut.scala 50:18]
    io.output.valid <= UInt<1>("h0") @[dut.scala 51:19]
    io.output.bits <= asSInt(UInt<1>("h0")) @[dut.scala 52:18]
    multIn <= asSInt(UInt<1>("h0")) @[dut.scala 53:10]
    multCoef <= asSInt(UInt<1>("h0")) @[dut.scala 54:12]
    node _T = eq(UInt<3>("h0"), state) @[dut.scala 57:17]
    when _T : @[dut.scala 57:17]
      inputSum <= asSInt(UInt<1>("h0")) @[dut.scala 59:16]
      outputSum <= asSInt(UInt<1>("h0")) @[dut.scala 60:17]
      coefNum <= UInt<1>("h0") @[dut.scala 61:15]
      when io.input.valid : @[dut.scala 62:28]
        io.input.ready <= UInt<1>("h1") @[dut.scala 63:24]
        inputReg <= io.input.bits @[dut.scala 64:18]
        state <= UInt<3>("h1") @[dut.scala 65:15]
    else :
      node _T_1 = eq(UInt<3>("h1"), state) @[dut.scala 57:17]
      when _T_1 : @[dut.scala 57:17]
        node _T_2 = lt(coefNum, UInt<3>("h4")) @[dut.scala 70:20]
        when _T_2 : @[dut.scala 70:38]
          node _multIn_T = eq(coefNum, UInt<1>("h0")) @[dut.scala 71:31]
          node _multIn_T_1 = sub(coefNum, UInt<1>("h1")) @[dut.scala 71:67]
          node _multIn_T_2 = tail(_multIn_T_1, 1) @[dut.scala 71:67]
          node _multIn_T_3 = mux(_multIn_T, inputReg, inputMem[_multIn_T_2]) @[dut.scala 71:22]
          multIn <= _multIn_T_3 @[dut.scala 71:16]
          multCoef <= io.num[coefNum] @[dut.scala 72:18]
          node _inputSum_T = add(inputSum, multOut) @[dut.scala 73:30]
          node _inputSum_T_1 = tail(_inputSum_T, 1) @[dut.scala 73:30]
          node _inputSum_T_2 = asSInt(_inputSum_T_1) @[dut.scala 73:30]
          inputSum <= _inputSum_T_2 @[dut.scala 73:18]
          node _coefNum_T = add(coefNum, UInt<1>("h1")) @[dut.scala 74:28]
          node _coefNum_T_1 = tail(_coefNum_T, 1) @[dut.scala 74:28]
          coefNum <= _coefNum_T_1 @[dut.scala 74:17]
        else :
          coefNum <= UInt<1>("h0") @[dut.scala 76:17]
          state <= UInt<3>("h2") @[dut.scala 77:15]
      else :
        node _T_3 = eq(UInt<3>("h2"), state) @[dut.scala 57:17]
        when _T_3 : @[dut.scala 57:17]
          node _T_4 = lt(coefNum, UInt<2>("h2")) @[dut.scala 82:20]
          when _T_4 : @[dut.scala 82:40]
            node _multIn_T_4 = bits(coefNum, 0, 0)
            multIn <= outputMem[_multIn_T_4] @[dut.scala 83:16]
            node _multCoef_T = bits(coefNum, 0, 0)
            multCoef <= io.den[_multCoef_T] @[dut.scala 84:18]
            node _outputSum_T = add(outputSum, multOut) @[dut.scala 85:32]
            node _outputSum_T_1 = tail(_outputSum_T, 1) @[dut.scala 85:32]
            node _outputSum_T_2 = asSInt(_outputSum_T_1) @[dut.scala 85:32]
            outputSum <= _outputSum_T_2 @[dut.scala 85:19]
            node _coefNum_T_2 = add(coefNum, UInt<1>("h1")) @[dut.scala 86:28]
            node _coefNum_T_3 = tail(_coefNum_T_2, 1) @[dut.scala 86:28]
            coefNum <= _coefNum_T_3 @[dut.scala 86:17]
          else :
            state <= UInt<3>("h3") @[dut.scala 88:15]
        else :
          node _T_5 = eq(UInt<3>("h3"), state) @[dut.scala 57:17]
          when _T_5 : @[dut.scala 57:17]
            inputMem[3] <= inputMem[2] @[dut.scala 95:21]
            inputMem[2] <= inputMem[1] @[dut.scala 95:21]
            inputMem[1] <= inputMem[0] @[dut.scala 95:21]
            inputMem[0] <= inputReg @[dut.scala 97:19]
            outputMem[1] <= outputMem[0] @[dut.scala 101:22]
            node _finalOutput_T = sub(inputSum, outputSum) @[dut.scala 103:35]
            node _finalOutput_T_1 = tail(_finalOutput_T, 1) @[dut.scala 103:35]
            node _finalOutput_T_2 = asSInt(_finalOutput_T_1) @[dut.scala 103:35]
            node finalOutput = dshr(_finalOutput_T_2, UInt<1>("h0")) @[dut.scala 103:48]
            outputMem[0] <= finalOutput @[dut.scala 104:20]
            io.output.bits <= finalOutput @[dut.scala 107:22]
            state <= UInt<3>("h4") @[dut.scala 108:13]
          else :
            node _T_6 = eq(UInt<3>("h4"), state) @[dut.scala 57:17]
            when _T_6 : @[dut.scala 57:17]
              io.output.valid <= UInt<1>("h1") @[dut.scala 112:23]
              when io.output.ready : @[dut.scala 113:29]
                state <= UInt<3>("h0") @[dut.scala 114:15]


