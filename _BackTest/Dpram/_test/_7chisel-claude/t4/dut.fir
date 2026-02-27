circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portaclk : Clock, flip portaena : UInt<1>, flip portawe : UInt<1>, flip portaaddr : UInt<14>, flip portadatain : UInt<32>, portadataout : UInt<32>, flip portbclk : Clock, flip portbena : UInt<1>, flip portbwe : UInt<1>, flip portbaddr : UInt<14>, flip portbdatain : UInt<32>, portbdataout : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 33:24]
    reg portaDataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 36:32]
    when io.portaena : @[dut.scala 39:23]
      when io.portawe : @[dut.scala 40:24]
        write mport MPORT = mem[io.portaaddr], io.portaclk
        MPORT <= io.portadatain
      else :
        wire _readData_WIRE : UInt @[dut.scala 44:32]
        _readData_WIRE is invalid @[dut.scala 44:32]
        when UInt<1>("h1") : @[dut.scala 44:32]
          _readData_WIRE <= io.portaaddr @[dut.scala 44:32]
          node _readData_T = or(_readData_WIRE, UInt<14>("h0")) @[dut.scala 44:32]
          node _readData_T_1 = bits(_readData_T, 13, 0) @[dut.scala 44:32]
          read mport readData = mem[_readData_T_1], io.portaclk @[dut.scala 44:32]
        portaDataOutReg <= readData @[dut.scala 46:27]
    reg portbDataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 55:32]
    when io.portbena : @[dut.scala 58:23]
      when io.portbwe : @[dut.scala 59:24]
        write mport MPORT_1 = mem[io.portbaddr], io.portbclk
        MPORT_1 <= io.portbdatain
      else :
        wire _readData_WIRE_1 : UInt @[dut.scala 63:32]
        _readData_WIRE_1 is invalid @[dut.scala 63:32]
        when UInt<1>("h1") : @[dut.scala 63:32]
          _readData_WIRE_1 <= io.portbaddr @[dut.scala 63:32]
          node _readData_T_2 = or(_readData_WIRE_1, UInt<14>("h0")) @[dut.scala 63:32]
          node _readData_T_3 = bits(_readData_T_2, 13, 0) @[dut.scala 63:32]
          read mport readData_1 = mem[_readData_T_3], io.portbclk @[dut.scala 63:32]
        portbDataOutReg <= readData_1 @[dut.scala 65:27]
    io.portadataout <= portaDataOutReg @[dut.scala 75:21]
    io.portbdataout <= portbDataOutReg @[dut.scala 76:21]

