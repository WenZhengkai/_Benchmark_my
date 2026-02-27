circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip opcode : UInt<7>, flip funct7 : UInt<7>, flip funct3 : UInt<3>, aluop : UInt<4>, immsrc : UInt<1>, isbranch : UInt<1>, memread : UInt<1>, memwrite : UInt<1>, regwrite : UInt<1>, memtoreg : UInt<2>, pcsel : UInt<1>, rdsel : UInt<1>, isjump : UInt<1>, isupper : UInt<1>, islui : UInt<1>}

    io.aluop <= UInt<1>("h0") @[dut.scala 78:12]
    io.immsrc <= UInt<1>("h0") @[dut.scala 79:13]
    io.isbranch <= UInt<1>("h0") @[dut.scala 80:15]
    io.memread <= UInt<1>("h0") @[dut.scala 81:14]
    io.memwrite <= UInt<1>("h0") @[dut.scala 82:15]
    io.regwrite <= UInt<1>("h0") @[dut.scala 83:15]
    io.memtoreg <= UInt<1>("h0") @[dut.scala 84:15]
    io.pcsel <= UInt<1>("h0") @[dut.scala 85:12]
    io.rdsel <= UInt<1>("h0") @[dut.scala 86:12]
    io.isjump <= UInt<1>("h0") @[dut.scala 87:13]
    io.isupper <= UInt<1>("h0") @[dut.scala 88:14]
    io.islui <= UInt<1>("h0") @[dut.scala 89:12]
    node _T = eq(UInt<6>("h33"), io.opcode) @[dut.scala 94:21]
    when _T : @[dut.scala 94:21]
      io.immsrc <= UInt<1>("h0") @[dut.scala 97:17]
      io.regwrite <= UInt<1>("h1") @[dut.scala 98:19]
      io.memtoreg <= UInt<2>("h2") @[dut.scala 99:19]
      node _T_1 = eq(UInt<1>("h0"), io.funct3) @[dut.scala 101:25]
      when _T_1 : @[dut.scala 101:25]
        node _T_2 = eq(io.funct7, UInt<6>("h20")) @[dut.scala 103:26]
        when _T_2 : @[dut.scala 103:38]
          io.aluop <= UInt<1>("h1") @[dut.scala 103:49]
        else :
          io.aluop <= UInt<1>("h0") @[dut.scala 104:35]
      else :
        node _T_3 = eq(UInt<2>("h2"), io.funct3) @[dut.scala 101:25]
        when _T_3 : @[dut.scala 101:25]
          io.aluop <= UInt<4>("h8") @[dut.scala 106:32]
        else :
          node _T_4 = eq(UInt<2>("h3"), io.funct3) @[dut.scala 101:25]
          when _T_4 : @[dut.scala 101:25]
            io.aluop <= UInt<4>("h9") @[dut.scala 107:32]
          else :
            node _T_5 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 101:25]
            when _T_5 : @[dut.scala 101:25]
              io.aluop <= UInt<2>("h2") @[dut.scala 108:32]
            else :
              node _T_6 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 101:25]
              when _T_6 : @[dut.scala 101:25]
                io.aluop <= UInt<2>("h3") @[dut.scala 109:32]
              else :
                node _T_7 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 101:25]
                when _T_7 : @[dut.scala 101:25]
                  io.aluop <= UInt<3>("h4") @[dut.scala 110:32]
                else :
                  node _T_8 = eq(UInt<1>("h1"), io.funct3) @[dut.scala 101:25]
                  when _T_8 : @[dut.scala 101:25]
                    io.aluop <= UInt<3>("h5") @[dut.scala 111:32]
                  else :
                    node _T_9 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 101:25]
                    when _T_9 : @[dut.scala 101:25]
                      node _T_10 = eq(io.funct7, UInt<6>("h20")) @[dut.scala 113:26]
                      when _T_10 : @[dut.scala 113:38]
                        io.aluop <= UInt<3>("h7") @[dut.scala 113:49]
                      else :
                        io.aluop <= UInt<3>("h6") @[dut.scala 114:35]
    else :
      node _T_11 = eq(UInt<5>("h13"), io.opcode) @[dut.scala 94:21]
      when _T_11 : @[dut.scala 94:21]
        io.immsrc <= UInt<1>("h1") @[dut.scala 121:17]
        io.regwrite <= UInt<1>("h1") @[dut.scala 122:19]
        io.memtoreg <= UInt<2>("h2") @[dut.scala 123:19]
        node _T_12 = eq(UInt<1>("h0"), io.funct3) @[dut.scala 125:25]
        when _T_12 : @[dut.scala 125:25]
          io.aluop <= UInt<1>("h0") @[dut.scala 126:32]
        else :
          node _T_13 = eq(UInt<2>("h2"), io.funct3) @[dut.scala 125:25]
          when _T_13 : @[dut.scala 125:25]
            io.aluop <= UInt<4>("h8") @[dut.scala 127:32]
          else :
            node _T_14 = eq(UInt<2>("h3"), io.funct3) @[dut.scala 125:25]
            when _T_14 : @[dut.scala 125:25]
              io.aluop <= UInt<4>("h9") @[dut.scala 128:32]
            else :
              node _T_15 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 125:25]
              when _T_15 : @[dut.scala 125:25]
                io.aluop <= UInt<2>("h2") @[dut.scala 129:32]
              else :
                node _T_16 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 125:25]
                when _T_16 : @[dut.scala 125:25]
                  io.aluop <= UInt<2>("h3") @[dut.scala 130:32]
                else :
                  node _T_17 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 125:25]
                  when _T_17 : @[dut.scala 125:25]
                    io.aluop <= UInt<3>("h4") @[dut.scala 131:32]
                  else :
                    node _T_18 = eq(UInt<1>("h1"), io.funct3) @[dut.scala 125:25]
                    when _T_18 : @[dut.scala 125:25]
                      io.aluop <= UInt<3>("h5") @[dut.scala 132:32]
                    else :
                      node _T_19 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 125:25]
                      when _T_19 : @[dut.scala 125:25]
                        node _T_20 = eq(io.funct7, UInt<6>("h20")) @[dut.scala 134:26]
                        when _T_20 : @[dut.scala 134:38]
                          io.aluop <= UInt<3>("h7") @[dut.scala 134:49]
                        else :
                          io.aluop <= UInt<3>("h6") @[dut.scala 135:35]
      else :
        node _T_21 = eq(UInt<2>("h3"), io.opcode) @[dut.scala 94:21]
        when _T_21 : @[dut.scala 94:21]
          io.aluop <= UInt<1>("h0") @[dut.scala 142:16]
          io.immsrc <= UInt<1>("h1") @[dut.scala 143:17]
          io.memread <= UInt<1>("h1") @[dut.scala 144:18]
          io.regwrite <= UInt<1>("h1") @[dut.scala 145:19]
          io.memtoreg <= UInt<1>("h1") @[dut.scala 146:19]
        else :
          node _T_22 = eq(UInt<6>("h23"), io.opcode) @[dut.scala 94:21]
          when _T_22 : @[dut.scala 94:21]
            io.aluop <= UInt<1>("h0") @[dut.scala 151:16]
            io.immsrc <= UInt<1>("h1") @[dut.scala 152:17]
            io.memwrite <= UInt<1>("h1") @[dut.scala 153:19]
          else :
            node _T_23 = eq(UInt<7>("h63"), io.opcode) @[dut.scala 94:21]
            when _T_23 : @[dut.scala 94:21]
              io.isbranch <= UInt<1>("h1") @[dut.scala 158:19]
              node _io_aluop_T = bits(io.funct3, 2, 2) @[dut.scala 159:32]
              node _io_aluop_T_1 = mux(_io_aluop_T, UInt<4>("h9"), UInt<4>("h8")) @[dut.scala 159:22]
              io.aluop <= _io_aluop_T_1 @[dut.scala 159:16]
            else :
              node _T_24 = eq(UInt<7>("h6f"), io.opcode) @[dut.scala 94:21]
              when _T_24 : @[dut.scala 94:21]
                io.isjump <= UInt<1>("h1") @[dut.scala 164:17]
                io.regwrite <= UInt<1>("h1") @[dut.scala 165:19]
                io.immsrc <= UInt<1>("h1") @[dut.scala 166:17]
              else :
                node _T_25 = eq(UInt<7>("h67"), io.opcode) @[dut.scala 94:21]
                when _T_25 : @[dut.scala 94:21]
                  io.isjump <= UInt<1>("h1") @[dut.scala 171:17]
                  io.pcsel <= UInt<1>("h1") @[dut.scala 172:16]
                  io.regwrite <= UInt<1>("h1") @[dut.scala 173:19]
                  io.immsrc <= UInt<1>("h1") @[dut.scala 174:17]
                else :
                  node _T_26 = eq(UInt<6>("h37"), io.opcode) @[dut.scala 94:21]
                  when _T_26 : @[dut.scala 94:21]
                    io.isupper <= UInt<1>("h1") @[dut.scala 179:18]
                    io.islui <= UInt<1>("h1") @[dut.scala 180:16]
                    io.regwrite <= UInt<1>("h1") @[dut.scala 181:19]
                    io.immsrc <= UInt<1>("h1") @[dut.scala 182:17]
                  else :
                    node _T_27 = eq(UInt<5>("h17"), io.opcode) @[dut.scala 94:21]
                    when _T_27 : @[dut.scala 94:21]
                      io.isupper <= UInt<1>("h1") @[dut.scala 185:18]
                      io.rdsel <= UInt<1>("h1") @[dut.scala 186:16]
                      io.regwrite <= UInt<1>("h1") @[dut.scala 187:19]
                      io.immsrc <= UInt<1>("h1") @[dut.scala 188:17]


