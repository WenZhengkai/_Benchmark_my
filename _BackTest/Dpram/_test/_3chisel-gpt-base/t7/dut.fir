circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portaClk : Clock, flip portaWE : UInt<1>, flip portaEnA : UInt<1>, flip portaAddr : UInt<14>, flip portaDataIn : UInt<32>, portaDataOut : UInt<32>, flip portbClk : Clock, flip portbWE : UInt<1>, flip portbEnA : UInt<1>, flip portbAddr : UInt<14>, flip portbDataIn : UInt<32>, portbDataOut : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 37:24]
    reg portaReg : UInt<32>, io.portaClk with :
      reset => (UInt<1>("h0"), portaReg) @[dut.scala 41:23]
    when io.portaEnA : @[dut.scala 42:23]
      when io.portaWE : @[dut.scala 44:24]
        write mport MPORT = mem[io.portaAddr], io.portaClk
        MPORT <= io.portaDataIn
      node _portaReg_T = eq(io.portaWE, UInt<1>("h0")) @[dut.scala 48:42]
      wire _portaReg_WIRE : UInt @[dut.scala 48:27]
      _portaReg_WIRE is invalid @[dut.scala 48:27]
      when _portaReg_T : @[dut.scala 48:27]
        _portaReg_WIRE <= io.portaAddr @[dut.scala 48:27]
        node _portaReg_T_1 = or(_portaReg_WIRE, UInt<14>("h0")) @[dut.scala 48:27]
        node _portaReg_T_2 = bits(_portaReg_T_1, 13, 0) @[dut.scala 48:27]
        read mport portaReg_MPORT = mem[_portaReg_T_2], io.portaClk @[dut.scala 48:27]
      portaReg <= portaReg_MPORT @[dut.scala 48:16]
    node _io_portaDataOut_T = eq(io.portaWE, UInt<1>("h0")) @[dut.scala 50:74]
    wire _io_portaDataOut_WIRE : UInt @[dut.scala 50:59]
    _io_portaDataOut_WIRE is invalid @[dut.scala 50:59]
    when _io_portaDataOut_T : @[dut.scala 50:59]
      _io_portaDataOut_WIRE <= io.portaAddr @[dut.scala 50:59]
      node _io_portaDataOut_T_1 = or(_io_portaDataOut_WIRE, UInt<14>("h0")) @[dut.scala 50:59]
      node _io_portaDataOut_T_2 = bits(_io_portaDataOut_T_1, 13, 0) @[dut.scala 50:59]
      read mport io_portaDataOut_MPORT = mem[_io_portaDataOut_T_2], io.portaClk @[dut.scala 50:59]
    node _io_portaDataOut_T_3 = mux(UInt<1>("h1"), portaReg, io_portaDataOut_MPORT) @[dut.scala 50:27]
    io.portaDataOut <= _io_portaDataOut_T_3 @[dut.scala 50:21]
    reg portbReg : UInt<32>, io.portbClk with :
      reset => (UInt<1>("h0"), portbReg) @[dut.scala 55:23]
    when io.portbEnA : @[dut.scala 56:23]
      when io.portbWE : @[dut.scala 58:24]
        write mport MPORT_1 = mem[io.portbAddr], io.portbClk
        MPORT_1 <= io.portbDataIn
      node _portbReg_T = eq(io.portbWE, UInt<1>("h0")) @[dut.scala 62:42]
      wire _portbReg_WIRE : UInt @[dut.scala 62:27]
      _portbReg_WIRE is invalid @[dut.scala 62:27]
      when _portbReg_T : @[dut.scala 62:27]
        _portbReg_WIRE <= io.portbAddr @[dut.scala 62:27]
        node _portbReg_T_1 = or(_portbReg_WIRE, UInt<14>("h0")) @[dut.scala 62:27]
        node _portbReg_T_2 = bits(_portbReg_T_1, 13, 0) @[dut.scala 62:27]
        read mport portbReg_MPORT = mem[_portbReg_T_2], io.portbClk @[dut.scala 62:27]
      portbReg <= portbReg_MPORT @[dut.scala 62:16]
    node _io_portbDataOut_T = eq(io.portbWE, UInt<1>("h0")) @[dut.scala 64:74]
    wire _io_portbDataOut_WIRE : UInt @[dut.scala 64:59]
    _io_portbDataOut_WIRE is invalid @[dut.scala 64:59]
    when _io_portbDataOut_T : @[dut.scala 64:59]
      _io_portbDataOut_WIRE <= io.portbAddr @[dut.scala 64:59]
      node _io_portbDataOut_T_1 = or(_io_portbDataOut_WIRE, UInt<14>("h0")) @[dut.scala 64:59]
      node _io_portbDataOut_T_2 = bits(_io_portbDataOut_T_1, 13, 0) @[dut.scala 64:59]
      read mport io_portbDataOut_MPORT = mem[_io_portbDataOut_T_2], io.portbClk @[dut.scala 64:59]
    node _io_portbDataOut_T_3 = mux(UInt<1>("h1"), portbReg, io_portbDataOut_MPORT) @[dut.scala 64:27]
    io.portbDataOut <= _io_portbDataOut_T_3 @[dut.scala 64:21]

