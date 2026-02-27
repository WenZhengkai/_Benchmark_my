circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip opcode : UInt<7>, flip funct7 : UInt<7>, flip funct3 : UInt<3>, aluop : UInt<4>, immsrc : UInt<1>, isbranch : UInt<1>, memread : UInt<1>, memwrite : UInt<1>, regwrite : UInt<1>, memtoreg : UInt<2>, pcsel : UInt<1>, rdsel : UInt<1>, isjump : UInt<1>, isupper : UInt<1>, islui : UInt<1>}

    io.aluop <= UInt<1>("h0") @[dut.scala 70:16]
    io.immsrc <= UInt<1>("h0") @[dut.scala 71:16]
    io.isbranch <= UInt<1>("h0") @[dut.scala 72:16]
    io.memread <= UInt<1>("h0") @[dut.scala 73:16]
    io.memwrite <= UInt<1>("h0") @[dut.scala 74:16]
    io.regwrite <= UInt<1>("h0") @[dut.scala 75:16]
    io.memtoreg <= UInt<2>("h0") @[dut.scala 76:16]
    io.pcsel <= UInt<1>("h0") @[dut.scala 77:16]
    io.rdsel <= UInt<1>("h0") @[dut.scala 78:16]
    io.isjump <= UInt<1>("h0") @[dut.scala 79:16]
    io.isupper <= UInt<1>("h0") @[dut.scala 80:16]
    io.islui <= UInt<1>("h0") @[dut.scala 81:16]
    node _T = eq(io.opcode, UInt<7>("h33")) @[dut.scala 86:18]
    when _T : @[dut.scala 86:32]
      io.immsrc <= UInt<1>("h0") @[dut.scala 87:15]
      io.regwrite <= UInt<1>("h1") @[dut.scala 88:17]
      io.memtoreg <= UInt<2>("h2") @[dut.scala 89:17]
      node _T_1 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 91:23]
      when _T_1 : @[dut.scala 91:23]
        node _T_2 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 93:24]
        when _T_2 : @[dut.scala 93:36]
          io.aluop <= UInt<4>("h1") @[dut.scala 93:47]
        else :
          io.aluop <= UInt<4>("h0") @[dut.scala 94:33]
      else :
        node _T_3 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 91:23]
        when _T_3 : @[dut.scala 91:23]
          io.aluop <= UInt<4>("h5") @[dut.scala 96:29]
        else :
          node _T_4 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 91:23]
          when _T_4 : @[dut.scala 91:23]
            io.aluop <= UInt<4>("h8") @[dut.scala 97:29]
          else :
            node _T_5 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 91:23]
            when _T_5 : @[dut.scala 91:23]
              io.aluop <= UInt<4>("h9") @[dut.scala 98:30]
            else :
              node _T_6 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 91:23]
              when _T_6 : @[dut.scala 91:23]
                io.aluop <= UInt<4>("h2") @[dut.scala 99:29]
              else :
                node _T_7 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 91:23]
                when _T_7 : @[dut.scala 91:23]
                  io.aluop <= UInt<4>("h3") @[dut.scala 100:29]
                else :
                  node _T_8 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 91:23]
                  when _T_8 : @[dut.scala 91:23]
                    io.aluop <= UInt<4>("h4") @[dut.scala 101:29]
    else :
      node _T_9 = eq(io.opcode, UInt<7>("h13")) @[dut.scala 108:23]
      when _T_9 : @[dut.scala 108:43]
        io.immsrc <= UInt<1>("h1") @[dut.scala 109:15]
        io.regwrite <= UInt<1>("h1") @[dut.scala 110:17]
        io.memtoreg <= UInt<2>("h2") @[dut.scala 111:17]
        node _T_10 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 113:23]
        when _T_10 : @[dut.scala 113:23]
          io.aluop <= UInt<4>("h0") @[dut.scala 114:29]
        else :
          node _T_11 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 113:23]
          when _T_11 : @[dut.scala 113:23]
            io.aluop <= UInt<4>("h5") @[dut.scala 115:29]
          else :
            node _T_12 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 113:23]
            when _T_12 : @[dut.scala 113:23]
              io.aluop <= UInt<4>("h2") @[dut.scala 116:29]
            else :
              node _T_13 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 113:23]
              when _T_13 : @[dut.scala 113:23]
                io.aluop <= UInt<4>("h3") @[dut.scala 117:29]
              else :
                node _T_14 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 113:23]
                when _T_14 : @[dut.scala 113:23]
                  io.aluop <= UInt<4>("h4") @[dut.scala 118:29]
      else :
        node _T_15 = eq(io.opcode, UInt<7>("h3")) @[dut.scala 125:23]
        when _T_15 : @[dut.scala 125:36]
          io.aluop <= UInt<4>("h0") @[dut.scala 126:14]
          io.immsrc <= UInt<1>("h1") @[dut.scala 127:15]
          io.memread <= UInt<1>("h1") @[dut.scala 128:16]
          io.regwrite <= UInt<1>("h1") @[dut.scala 129:17]
          io.memtoreg <= UInt<2>("h1") @[dut.scala 130:17]
        else :
          node _T_16 = eq(io.opcode, UInt<7>("h23")) @[dut.scala 131:24]
          when _T_16 : @[dut.scala 131:38]
            io.aluop <= UInt<4>("h0") @[dut.scala 132:14]
            io.immsrc <= UInt<1>("h1") @[dut.scala 133:15]
            io.memwrite <= UInt<1>("h1") @[dut.scala 134:17]
          else :
            node _T_17 = eq(io.opcode, UInt<7>("h63")) @[dut.scala 140:23]
            when _T_17 : @[dut.scala 140:38]
              io.isbranch <= UInt<1>("h1") @[dut.scala 141:17]
              node _T_18 = eq(io.funct3, UInt<3>("h0")) @[dut.scala 142:20]
              when _T_18 : @[dut.scala 142:32]
                io.aluop <= UInt<4>("h8") @[dut.scala 142:43]
            else :
              node _T_19 = eq(io.opcode, UInt<7>("h6f")) @[dut.scala 143:24]
              when _T_19 : @[dut.scala 143:36]
                io.isjump <= UInt<1>("h1") @[dut.scala 144:15]
                io.regwrite <= UInt<1>("h1") @[dut.scala 145:17]
                io.immsrc <= UInt<1>("h1") @[dut.scala 146:15]
              else :
                node _T_20 = eq(io.opcode, UInt<7>("h67")) @[dut.scala 147:24]
                when _T_20 : @[dut.scala 147:37]
                  io.isjump <= UInt<1>("h1") @[dut.scala 148:15]
                  io.pcsel <= UInt<1>("h1") @[dut.scala 149:14]
                  io.regwrite <= UInt<1>("h1") @[dut.scala 150:17]
                  io.immsrc <= UInt<1>("h1") @[dut.scala 151:15]
                else :
                  node _T_21 = eq(io.opcode, UInt<7>("h37")) @[dut.scala 157:23]
                  when _T_21 : @[dut.scala 157:35]
                    io.isupper <= UInt<1>("h1") @[dut.scala 158:16]
                    io.islui <= UInt<1>("h1") @[dut.scala 159:14]
                    io.regwrite <= UInt<1>("h1") @[dut.scala 160:17]
                    io.immsrc <= UInt<1>("h1") @[dut.scala 161:15]
                  else :
                    node _T_22 = eq(io.opcode, UInt<7>("h17")) @[dut.scala 162:24]
                    when _T_22 : @[dut.scala 162:38]
                      io.isupper <= UInt<1>("h1") @[dut.scala 163:16]
                      io.rdsel <= UInt<1>("h1") @[dut.scala 164:14]
                      io.regwrite <= UInt<1>("h1") @[dut.scala 165:17]
                      io.immsrc <= UInt<1>("h1") @[dut.scala 166:15]


