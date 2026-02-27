circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip alu_in1 : UInt<32>, flip alu_in2 : UInt<32>, flip aluop : UInt<4>, zero : UInt<1>, alu_result : UInt<32>}

    node _io_zero_T = eq(io.alu_in1, io.alu_in2) @[dut.scala 15:26]
    io.zero <= _io_zero_T @[dut.scala 15:11]
    wire result : UInt<32> @[dut.scala 18:20]
    result <= UInt<1>("h0") @[dut.scala 19:10]
    node _T = eq(UInt<1>("h0"), io.aluop) @[dut.scala 22:20]
    when _T : @[dut.scala 22:20]
      node _result_T = add(io.alu_in1, io.alu_in2) @[dut.scala 24:42]
      node _result_T_1 = tail(_result_T, 1) @[dut.scala 24:42]
      result <= _result_T_1 @[dut.scala 24:28]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.aluop) @[dut.scala 22:20]
      when _T_1 : @[dut.scala 22:20]
        node _result_T_2 = sub(io.alu_in1, io.alu_in2) @[dut.scala 25:42]
        node _result_T_3 = tail(_result_T_2, 1) @[dut.scala 25:42]
        result <= _result_T_3 @[dut.scala 25:28]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.aluop) @[dut.scala 22:20]
        when _T_2 : @[dut.scala 22:20]
          node _result_T_4 = xor(io.alu_in1, io.alu_in2) @[dut.scala 28:42]
          result <= _result_T_4 @[dut.scala 28:28]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.aluop) @[dut.scala 22:20]
          when _T_3 : @[dut.scala 22:20]
            node _result_T_5 = or(io.alu_in1, io.alu_in2) @[dut.scala 29:42]
            result <= _result_T_5 @[dut.scala 29:28]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.aluop) @[dut.scala 22:20]
            when _T_4 : @[dut.scala 22:20]
              node _result_T_6 = and(io.alu_in1, io.alu_in2) @[dut.scala 30:42]
              result <= _result_T_6 @[dut.scala 30:28]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.aluop) @[dut.scala 22:20]
              when _T_5 : @[dut.scala 22:20]
                node _result_T_7 = bits(io.alu_in2, 4, 0) @[dut.scala 33:55]
                node _result_T_8 = dshl(io.alu_in1, _result_T_7) @[dut.scala 33:42]
                result <= _result_T_8 @[dut.scala 33:28]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.aluop) @[dut.scala 22:20]
                when _T_6 : @[dut.scala 22:20]
                  node _result_T_9 = bits(io.alu_in2, 4, 0) @[dut.scala 34:55]
                  node _result_T_10 = dshr(io.alu_in1, _result_T_9) @[dut.scala 34:42]
                  result <= _result_T_10 @[dut.scala 34:28]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.aluop) @[dut.scala 22:20]
                  when _T_7 : @[dut.scala 22:20]
                    node _result_T_11 = asSInt(io.alu_in1) @[dut.scala 35:43]
                    node _result_T_12 = bits(io.alu_in2, 4, 0) @[dut.scala 35:63]
                    node _result_T_13 = dshr(_result_T_11, _result_T_12) @[dut.scala 35:50]
                    node _result_T_14 = asUInt(_result_T_13) @[dut.scala 35:71]
                    result <= _result_T_14 @[dut.scala 35:28]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.aluop) @[dut.scala 22:20]
                    when _T_8 : @[dut.scala 22:20]
                      node _result_T_15 = asSInt(io.alu_in1) @[dut.scala 38:46]
                      node _result_T_16 = asSInt(io.alu_in2) @[dut.scala 38:66]
                      node _result_T_17 = lt(_result_T_15, _result_T_16) @[dut.scala 38:53]
                      node _result_T_18 = mux(_result_T_17, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 38:34]
                      result <= _result_T_18 @[dut.scala 38:28]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.aluop) @[dut.scala 22:20]
                      when _T_9 : @[dut.scala 22:20]
                        node _result_T_19 = lt(io.alu_in1, io.alu_in2) @[dut.scala 39:46]
                        node _result_T_20 = mux(_result_T_19, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 39:34]
                        result <= _result_T_20 @[dut.scala 39:28]
    io.alu_result <= result @[dut.scala 43:17]

