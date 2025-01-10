circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip input : { flip ready : UInt<1>, valid : UInt<1>, bits : SInt<4>}, flip num : SInt<3>[4], flip den : SInt<3>[2], output : { flip ready : UInt<1>, valid : UInt<1>, bits : SInt<11>}}

    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 25:22]
    reg inputMem : SInt<4>[4], clock with :
      reset => (UInt<1>("h0"), inputMem) @[dut.scala 28:21]
    reg outputMem : SInt<11>[2], clock with :
      reset => (UInt<1>("h0"), outputMem) @[dut.scala 29:22]
    reg coefNum : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 32:24]
    reg inputSum : SInt<12>, clock with :
      reset => (reset, asSInt(UInt<12>("h0"))) @[dut.scala 35:25]
    reg outputSum : SInt<12>, clock with :
      reset => (reset, asSInt(UInt<12>("h0"))) @[dut.scala 36:26]
    wire multIn : SInt<11> @[dut.scala 39:20]
    wire multCoef : SInt<3> @[dut.scala 40:22]
    wire multOut : SInt<14> @[dut.scala 41:21]
    multIn <= asSInt(UInt<1>("h0")) @[dut.scala 44:10]
    multCoef <= asSInt(UInt<1>("h0")) @[dut.scala 45:12]
    node _multOut_T = mul(multIn, multCoef) @[dut.scala 46:21]
    multOut <= _multOut_T @[dut.scala 46:11]
    io.input.ready <= UInt<1>("h0") @[dut.scala 49:18]
    io.output.valid <= UInt<1>("h0") @[dut.scala 50:19]
    io.output.bits <= asSInt(UInt<1>("h0")) @[dut.scala 51:18]
    node _T = eq(UInt<3>("h0"), state) @[dut.scala 54:17]
    when _T : @[dut.scala 54:17]
      when io.input.valid : @[dut.scala 56:28]
        io.input.ready <= UInt<1>("h1") @[dut.scala 57:24]
        inputMem[3] <= inputMem[2] @[dut.scala 60:23]
        inputMem[2] <= inputMem[1] @[dut.scala 60:23]
        inputMem[1] <= inputMem[0] @[dut.scala 60:23]
        inputMem[0] <= io.input.bits @[dut.scala 62:21]
        inputSum <= asSInt(UInt<1>("h0")) @[dut.scala 63:18]
        coefNum <= UInt<1>("h0") @[dut.scala 64:17]
        state <= UInt<3>("h1") @[dut.scala 65:15]
    else :
      node _T_1 = eq(UInt<3>("h1"), state) @[dut.scala 54:17]
      when _T_1 : @[dut.scala 54:17]
        multIn <= inputMem[coefNum] @[dut.scala 70:14]
        multCoef <= io.num[coefNum] @[dut.scala 71:16]
        node _inputSum_T = dshr(multOut, UInt<1>("h0")) @[dut.scala 72:39]
        node _inputSum_T_1 = add(inputSum, _inputSum_T) @[dut.scala 72:28]
        node _inputSum_T_2 = tail(_inputSum_T_1, 1) @[dut.scala 72:28]
        node _inputSum_T_3 = asSInt(_inputSum_T_2) @[dut.scala 72:28]
        inputSum <= _inputSum_T_3 @[dut.scala 72:16]
        node _coefNum_T = add(coefNum, UInt<1>("h1")) @[dut.scala 73:26]
        node _coefNum_T_1 = tail(_coefNum_T, 1) @[dut.scala 73:26]
        coefNum <= _coefNum_T_1 @[dut.scala 73:15]
        node _T_2 = eq(coefNum, UInt<2>("h3")) @[dut.scala 74:20]
        when _T_2 : @[dut.scala 74:46]
          coefNum <= UInt<1>("h0") @[dut.scala 75:17]
          outputSum <= asSInt(UInt<1>("h0")) @[dut.scala 76:19]
          state <= UInt<3>("h2") @[dut.scala 77:15]
      else :
        node _T_3 = eq(UInt<3>("h2"), state) @[dut.scala 54:17]
        when _T_3 : @[dut.scala 54:17]
          node _T_4 = lt(coefNum, UInt<2>("h2")) @[dut.scala 82:20]
          when _T_4 : @[dut.scala 82:40]
            node _multIn_T = bits(coefNum, 0, 0)
            multIn <= outputMem[_multIn_T] @[dut.scala 83:16]
            node _multCoef_T = bits(coefNum, 0, 0)
            multCoef <= io.den[_multCoef_T] @[dut.scala 84:18]
            node _outputSum_T = dshr(multOut, UInt<1>("h0")) @[dut.scala 85:43]
            node _outputSum_T_1 = add(outputSum, _outputSum_T) @[dut.scala 85:32]
            node _outputSum_T_2 = tail(_outputSum_T_1, 1) @[dut.scala 85:32]
            node _outputSum_T_3 = asSInt(_outputSum_T_2) @[dut.scala 85:32]
            outputSum <= _outputSum_T_3 @[dut.scala 85:19]
            node _coefNum_T_2 = add(coefNum, UInt<1>("h1")) @[dut.scala 86:28]
            node _coefNum_T_3 = tail(_coefNum_T_2, 1) @[dut.scala 86:28]
            coefNum <= _coefNum_T_3 @[dut.scala 86:17]
          else :
            state <= UInt<3>("h3") @[dut.scala 88:15]
        else :
          node _T_5 = eq(UInt<3>("h3"), state) @[dut.scala 54:17]
          when _T_5 : @[dut.scala 54:17]
            node _result_T = sub(inputSum, outputSum) @[dut.scala 94:29]
            node _result_T_1 = tail(_result_T, 1) @[dut.scala 94:29]
            node result = asSInt(_result_T_1) @[dut.scala 94:29]
            io.output.bits <= result @[dut.scala 95:22]
            io.output.valid <= UInt<1>("h1") @[dut.scala 96:23]
            when io.output.ready : @[dut.scala 97:29]
              outputMem[1] <= outputMem[0] @[dut.scala 100:24]
              outputMem[0] <= result @[dut.scala 102:22]
              state <= UInt<3>("h0") @[dut.scala 103:15]


