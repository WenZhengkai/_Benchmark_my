circuit dut :
  module DualPortRam :
    input clock : Clock
    input reset : Reset
    output io : { flip portaclk : Clock, flip portaena : UInt<1>, flip portawe : UInt<1>, flip portaaddr : UInt<14>, flip portadatain : UInt<32>, portadataout : UInt<32>, flip portbclk : Clock, flip portbena : UInt<1>, flip portbwe : UInt<1>, flip portbaddr : UInt<14>, flip portbdatain : UInt<32>, portbdataout : UInt<32>}

    smem memory : UInt<32> [16384] @[dut.scala 34:27]
    reg portaClockDomain_addrReg : UInt, io.portaclk with :
      reset => (UInt<1>("h0"), portaClockDomain_addrReg) @[dut.scala 38:26]
    portaClockDomain_addrReg <= io.portaaddr @[dut.scala 38:26]
    wire portaClockDomain_portaDataOut : UInt<32> @[dut.scala 39:28]
    when io.portaena : @[dut.scala 41:24]
      when io.portawe : @[dut.scala 42:25]
        write mport portaClockDomain_MPORT = memory[io.portaaddr], io.portaclk
        portaClockDomain_MPORT <= io.portadatain
        wire _portaClockDomain_portaDataOut_WIRE : UInt @[dut.scala 46:38]
        _portaClockDomain_portaDataOut_WIRE is invalid @[dut.scala 46:38]
        when UInt<1>("h1") : @[dut.scala 46:38]
          _portaClockDomain_portaDataOut_WIRE <= io.portaaddr @[dut.scala 46:38]
          node _portaClockDomain_portaDataOut_T = or(_portaClockDomain_portaDataOut_WIRE, UInt<14>("h0")) @[dut.scala 46:38]
          node _portaClockDomain_portaDataOut_T_1 = bits(_portaClockDomain_portaDataOut_T, 13, 0) @[dut.scala 46:38]
          read mport portaClockDomain_portaDataOut_MPORT = memory[_portaClockDomain_portaDataOut_T_1], io.portaclk @[dut.scala 46:38]
        portaClockDomain_portaDataOut <= portaClockDomain_portaDataOut_MPORT @[dut.scala 46:24]
      else :
        wire _portaClockDomain_portaDataOut_WIRE_1 : UInt @[dut.scala 51:36]
        _portaClockDomain_portaDataOut_WIRE_1 is invalid @[dut.scala 51:36]
        when UInt<1>("h1") : @[dut.scala 51:36]
          _portaClockDomain_portaDataOut_WIRE_1 <= io.portaaddr @[dut.scala 51:36]
          node _portaClockDomain_portaDataOut_T_2 = or(_portaClockDomain_portaDataOut_WIRE_1, UInt<14>("h0")) @[dut.scala 51:36]
          node _portaClockDomain_portaDataOut_T_3 = bits(_portaClockDomain_portaDataOut_T_2, 13, 0) @[dut.scala 51:36]
          read mport portaClockDomain_portaDataOut_MPORT_1 = memory[_portaClockDomain_portaDataOut_T_3], io.portaclk @[dut.scala 51:36]
        portaClockDomain_portaDataOut <= portaClockDomain_portaDataOut_MPORT_1 @[dut.scala 51:22]
    else :
      portaClockDomain_portaDataOut is invalid @[dut.scala 54:20]
    reg portaClockDomain_portaOutput_outReg : UInt, io.portaclk with :
      reset => (UInt<1>("h0"), portaClockDomain_portaOutput_outReg) @[dut.scala 59:27]
    portaClockDomain_portaOutput_outReg <= portaClockDomain_portaDataOut @[dut.scala 59:27]
    reg portaClockDomain_portaOutput_enableReg : UInt<1>, io.portaclk with :
      reset => (UInt<1>("h0"), portaClockDomain_portaOutput_enableReg) @[dut.scala 60:30]
    portaClockDomain_portaOutput_enableReg <= io.portaena @[dut.scala 60:30]
    node portaClockDomain = mux(portaClockDomain_portaOutput_enableReg, portaClockDomain_portaOutput_outReg, UInt<1>("h0")) @[dut.scala 61:10]
    reg portbClockDomain_addrReg : UInt, io.portbclk with :
      reset => (UInt<1>("h0"), portbClockDomain_addrReg) @[dut.scala 71:26]
    portbClockDomain_addrReg <= io.portbaddr @[dut.scala 71:26]
    wire portbClockDomain_portbDataOut : UInt<32> @[dut.scala 72:28]
    when io.portbena : @[dut.scala 74:24]
      when io.portbwe : @[dut.scala 75:25]
        write mport portbClockDomain_MPORT = memory[io.portbaddr], io.portbclk
        portbClockDomain_MPORT <= io.portbdatain
        wire _portbClockDomain_portbDataOut_WIRE : UInt @[dut.scala 81:38]
        _portbClockDomain_portbDataOut_WIRE is invalid @[dut.scala 81:38]
        when UInt<1>("h1") : @[dut.scala 81:38]
          _portbClockDomain_portbDataOut_WIRE <= io.portbaddr @[dut.scala 81:38]
          node _portbClockDomain_portbDataOut_T = or(_portbClockDomain_portbDataOut_WIRE, UInt<14>("h0")) @[dut.scala 81:38]
          node _portbClockDomain_portbDataOut_T_1 = bits(_portbClockDomain_portbDataOut_T, 13, 0) @[dut.scala 81:38]
          read mport portbClockDomain_portbDataOut_MPORT = memory[_portbClockDomain_portbDataOut_T_1], io.portbclk @[dut.scala 81:38]
        portbClockDomain_portbDataOut <= portbClockDomain_portbDataOut_MPORT @[dut.scala 81:24]
      else :
        wire _portbClockDomain_portbDataOut_WIRE_1 : UInt @[dut.scala 86:36]
        _portbClockDomain_portbDataOut_WIRE_1 is invalid @[dut.scala 86:36]
        when UInt<1>("h1") : @[dut.scala 86:36]
          _portbClockDomain_portbDataOut_WIRE_1 <= io.portbaddr @[dut.scala 86:36]
          node _portbClockDomain_portbDataOut_T_2 = or(_portbClockDomain_portbDataOut_WIRE_1, UInt<14>("h0")) @[dut.scala 86:36]
          node _portbClockDomain_portbDataOut_T_3 = bits(_portbClockDomain_portbDataOut_T_2, 13, 0) @[dut.scala 86:36]
          read mport portbClockDomain_portbDataOut_MPORT_1 = memory[_portbClockDomain_portbDataOut_T_3], io.portbclk @[dut.scala 86:36]
        portbClockDomain_portbDataOut <= portbClockDomain_portbDataOut_MPORT_1 @[dut.scala 86:22]
    else :
      portbClockDomain_portbDataOut is invalid @[dut.scala 89:20]
    reg portbClockDomain_portbOutput_outReg : UInt, io.portbclk with :
      reset => (UInt<1>("h0"), portbClockDomain_portbOutput_outReg) @[dut.scala 94:27]
    portbClockDomain_portbOutput_outReg <= portbClockDomain_portbDataOut @[dut.scala 94:27]
    reg portbClockDomain_portbOutput_enableReg : UInt<1>, io.portbclk with :
      reset => (UInt<1>("h0"), portbClockDomain_portbOutput_enableReg) @[dut.scala 95:30]
    portbClockDomain_portbOutput_enableReg <= io.portbena @[dut.scala 95:30]
    node portbClockDomain = mux(portbClockDomain_portbOutput_enableReg, portbClockDomain_portbOutput_outReg, UInt<1>("h0")) @[dut.scala 96:10]
    io.portadataout <= portaClockDomain @[dut.scala 105:19]
    io.portbdataout <= portbClockDomain @[dut.scala 106:19]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portaclk : Clock, flip portaena : UInt<1>, flip portawe : UInt<1>, flip portaaddr : UInt<14>, flip portadatain : UInt<32>, portadataout : UInt<32>, flip portbclk : Clock, flip portbena : UInt<1>, flip portbwe : UInt<1>, flip portbaddr : UInt<14>, flip portbdatain : UInt<32>, portbdataout : UInt<32>}

    inst dpram of DualPortRam @[dut.scala 140:21]
    dpram.clock <= clock
    dpram.reset <= reset
    dpram.io.portaclk <= io.portaclk @[dut.scala 150:21]
    dpram.io.portaena <= io.portaena @[dut.scala 151:21]
    dpram.io.portawe <= io.portawe @[dut.scala 152:20]
    dpram.io.portaaddr <= io.portaaddr @[dut.scala 153:22]
    dpram.io.portadatain <= io.portadatain @[dut.scala 154:24]
    io.portadataout <= dpram.io.portadataout @[dut.scala 155:19]
    dpram.io.portbclk <= io.portbclk @[dut.scala 157:21]
    dpram.io.portbena <= io.portbena @[dut.scala 158:21]
    dpram.io.portbwe <= io.portbwe @[dut.scala 159:20]
    dpram.io.portbaddr <= io.portbaddr @[dut.scala 160:22]
    dpram.io.portbdatain <= io.portbdatain @[dut.scala 161:24]
    io.portbdataout <= dpram.io.portbdataout @[dut.scala 162:19]

