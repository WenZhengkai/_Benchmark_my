circuit dut :
  module PortLogic :
    input clock : Clock
    input reset : Reset
    output io : { flip ena : UInt<1>, flip we : UInt<1>, flip addr : UInt<14>, flip dataIn : UInt<32>, flip readData : UInt<32>, dataOut : UInt<32>}

    reg dataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 151:29]
    node _T = eq(io.we, UInt<1>("h0")) @[dut.scala 153:20]
    node _T_1 = and(io.ena, _T) @[dut.scala 153:17]
    when _T_1 : @[dut.scala 153:28]
      dataOutReg <= io.readData @[dut.scala 154:18]
    io.dataOut <= dataOutReg @[dut.scala 157:16]

  module PortLogic_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip ena : UInt<1>, flip we : UInt<1>, flip addr : UInt<14>, flip dataIn : UInt<32>, flip readData : UInt<32>, dataOut : UInt<32>}

    reg dataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 151:29]
    node _T = eq(io.we, UInt<1>("h0")) @[dut.scala 153:20]
    node _T_1 = and(io.ena, _T) @[dut.scala 153:17]
    when _T_1 : @[dut.scala 153:28]
      dataOutReg <= io.readData @[dut.scala 154:18]
    io.dataOut <= dataOutReg @[dut.scala 157:16]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portAClk : Clock, flip portAEna : UInt<1>, flip portAWe : UInt<1>, flip portAAddr : UInt<14>, flip portADataIn : UInt<32>, portADataOut : UInt<32>, flip portBClk : Clock, flip portBEna : UInt<1>, flip portBWe : UInt<1>, flip portBAddr : UInt<14>, flip portBDataIn : UInt<32>, portBDataOut : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 34:24]
    inst portALogic of PortLogic @[dut.scala 38:11]
    portALogic.clock <= io.portAClk
    portALogic.reset <= reset
    portALogic.io.ena <= io.portAEna @[dut.scala 41:21]
    portALogic.io.we <= io.portAWe @[dut.scala 42:20]
    portALogic.io.addr <= io.portAAddr @[dut.scala 43:22]
    portALogic.io.dataIn <= io.portADataIn @[dut.scala 44:24]
    io.portADataOut <= portALogic.io.dataOut @[dut.scala 45:19]
    inst portBLogic of PortLogic_1 @[dut.scala 49:11]
    portBLogic.clock <= io.portBClk
    portBLogic.reset <= reset
    portBLogic.io.ena <= io.portBEna @[dut.scala 52:21]
    portBLogic.io.we <= io.portBWe @[dut.scala 53:20]
    portBLogic.io.addr <= io.portBAddr @[dut.scala 54:22]
    portBLogic.io.dataIn <= io.portBDataIn @[dut.scala 55:24]
    io.portBDataOut <= portBLogic.io.dataOut @[dut.scala 56:19]
    when io.portAEna : @[dut.scala 62:23]
      when io.portAWe : @[dut.scala 63:24]
        write mport MPORT = mem[io.portAAddr], clock
        MPORT <= io.portADataIn
        portALogic.io.readData is invalid @[dut.scala 65:32]
      else :
        wire _portALogic_io_readData_WIRE : UInt @[dut.scala 67:43]
        _portALogic_io_readData_WIRE is invalid @[dut.scala 67:43]
        when UInt<1>("h1") : @[dut.scala 67:43]
          _portALogic_io_readData_WIRE <= io.portAAddr @[dut.scala 67:43]
          node _portALogic_io_readData_T = or(_portALogic_io_readData_WIRE, UInt<14>("h0")) @[dut.scala 67:43]
          node _portALogic_io_readData_T_1 = bits(_portALogic_io_readData_T, 13, 0) @[dut.scala 67:43]
          read mport portALogic_io_readData_MPORT = mem[_portALogic_io_readData_T_1], clock @[dut.scala 67:43]
        portALogic.io.readData <= portALogic_io_readData_MPORT @[dut.scala 67:32]
    else :
      portALogic.io.readData is invalid @[dut.scala 70:30]
    when io.portBEna : @[dut.scala 74:23]
      when io.portBWe : @[dut.scala 75:24]
        write mport MPORT_1 = mem[io.portBAddr], clock
        MPORT_1 <= io.portBDataIn
        portBLogic.io.readData is invalid @[dut.scala 77:32]
      else :
        wire _portBLogic_io_readData_WIRE : UInt @[dut.scala 79:43]
        _portBLogic_io_readData_WIRE is invalid @[dut.scala 79:43]
        when UInt<1>("h1") : @[dut.scala 79:43]
          _portBLogic_io_readData_WIRE <= io.portBAddr @[dut.scala 79:43]
          node _portBLogic_io_readData_T = or(_portBLogic_io_readData_WIRE, UInt<14>("h0")) @[dut.scala 79:43]
          node _portBLogic_io_readData_T_1 = bits(_portBLogic_io_readData_T, 13, 0) @[dut.scala 79:43]
          read mport portBLogic_io_readData_MPORT = mem[_portBLogic_io_readData_T_1], clock @[dut.scala 79:43]
        portBLogic.io.readData <= portBLogic_io_readData_MPORT @[dut.scala 79:32]
    else :
      portBLogic.io.readData is invalid @[dut.scala 82:30]


