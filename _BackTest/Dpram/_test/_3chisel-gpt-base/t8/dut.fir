circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portawe : UInt<1>, flip portbwe : UInt<1>, flip portaena : UInt<1>, flip portbena : UInt<1>, flip portaclk : Clock, flip portbclk : Clock, flip portadatain : UInt<32>, flip portbdatain : UInt<32>, flip portaaddr : UInt<14>, flip portbaddr : UInt<14>, portadataout : UInt<32>, portbdataout : UInt<32>}

    smem dpram : UInt<32> [16384] @[dut.scala 31:26]
    reg portadataoutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 34:32]
    reg portbdataoutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 35:32]
    wire readDataA : UInt<32> @[dut.scala 38:23]
    wire _readDataA_WIRE : UInt @[dut.scala 39:26]
    _readDataA_WIRE is invalid @[dut.scala 39:26]
    when io.portaena : @[dut.scala 39:26]
      _readDataA_WIRE <= io.portaaddr @[dut.scala 39:26]
      node _readDataA_T = or(_readDataA_WIRE, UInt<14>("h0")) @[dut.scala 39:26]
      node _readDataA_T_1 = bits(_readDataA_T, 13, 0) @[dut.scala 39:26]
      read mport readDataA_MPORT = dpram[_readDataA_T_1], clock @[dut.scala 39:26]
    readDataA <= readDataA_MPORT @[dut.scala 39:13]
    wire readDataB : UInt<32> @[dut.scala 42:23]
    wire _readDataB_WIRE : UInt @[dut.scala 43:26]
    _readDataB_WIRE is invalid @[dut.scala 43:26]
    when io.portbena : @[dut.scala 43:26]
      _readDataB_WIRE <= io.portbaddr @[dut.scala 43:26]
      node _readDataB_T = or(_readDataB_WIRE, UInt<14>("h0")) @[dut.scala 43:26]
      node _readDataB_T_1 = bits(_readDataB_T, 13, 0) @[dut.scala 43:26]
      read mport readDataB_MPORT = dpram[_readDataB_T_1], clock @[dut.scala 43:26]
    readDataB <= readDataB_MPORT @[dut.scala 43:13]
    node _T = and(io.portaena, io.portawe) @[dut.scala 47:22]
    when _T : @[dut.scala 47:37]
      write mport MPORT = dpram[io.portaaddr], io.portaclk
      MPORT <= io.portadatain
    node _T_1 = and(io.portbena, io.portbwe) @[dut.scala 54:22]
    when _T_1 : @[dut.scala 54:37]
      write mport MPORT_1 = dpram[io.portbaddr], io.portbclk
      MPORT_1 <= io.portbdatain
    portadataoutReg <= readDataA @[dut.scala 63:23]
    portbdataoutReg <= readDataB @[dut.scala 66:23]
    io.portadataout <= portadataoutReg @[dut.scala 68:21]
    io.portbdataout <= portbdataoutReg @[dut.scala 69:21]

