circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portaWE : UInt<1>, flip portaEn : UInt<1>, flip portaClk : Clock, flip portaAddr : UInt<14>, flip portaDataIn : UInt<32>, portaDataOut : UInt<32>, flip portbWE : UInt<1>, flip portbEn : UInt<1>, flip portbClk : Clock, flip portbAddr : UInt<14>, flip portbDataIn : UInt<32>, portbDataOut : UInt<32>}

    smem dpram : UInt<32> [16384] @[dut.scala 30:26]
    reg portARegOut : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 33:28]
    reg portBRegOut : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 34:28]
    node _T = and(io.portaWE, io.portaEn) @[dut.scala 38:21]
    when _T : @[dut.scala 38:36]
      write mport MPORT = dpram[io.portaAddr], io.portaClk
      MPORT <= io.portaDataIn
    wire portaReadData : UInt<32> @[dut.scala 42:29]
    portaReadData <= UInt<1>("h0") @[dut.scala 43:19]
    when io.portaEn : @[dut.scala 45:22]
      node _portaReadData_T = eq(io.portaWE, UInt<1>("h0")) @[dut.scala 46:49]
      wire _portaReadData_WIRE : UInt @[dut.scala 46:34]
      _portaReadData_WIRE is invalid @[dut.scala 46:34]
      when _portaReadData_T : @[dut.scala 46:34]
        _portaReadData_WIRE <= io.portaAddr @[dut.scala 46:34]
        node _portaReadData_T_1 = or(_portaReadData_WIRE, UInt<14>("h0")) @[dut.scala 46:34]
        node _portaReadData_T_2 = bits(_portaReadData_T_1, 13, 0) @[dut.scala 46:34]
        read mport portaReadData_MPORT = dpram[_portaReadData_T_2], io.portaClk @[dut.scala 46:34]
      portaReadData <= portaReadData_MPORT @[dut.scala 46:21]
    portARegOut <= portaReadData @[dut.scala 51:19]
    io.portaDataOut <= portARegOut @[dut.scala 52:23]
    node _T_1 = and(io.portbWE, io.portbEn) @[dut.scala 60:21]
    when _T_1 : @[dut.scala 60:36]
      write mport MPORT_1 = dpram[io.portbAddr], io.portbClk
      MPORT_1 <= io.portbDataIn
    wire portbReadData : UInt<32> @[dut.scala 64:29]
    portbReadData <= UInt<1>("h0") @[dut.scala 65:19]
    when io.portbEn : @[dut.scala 67:22]
      node _portbReadData_T = eq(io.portbWE, UInt<1>("h0")) @[dut.scala 68:49]
      wire _portbReadData_WIRE : UInt @[dut.scala 68:34]
      _portbReadData_WIRE is invalid @[dut.scala 68:34]
      when _portbReadData_T : @[dut.scala 68:34]
        _portbReadData_WIRE <= io.portbAddr @[dut.scala 68:34]
        node _portbReadData_T_1 = or(_portbReadData_WIRE, UInt<14>("h0")) @[dut.scala 68:34]
        node _portbReadData_T_2 = bits(_portbReadData_T_1, 13, 0) @[dut.scala 68:34]
        read mport portbReadData_MPORT = dpram[_portbReadData_T_2], io.portbClk @[dut.scala 68:34]
      portbReadData <= portbReadData_MPORT @[dut.scala 68:21]
    portBRegOut <= portbReadData @[dut.scala 73:19]
    io.portbDataOut <= portBRegOut @[dut.scala 74:23]

