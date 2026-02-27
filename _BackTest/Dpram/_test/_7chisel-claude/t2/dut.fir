circuit dut :
  module DualPortRam :
    input clock : Clock
    input reset : Reset
    output io : { flip portaclk : Clock, flip portaena : UInt<1>, flip portawe : UInt<1>, flip portaaddr : UInt<14>, flip portadatain : UInt<32>, portadataout : UInt<32>, flip portbclk : Clock, flip portbena : UInt<1>, flip portbwe : UInt<1>, flip portbaddr : UInt<14>, flip portbdatain : UInt<32>, portbdataout : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 32:24]
    reg portaDataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 35:32]
    reg portbDataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 36:32]
    when io.portaena : @[dut.scala 40:23]
      when io.portawe : @[dut.scala 41:24]
        write mport MPORT = mem[io.portaaddr], io.portaclk
        MPORT <= io.portadatain
      else :
        wire _portaDataOutReg_WIRE : UInt @[dut.scala 47:38]
        _portaDataOutReg_WIRE is invalid @[dut.scala 47:38]
        when UInt<1>("h1") : @[dut.scala 47:38]
          _portaDataOutReg_WIRE <= io.portaaddr @[dut.scala 47:38]
          node _portaDataOutReg_T = or(_portaDataOutReg_WIRE, UInt<14>("h0")) @[dut.scala 47:38]
          node _portaDataOutReg_T_1 = bits(_portaDataOutReg_T, 13, 0) @[dut.scala 47:38]
          read mport portaDataOutReg_MPORT = mem[_portaDataOutReg_T_1], io.portaclk @[dut.scala 47:38]
        portaDataOutReg <= portaDataOutReg_MPORT @[dut.scala 47:27]
    when io.portbena : @[dut.scala 56:25]
      when io.portbwe : @[dut.scala 57:26]
        write mport MPORT_1 = mem[io.portbaddr], io.portbclk
        MPORT_1 <= io.portbdatain
      else :
        wire _portbDataOutReg_WIRE : UInt @[dut.scala 63:40]
        _portbDataOutReg_WIRE is invalid @[dut.scala 63:40]
        when UInt<1>("h1") : @[dut.scala 63:40]
          _portbDataOutReg_WIRE <= io.portbaddr @[dut.scala 63:40]
          node _portbDataOutReg_T = or(_portbDataOutReg_WIRE, UInt<14>("h0")) @[dut.scala 63:40]
          node _portbDataOutReg_T_1 = bits(_portbDataOutReg_T, 13, 0) @[dut.scala 63:40]
          read mport portbDataOutReg_MPORT = mem[_portbDataOutReg_T_1], io.portbclk @[dut.scala 63:40]
        portbDataOutReg <= portbDataOutReg_MPORT @[dut.scala 63:29]
    io.portadataout <= portaDataOutReg @[dut.scala 72:21]
    io.portbdataout <= portbDataOutReg @[dut.scala 73:21]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portaena : UInt<1>, flip portawe : UInt<1>, flip portaaddr : UInt<14>, flip portadatain : UInt<32>, portadataout : UInt<32>, flip portbena : UInt<1>, flip portbwe : UInt<1>, flip portbaddr : UInt<14>, flip portbdatain : UInt<32>, portbdataout : UInt<32>}

    inst ram of DualPortRam @[dut.scala 120:19]
    ram.clock <= clock
    ram.reset <= reset
    ram.io.portaclk <= clock @[dut.scala 129:19]
    ram.io.portaena <= io.portaena @[dut.scala 130:19]
    ram.io.portawe <= io.portawe @[dut.scala 131:18]
    ram.io.portaaddr <= io.portaaddr @[dut.scala 132:20]
    ram.io.portadatain <= io.portadatain @[dut.scala 133:22]
    io.portadataout <= ram.io.portadataout @[dut.scala 134:19]
    ram.io.portbclk <= clock @[dut.scala 136:19]
    ram.io.portbena <= io.portbena @[dut.scala 137:19]
    ram.io.portbwe <= io.portbwe @[dut.scala 138:18]
    ram.io.portbaddr <= io.portbaddr @[dut.scala 139:20]
    ram.io.portbdatain <= io.portbdatain @[dut.scala 140:22]
    io.portbdataout <= ram.io.portbdataout @[dut.scala 141:19]

