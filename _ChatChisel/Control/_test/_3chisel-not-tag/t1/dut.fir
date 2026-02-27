circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip opcode : UInt<7>, flip funct7 : UInt<7>, flip funct3 : UInt<3>, aluop : UInt<4>, immsrc : UInt<1>, isbranch : UInt<1>, memread : UInt<1>, memwrite : UInt<1>, regwrite : UInt<1>, memtoreg : UInt<2>, pcsel : UInt<1>, rdsel : UInt<1>, isjump : UInt<1>, isupper : UInt<1>, islui : UInt<1>}

    io.aluop <= UInt<1>("h0") @[dut.scala 24:16]
    io.immsrc <= UInt<1>("h0") @[dut.scala 25:16]
    io.isbranch <= UInt<1>("h0") @[dut.scala 26:16]
    io.memread <= UInt<1>("h0") @[dut.scala 27:16]
    io.memwrite <= UInt<1>("h0") @[dut.scala 28:16]
    io.regwrite <= UInt<1>("h0") @[dut.scala 29:16]
    io.memtoreg <= UInt<1>("h0") @[dut.scala 30:16]
    io.pcsel <= UInt<1>("h0") @[dut.scala 31:16]
    io.rdsel <= UInt<1>("h0") @[dut.scala 32:16]
    io.isjump <= UInt<1>("h0") @[dut.scala 33:16]
    io.isupper <= UInt<1>("h0") @[dut.scala 34:16]
    io.islui <= UInt<1>("h0") @[dut.scala 35:16]
    node _T = eq(UInt<7>("h33"), io.opcode) @[dut.scala 80:21]
    when _T : @[dut.scala 80:21]
      io.immsrc <= UInt<1>("h0") @[dut.scala 83:17]
      io.regwrite <= UInt<1>("h1") @[dut.scala 84:19]
      io.memtoreg <= UInt<2>("h2") @[dut.scala 85:19]
      node _T_1 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 87:25]
      when _T_1 : @[dut.scala 87:25]
        node _io_aluop_T = eq(io.funct7, UInt<7>("h20")) @[dut.scala 89:37]
        node _io_aluop_T_1 = mux(_io_aluop_T, UInt<4>("h1"), UInt<4>("h0")) @[dut.scala 89:26]
        io.aluop <= _io_aluop_T_1 @[dut.scala 89:20]
      else :
        node _T_2 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 87:25]
        when _T_2 : @[dut.scala 87:25]
          io.aluop <= UInt<4>("h2") @[dut.scala 91:32]
        else :
          node _T_3 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 87:25]
          when _T_3 : @[dut.scala 87:25]
            io.aluop <= UInt<4>("h3") @[dut.scala 92:32]
          else :
            node _T_4 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 87:25]
            when _T_4 : @[dut.scala 87:25]
              io.aluop <= UInt<4>("h4") @[dut.scala 93:32]
            else :
              node _T_5 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 87:25]
              when _T_5 : @[dut.scala 87:25]
                io.aluop <= UInt<4>("h5") @[dut.scala 94:32]
              else :
                node _T_6 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 87:25]
                when _T_6 : @[dut.scala 87:25]
                  node _io_aluop_T_2 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 95:49]
                  node _io_aluop_T_3 = mux(_io_aluop_T_2, UInt<4>("h7"), UInt<4>("h6")) @[dut.scala 95:38]
                  io.aluop <= _io_aluop_T_3 @[dut.scala 95:32]
                else :
                  node _T_7 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 87:25]
                  when _T_7 : @[dut.scala 87:25]
                    io.aluop <= UInt<4>("h8") @[dut.scala 96:32]
                  else :
                    node _T_8 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 87:25]
                    when _T_8 : @[dut.scala 87:25]
                      io.aluop <= UInt<4>("h9") @[dut.scala 97:32]
    else :
      node _T_9 = eq(UInt<7>("h13"), io.opcode) @[dut.scala 80:21]
      when _T_9 : @[dut.scala 80:21]
        io.immsrc <= UInt<1>("h1") @[dut.scala 103:17]
        io.regwrite <= UInt<1>("h1") @[dut.scala 104:19]
        io.memtoreg <= UInt<2>("h2") @[dut.scala 105:19]
        node _T_10 = eq(UInt<3>("h4"), io.funct3) @[dut.scala 107:25]
        when _T_10 : @[dut.scala 107:25]
          io.aluop <= UInt<4>("h2") @[dut.scala 108:31]
        else :
          node _T_11 = eq(UInt<3>("h6"), io.funct3) @[dut.scala 107:25]
          when _T_11 : @[dut.scala 107:25]
            io.aluop <= UInt<4>("h3") @[dut.scala 109:31]
          else :
            node _T_12 = eq(UInt<3>("h7"), io.funct3) @[dut.scala 107:25]
            when _T_12 : @[dut.scala 107:25]
              io.aluop <= UInt<4>("h4") @[dut.scala 110:31]
            else :
              node _T_13 = eq(UInt<3>("h1"), io.funct3) @[dut.scala 107:25]
              when _T_13 : @[dut.scala 107:25]
                io.aluop <= UInt<4>("h5") @[dut.scala 111:31]
              else :
                node _T_14 = eq(UInt<3>("h5"), io.funct3) @[dut.scala 107:25]
                when _T_14 : @[dut.scala 107:25]
                  node _io_aluop_T_4 = eq(io.funct7, UInt<7>("h20")) @[dut.scala 112:48]
                  node _io_aluop_T_5 = mux(_io_aluop_T_4, UInt<4>("h7"), UInt<4>("h6")) @[dut.scala 112:37]
                  io.aluop <= _io_aluop_T_5 @[dut.scala 112:31]
                else :
                  node _T_15 = eq(UInt<3>("h0"), io.funct3) @[dut.scala 107:25]
                  when _T_15 : @[dut.scala 107:25]
                    io.aluop <= UInt<4>("h0") @[dut.scala 113:31]
                  else :
                    node _T_16 = eq(UInt<3>("h2"), io.funct3) @[dut.scala 107:25]
                    when _T_16 : @[dut.scala 107:25]
                      io.aluop <= UInt<4>("h8") @[dut.scala 114:31]
                    else :
                      node _T_17 = eq(UInt<3>("h3"), io.funct3) @[dut.scala 107:25]
                      when _T_17 : @[dut.scala 107:25]
                        io.aluop <= UInt<4>("h9") @[dut.scala 115:32]
      else :
        node _T_18 = eq(UInt<7>("h3"), io.opcode) @[dut.scala 80:21]
        when _T_18 : @[dut.scala 80:21]
          io.aluop <= UInt<4>("h0") @[dut.scala 121:16]
          io.immsrc <= UInt<1>("h1") @[dut.scala 122:17]
          io.memread <= UInt<1>("h1") @[dut.scala 123:18]
          io.regwrite <= UInt<1>("h1") @[dut.scala 124:19]
          io.memtoreg <= UInt<2>("h1") @[dut.scala 125:19]
        else :
          node _T_19 = eq(UInt<7>("h23"), io.opcode) @[dut.scala 80:21]
          when _T_19 : @[dut.scala 80:21]
            io.aluop <= UInt<4>("h0") @[dut.scala 130:16]
            io.immsrc <= UInt<1>("h1") @[dut.scala 131:17]
            io.memwrite <= UInt<1>("h1") @[dut.scala 132:19]
          else :
            node _T_20 = eq(UInt<7>("h63"), io.opcode) @[dut.scala 80:21]
            when _T_20 : @[dut.scala 80:21]
              io.isbranch <= UInt<1>("h1") @[dut.scala 137:19]
              node _io_aluop_T_6 = eq(io.funct3, UInt<3>("h3")) @[dut.scala 138:33]
              node _io_aluop_T_7 = mux(_io_aluop_T_6, UInt<4>("h9"), UInt<4>("h8")) @[dut.scala 138:22]
              io.aluop <= _io_aluop_T_7 @[dut.scala 138:16]
            else :
              node _T_21 = eq(UInt<7>("h6f"), io.opcode) @[dut.scala 80:21]
              when _T_21 : @[dut.scala 80:21]
                io.isjump <= UInt<1>("h1") @[dut.scala 143:17]
                io.regwrite <= UInt<1>("h1") @[dut.scala 144:19]
                io.immsrc <= UInt<1>("h1") @[dut.scala 145:17]
              else :
                node _T_22 = eq(UInt<7>("h67"), io.opcode) @[dut.scala 80:21]
                when _T_22 : @[dut.scala 80:21]
                  io.isjump <= UInt<1>("h1") @[dut.scala 150:17]
                  io.pcsel <= UInt<1>("h1") @[dut.scala 151:16]
                  io.regwrite <= UInt<1>("h1") @[dut.scala 152:19]
                  io.immsrc <= UInt<1>("h1") @[dut.scala 153:17]
                else :
                  node _T_23 = eq(UInt<7>("h37"), io.opcode) @[dut.scala 80:21]
                  when _T_23 : @[dut.scala 80:21]
                    io.isupper <= UInt<1>("h1") @[dut.scala 158:18]
                    io.islui <= UInt<1>("h1") @[dut.scala 159:16]
                    io.regwrite <= UInt<1>("h1") @[dut.scala 160:19]
                    io.immsrc <= UInt<1>("h1") @[dut.scala 161:17]
                  else :
                    node _T_24 = eq(UInt<7>("h17"), io.opcode) @[dut.scala 80:21]
                    when _T_24 : @[dut.scala 80:21]
                      io.isupper <= UInt<1>("h1") @[dut.scala 166:18]
                      io.rdsel <= UInt<1>("h1") @[dut.scala 167:16]
                      io.regwrite <= UInt<1>("h1") @[dut.scala 168:19]
                      io.immsrc <= UInt<1>("h1") @[dut.scala 169:17]


