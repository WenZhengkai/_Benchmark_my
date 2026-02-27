circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portAClk : Clock, flip portAEna : UInt<1>, flip portAWe : UInt<1>, flip portAAddr : UInt<14>, flip portADataIn : UInt<32>, portADataOut : UInt<32>, flip portBClk : Clock, flip portBEna : UInt<1>, flip portBWe : UInt<1>, flip portBAddr : UInt<14>, flip portBDataIn : UInt<32>, portBDataOut : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 36:24]
    reg portADataOutReg : UInt<32>, io.portAClk with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 40:12]
    when io.portAEna : @[dut.scala 44:23]
      when io.portAWe : @[dut.scala 45:24]
        write mport MPORT = mem[io.portAAddr], io.portAClk
        MPORT <= io.portADataIn
      else :
        wire _portADataOutReg_WIRE : UInt @[dut.scala 50:38]
        _portADataOutReg_WIRE is invalid @[dut.scala 50:38]
        when UInt<1>("h1") : @[dut.scala 50:38]
          _portADataOutReg_WIRE <= io.portAAddr @[dut.scala 50:38]
          node _portADataOutReg_T = or(_portADataOutReg_WIRE, UInt<14>("h0")) @[dut.scala 50:38]
          node _portADataOutReg_T_1 = bits(_portADataOutReg_T, 13, 0) @[dut.scala 50:38]
          read mport portADataOutReg_MPORT = mem[_portADataOutReg_T_1], io.portAClk @[dut.scala 50:38]
        portADataOutReg <= portADataOutReg_MPORT @[dut.scala 50:27]
    reg portBDataOutReg : UInt<32>, io.portBClk with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 58:12]
    when io.portBEna : @[dut.scala 62:23]
      when io.portBWe : @[dut.scala 63:24]
        write mport MPORT_1 = mem[io.portBAddr], io.portBClk
        MPORT_1 <= io.portBDataIn
      else :
        wire _portBDataOutReg_WIRE : UInt @[dut.scala 68:38]
        _portBDataOutReg_WIRE is invalid @[dut.scala 68:38]
        when UInt<1>("h1") : @[dut.scala 68:38]
          _portBDataOutReg_WIRE <= io.portBAddr @[dut.scala 68:38]
          node _portBDataOutReg_T = or(_portBDataOutReg_WIRE, UInt<14>("h0")) @[dut.scala 68:38]
          node _portBDataOutReg_T_1 = bits(_portBDataOutReg_T, 13, 0) @[dut.scala 68:38]
          read mport portBDataOutReg_MPORT = mem[_portBDataOutReg_T_1], io.portBClk @[dut.scala 68:38]
        portBDataOutReg <= portBDataOutReg_MPORT @[dut.scala 68:27]
    io.portADataOut <= portADataOutReg @[dut.scala 86:23]
    io.portBDataOut <= portBDataOutReg @[dut.scala 87:23]

