circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip csr_read_data_in : UInt<32>, flip wb_reg_pc : UInt<32>, flip wb_readdata : UInt<32>, flip wb_aluresult : UInt<32>, flip wb_memtoreg : UInt<2>, writedata : UInt<32>}

    io.writedata <= UInt<1>("h0") @[dut.scala 17:16]
    node _T = eq(UInt<1>("h0"), io.wb_memtoreg) @[dut.scala 18:26]
    when _T : @[dut.scala 18:26]
      io.writedata <= io.wb_reg_pc @[dut.scala 19:28]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.wb_memtoreg) @[dut.scala 18:26]
      when _T_1 : @[dut.scala 18:26]
        io.writedata <= io.wb_readdata @[dut.scala 20:28]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.wb_memtoreg) @[dut.scala 18:26]
        when _T_2 : @[dut.scala 18:26]
          io.writedata <= io.wb_aluresult @[dut.scala 21:28]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.wb_memtoreg) @[dut.scala 18:26]
          when _T_3 : @[dut.scala 18:26]
            io.writedata <= io.csr_read_data_in @[dut.scala 22:28]


