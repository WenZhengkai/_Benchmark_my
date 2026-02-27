circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portawe : UInt<1>, flip portbwe : UInt<1>, flip portaena : UInt<1>, flip portbena : UInt<1>, flip portaclk : Clock, flip portbclk : Clock, flip portadatain : UInt<32>, flip portbdatain : UInt<32>, flip portaaddr : UInt<14>, flip portbaddr : UInt<14>, portadataout : UInt<32>, portbdataout : UInt<32>}

    smem dpram_content : UInt<32> [16384] @[dut.scala 33:34]
    reg portadataout_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), portadataout_reg) @[dut.scala 36:29]
    reg portbdataout_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), portbdataout_reg) @[dut.scala 37:29]
    when io.portaena : @[dut.scala 41:23]
      when io.portawe : @[dut.scala 42:24]
        write mport MPORT = dpram_content[io.portaaddr], io.portaclk
        MPORT <= io.portadatain
      else :
        wire _readData_WIRE : UInt @[dut.scala 47:42]
        _readData_WIRE is invalid @[dut.scala 47:42]
        when UInt<1>("h1") : @[dut.scala 47:42]
          _readData_WIRE <= io.portaaddr @[dut.scala 47:42]
          node _readData_T = or(_readData_WIRE, UInt<14>("h0")) @[dut.scala 47:42]
          node _readData_T_1 = bits(_readData_T, 13, 0) @[dut.scala 47:42]
          read mport readData = dpram_content[_readData_T_1], io.portaclk @[dut.scala 47:42]
        portadataout_reg <= readData @[dut.scala 49:28]
    when io.portbena : @[dut.scala 59:23]
      when io.portbwe : @[dut.scala 60:24]
        write mport MPORT_1 = dpram_content[io.portbaddr], io.portbclk
        MPORT_1 <= io.portbdatain
      else :
        wire _readData_WIRE_1 : UInt @[dut.scala 65:42]
        _readData_WIRE_1 is invalid @[dut.scala 65:42]
        when UInt<1>("h1") : @[dut.scala 65:42]
          _readData_WIRE_1 <= io.portbaddr @[dut.scala 65:42]
          node _readData_T_2 = or(_readData_WIRE_1, UInt<14>("h0")) @[dut.scala 65:42]
          node _readData_T_3 = bits(_readData_T_2, 13, 0) @[dut.scala 65:42]
          read mport readData_1 = dpram_content[_readData_T_3], io.portbclk @[dut.scala 65:42]
        portbdataout_reg <= readData_1 @[dut.scala 67:28]
    io.portadataout <= portadataout_reg @[dut.scala 77:21]
    io.portbdataout <= portbdataout_reg @[dut.scala 78:21]

