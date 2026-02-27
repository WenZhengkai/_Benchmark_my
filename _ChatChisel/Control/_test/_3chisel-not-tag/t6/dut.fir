circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip opcode : UInt<7>, flip funct7 : UInt<7>, flip funct3 : UInt<3>, aluop : UInt<4>, immsrc : UInt<1>, isbranch : UInt<1>, memread : UInt<1>, memwrite : UInt<1>, regwrite : UInt<1>, memtoreg : UInt<2>, pcsel : UInt<1>, rdsel : UInt<1>, isjump : UInt<1>, isupper : UInt<1>, islui : UInt<1>}

    io.aluop <= UInt<1>("h0") @[dut.scala 75:12]
    io.immsrc <= UInt<1>("h0") @[dut.scala 76:13]
    io.isbranch <= UInt<1>("h0") @[dut.scala 77:15]
    io.memread <= UInt<1>("h0") @[dut.scala 78:14]
    io.memwrite <= UInt<1>("h0") @[dut.scala 79:15]
    io.regwrite <= UInt<1>("h0") @[dut.scala 80:15]
    io.memtoreg <= UInt<2>("h0") @[dut.scala 81:15]
    io.pcsel <= UInt<1>("h0") @[dut.scala 82:12]
    io.rdsel <= UInt<1>("h0") @[dut.scala 83:12]
    io.isjump <= UInt<1>("h0") @[dut.scala 84:13]
    io.isupper <= UInt<1>("h0") @[dut.scala 85:14]
    io.islui <= UInt<1>("h0") @[dut.scala 86:12]
    node _T = eq(UInt<7>("h33"), io.opcode) @[dut.scala 91:21]
    when _T : @[dut.scala 91:21]
      io.immsrc <= UInt<1>("h0") @[dut.scala 96:17]
      io.regwrite <= UInt<1>("h1") @[dut.scala 97:19]
      io.memtoreg <= UInt<2>("h2") @[dut.scala 98:19]
      node _T_1 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 100:25]
      when _T_1 : @[dut.scala 100:25]
        node _T_2 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 102:26]
        when _T_2 : @[dut.scala 102:38]
          io.aluop <= UInt<4>("h1") @[dut.scala 103:22]
        else :
          io.aluop <= UInt<4>("h0") @[dut.scala 105:22]
      else :
        node _T_3 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 100:25]
        when _T_3 : @[dut.scala 100:25]
          io.aluop <= UInt<4>("h5") @[dut.scala 108:31]
        else :
          node _T_4 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 100:25]
          when _T_4 : @[dut.scala 100:25]
            io.aluop <= UInt<4>("h8") @[dut.scala 109:31]
          else :
            node _T_5 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 100:25]
            when _T_5 : @[dut.scala 100:25]
              io.aluop <= UInt<4>("h9") @[dut.scala 110:32]
            else :
              node _T_6 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 100:25]
              when _T_6 : @[dut.scala 100:25]
                io.aluop <= UInt<4>("h2") @[dut.scala 111:31]
              else :
                node _T_7 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 100:25]
                when _T_7 : @[dut.scala 100:25]
                  io.aluop <= UInt<4>("h3") @[dut.scala 112:31]
                else :
                  node _T_8 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 100:25]
                  when _T_8 : @[dut.scala 100:25]
                    io.aluop <= UInt<4>("h4") @[dut.scala 113:31]
                  else :
                    node _T_9 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 100:25]
                    when _T_9 : @[dut.scala 100:25]
                      node _T_10 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 115:26]
                      when _T_10 : @[dut.scala 115:38]
                        io.aluop <= UInt<4>("h7") @[dut.scala 116:22]
                      else :
                        io.aluop <= UInt<4>("h6") @[dut.scala 118:22]
    else :
      node _T_11 = eq(UInt<7>("h13"), io.opcode) @[dut.scala 91:21]
      when _T_11 : @[dut.scala 91:21]
        io.immsrc <= UInt<1>("h1") @[dut.scala 128:17]
        io.regwrite <= UInt<1>("h1") @[dut.scala 129:19]
        io.memtoreg <= UInt<2>("h2") @[dut.scala 130:19]
        node _T_12 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 132:25]
        when _T_12 : @[dut.scala 132:25]
          io.aluop <= UInt<4>("h0") @[dut.scala 133:31]
        else :
          node _T_13 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 132:25]
          when _T_13 : @[dut.scala 132:25]
            io.aluop <= UInt<4>("h5") @[dut.scala 134:31]
          else :
            node _T_14 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 132:25]
            when _T_14 : @[dut.scala 132:25]
              io.aluop <= UInt<4>("h8") @[dut.scala 135:31]
            else :
              node _T_15 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 132:25]
              when _T_15 : @[dut.scala 132:25]
                io.aluop <= UInt<4>("h9") @[dut.scala 136:32]
              else :
                node _T_16 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 132:25]
                when _T_16 : @[dut.scala 132:25]
                  io.aluop <= UInt<4>("h2") @[dut.scala 137:31]
                else :
                  node _T_17 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 132:25]
                  when _T_17 : @[dut.scala 132:25]
                    io.aluop <= UInt<4>("h3") @[dut.scala 138:31]
                  else :
                    node _T_18 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 132:25]
                    when _T_18 : @[dut.scala 132:25]
                      io.aluop <= UInt<4>("h4") @[dut.scala 139:31]
                    else :
                      node _T_19 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 132:25]
                      when _T_19 : @[dut.scala 132:25]
                        node _T_20 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 141:26]
                        when _T_20 : @[dut.scala 141:38]
                          io.aluop <= UInt<4>("h7") @[dut.scala 142:22]
                        else :
                          io.aluop <= UInt<4>("h6") @[dut.scala 144:22]
      else :
        node _T_21 = eq(UInt<7>("h3"), io.opcode) @[dut.scala 91:21]
        when _T_21 : @[dut.scala 91:21]
          io.aluop <= UInt<4>("h0") @[dut.scala 154:16]
          io.immsrc <= UInt<1>("h1") @[dut.scala 155:17]
          io.memread <= UInt<1>("h1") @[dut.scala 156:18]
          io.regwrite <= UInt<1>("h1") @[dut.scala 157:19]
          io.memtoreg <= UInt<2>("h1") @[dut.scala 158:19]
        else :
          node _T_22 = eq(UInt<7>("h23"), io.opcode) @[dut.scala 91:21]
          when _T_22 : @[dut.scala 91:21]
            io.aluop <= UInt<4>("h0") @[dut.scala 165:16]
            io.immsrc <= UInt<1>("h1") @[dut.scala 166:17]
            io.memwrite <= UInt<1>("h1") @[dut.scala 167:19]
          else :
            node _T_23 = eq(UInt<7>("h63"), io.opcode) @[dut.scala 91:21]
            when _T_23 : @[dut.scala 91:21]
              io.aluop <= UInt<4>("h8") @[dut.scala 174:16]
              io.isbranch <= UInt<1>("h1") @[dut.scala 175:19]
            else :
              node _T_24 = eq(UInt<7>("h6f"), io.opcode) @[dut.scala 91:21]
              when _T_24 : @[dut.scala 91:21]
                io.isjump <= UInt<1>("h1") @[dut.scala 182:17]
                io.immsrc <= UInt<1>("h1") @[dut.scala 183:17]
                io.regwrite <= UInt<1>("h1") @[dut.scala 184:19]
              else :
                node _T_25 = eq(UInt<7>("h67"), io.opcode) @[dut.scala 91:21]
                when _T_25 : @[dut.scala 91:21]
                  io.isjump <= UInt<1>("h1") @[dut.scala 191:17]
                  io.pcsel <= UInt<1>("h1") @[dut.scala 192:16]
                  io.regwrite <= UInt<1>("h1") @[dut.scala 193:19]
                  io.immsrc <= UInt<1>("h1") @[dut.scala 194:17]
                else :
                  node _T_26 = eq(UInt<7>("h37"), io.opcode) @[dut.scala 91:21]
                  when _T_26 : @[dut.scala 91:21]
                    io.isupper <= UInt<1>("h1") @[dut.scala 201:18]
                    io.islui <= UInt<1>("h1") @[dut.scala 202:16]
                    io.regwrite <= UInt<1>("h1") @[dut.scala 203:19]
                    io.immsrc <= UInt<1>("h1") @[dut.scala 204:17]
                  else :
                    node _T_27 = eq(UInt<7>("h17"), io.opcode) @[dut.scala 91:21]
                    when _T_27 : @[dut.scala 91:21]
                      io.isupper <= UInt<1>("h1") @[dut.scala 211:18]
                      io.rdsel <= UInt<1>("h1") @[dut.scala 212:16]
                      io.regwrite <= UInt<1>("h1") @[dut.scala 213:19]
                      io.immsrc <= UInt<1>("h1") @[dut.scala 214:17]


