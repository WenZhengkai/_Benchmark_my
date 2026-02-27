circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip opcode : UInt<7>, flip funct7 : UInt<7>, flip funct3 : UInt<3>, aluop : UInt<4>, immsrc : UInt<1>, isbranch : UInt<1>, memread : UInt<1>, memwrite : UInt<1>, regwrite : UInt<1>, memtoreg : UInt<2>, pcsel : UInt<1>, rdsel : UInt<1>, isjump : UInt<1>, isupper : UInt<1>, islui : UInt<1>}

    io.aluop <= UInt<1>("h0") @[dut.scala 66:12]
    io.immsrc <= UInt<1>("h0") @[dut.scala 67:13]
    io.isbranch <= UInt<1>("h0") @[dut.scala 68:15]
    io.memread <= UInt<1>("h0") @[dut.scala 69:14]
    io.memwrite <= UInt<1>("h0") @[dut.scala 70:15]
    io.regwrite <= UInt<1>("h0") @[dut.scala 71:15]
    io.memtoreg <= UInt<2>("h0") @[dut.scala 72:15]
    io.pcsel <= UInt<1>("h0") @[dut.scala 73:12]
    io.rdsel <= UInt<1>("h0") @[dut.scala 74:12]
    io.isjump <= UInt<1>("h0") @[dut.scala 75:13]
    io.isupper <= UInt<1>("h0") @[dut.scala 76:14]
    io.islui <= UInt<1>("h0") @[dut.scala 77:12]
    node _T = eq(UInt<7>("h33"), io.opcode) @[dut.scala 80:21]
    when _T : @[dut.scala 80:21]
      io.immsrc <= UInt<1>("h0") @[dut.scala 83:17]
      io.regwrite <= UInt<1>("h1") @[dut.scala 84:19]
      io.memtoreg <= UInt<2>("h2") @[dut.scala 85:19]
      node _T_1 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 86:25]
      when _T_1 : @[dut.scala 86:25]
        node _io_aluop_T = eq(io.funct7, UInt<7>("h20")) @[dut.scala 88:37]
        node _io_aluop_T_1 = mux(_io_aluop_T, UInt<4>("h1"), UInt<4>("h0")) @[dut.scala 88:26]
        io.aluop <= _io_aluop_T_1 @[dut.scala 88:20]
      else :
        node _T_2 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 86:25]
        when _T_2 : @[dut.scala 86:25]
          io.aluop <= UInt<4>("h5") @[dut.scala 90:31]
        else :
          node _T_3 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 86:25]
          when _T_3 : @[dut.scala 86:25]
            io.aluop <= UInt<4>("h8") @[dut.scala 91:31]
          else :
            node _T_4 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 86:25]
            when _T_4 : @[dut.scala 86:25]
              io.aluop <= UInt<4>("h9") @[dut.scala 92:32]
            else :
              node _T_5 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 86:25]
              when _T_5 : @[dut.scala 86:25]
                io.aluop <= UInt<4>("h2") @[dut.scala 93:31]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 86:25]
                when _T_6 : @[dut.scala 86:25]
                  io.aluop <= UInt<4>("h3") @[dut.scala 94:30]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 86:25]
                  when _T_7 : @[dut.scala 86:25]
                    io.aluop <= UInt<4>("h4") @[dut.scala 95:31]
                  else :
                    node _T_8 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 86:25]
                    when _T_8 : @[dut.scala 86:25]
                      node _io_aluop_T_2 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 97:37]
                      node _io_aluop_T_3 = mux(_io_aluop_T_2, UInt<4>("h7"), UInt<4>("h6")) @[dut.scala 97:26]
                      io.aluop <= _io_aluop_T_3 @[dut.scala 97:20]
    else :
      node _T_9 = eq(UInt<7>("h13"), io.opcode) @[dut.scala 80:21]
      when _T_9 : @[dut.scala 80:21]
        io.immsrc <= UInt<1>("h1") @[dut.scala 104:17]
        io.regwrite <= UInt<1>("h1") @[dut.scala 105:19]
        io.memtoreg <= UInt<2>("h2") @[dut.scala 106:19]
        node _T_10 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 107:25]
        when _T_10 : @[dut.scala 107:25]
          io.aluop <= UInt<4>("h0") @[dut.scala 108:35]
        else :
          node _T_11 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 107:25]
          when _T_11 : @[dut.scala 107:25]
            io.aluop <= UInt<4>("h5") @[dut.scala 109:31]
          else :
            node _T_12 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 107:25]
            when _T_12 : @[dut.scala 107:25]
              io.aluop <= UInt<4>("h8") @[dut.scala 110:31]
            else :
              node _T_13 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 107:25]
              when _T_13 : @[dut.scala 107:25]
                io.aluop <= UInt<4>("h9") @[dut.scala 111:32]
              else :
                node _T_14 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 107:25]
                when _T_14 : @[dut.scala 107:25]
                  io.aluop <= UInt<4>("h2") @[dut.scala 112:31]
                else :
                  node _T_15 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 107:25]
                  when _T_15 : @[dut.scala 107:25]
                    io.aluop <= UInt<4>("h3") @[dut.scala 113:30]
                  else :
                    node _T_16 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 107:25]
                    when _T_16 : @[dut.scala 107:25]
                      io.aluop <= UInt<4>("h4") @[dut.scala 114:31]
                    else :
                      node _T_17 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 107:25]
                      when _T_17 : @[dut.scala 107:25]
                        node _io_aluop_T_4 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 116:37]
                        node _io_aluop_T_5 = mux(_io_aluop_T_4, UInt<4>("h7"), UInt<4>("h6")) @[dut.scala 116:26]
                        io.aluop <= _io_aluop_T_5 @[dut.scala 116:20]
      else :
        node _T_18 = eq(UInt<7>("h3"), io.opcode) @[dut.scala 80:21]
        when _T_18 : @[dut.scala 80:21]
          io.immsrc <= UInt<1>("h1") @[dut.scala 123:17]
          io.memread <= UInt<1>("h1") @[dut.scala 124:18]
          io.regwrite <= UInt<1>("h1") @[dut.scala 125:19]
          io.memtoreg <= UInt<2>("h1") @[dut.scala 126:19]
          io.aluop <= UInt<4>("h0") @[dut.scala 127:16]
        else :
          node _T_19 = eq(UInt<7>("h23"), io.opcode) @[dut.scala 80:21]
          when _T_19 : @[dut.scala 80:21]
            io.immsrc <= UInt<1>("h1") @[dut.scala 132:17]
            io.memwrite <= UInt<1>("h1") @[dut.scala 133:19]
            io.aluop <= UInt<4>("h0") @[dut.scala 134:16]
          else :
            node _T_20 = eq(UInt<7>("h63"), io.opcode) @[dut.scala 80:21]
            when _T_20 : @[dut.scala 80:21]
              io.isbranch <= UInt<1>("h1") @[dut.scala 139:19]
              node _T_21 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 140:25]
              when _T_21 : @[dut.scala 140:25]
                io.aluop <= UInt<4>("h8") @[dut.scala 141:35]
              else :
                node _T_22 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 140:25]
                when _T_22 : @[dut.scala 140:25]
                  io.aluop <= UInt<4>("h9") @[dut.scala 142:35]
            else :
              node _T_23 = eq(UInt<7>("h6f"), io.opcode) @[dut.scala 80:21]
              when _T_23 : @[dut.scala 80:21]
                io.isjump <= UInt<1>("h1") @[dut.scala 148:17]
                io.regwrite <= UInt<1>("h1") @[dut.scala 149:19]
                io.immsrc <= UInt<1>("h1") @[dut.scala 150:17]
              else :
                node _T_24 = eq(UInt<7>("h67"), io.opcode) @[dut.scala 80:21]
                when _T_24 : @[dut.scala 80:21]
                  io.isjump <= UInt<1>("h1") @[dut.scala 153:17]
                  io.pcsel <= UInt<1>("h1") @[dut.scala 154:16]
                  io.regwrite <= UInt<1>("h1") @[dut.scala 155:19]
                  io.immsrc <= UInt<1>("h1") @[dut.scala 156:17]
                else :
                  node _T_25 = eq(UInt<7>("h37"), io.opcode) @[dut.scala 80:21]
                  when _T_25 : @[dut.scala 80:21]
                    io.isupper <= UInt<1>("h1") @[dut.scala 161:18]
                    io.islui <= UInt<1>("h1") @[dut.scala 162:16]
                    io.regwrite <= UInt<1>("h1") @[dut.scala 163:19]
                    io.immsrc <= UInt<1>("h1") @[dut.scala 164:17]
                  else :
                    node _T_26 = eq(UInt<7>("h17"), io.opcode) @[dut.scala 80:21]
                    when _T_26 : @[dut.scala 80:21]
                      io.isupper <= UInt<1>("h1") @[dut.scala 167:18]
                      io.rdsel <= UInt<1>("h1") @[dut.scala 168:16]
                      io.regwrite <= UInt<1>("h1") @[dut.scala 169:19]
                      io.immsrc <= UInt<1>("h1") @[dut.scala 170:17]


