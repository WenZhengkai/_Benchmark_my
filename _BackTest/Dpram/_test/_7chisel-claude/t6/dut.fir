circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip portAEnable : UInt<1>, flip portAWrite : UInt<1>, flip portAAddr : UInt<14>, flip portADataIn : UInt<32>, portADataOut : UInt<32>, flip portBEnable : UInt<1>, flip portBWrite : UInt<1>, flip portBAddr : UInt<14>, flip portBDataIn : UInt<32>, portBDataOut : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 30:24]
    reg portADataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 33:32]
    reg portBDataOutReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 36:32]
    when io.portAEnable : @[dut.scala 39:24]
      when io.portAWrite : @[dut.scala 40:25]
        write mport MPORT = mem[io.portAAddr], clock
        MPORT <= io.portADataIn
        portADataOutReg is invalid @[dut.scala 45:25]
      else :
        wire _readData_WIRE : UInt @[dut.scala 49:30]
        _readData_WIRE is invalid @[dut.scala 49:30]
        when UInt<1>("h1") : @[dut.scala 49:30]
          _readData_WIRE <= io.portAAddr @[dut.scala 49:30]
          node _readData_T = or(_readData_WIRE, UInt<14>("h0")) @[dut.scala 49:30]
          node _readData_T_1 = bits(_readData_T, 13, 0) @[dut.scala 49:30]
          read mport readData = mem[_readData_T_1], clock @[dut.scala 49:30]
        portADataOutReg <= readData @[dut.scala 51:25]
    when io.portBEnable : @[dut.scala 60:26]
      when io.portBWrite : @[dut.scala 61:27]
        write mport MPORT_1 = mem[io.portBAddr], clock
        MPORT_1 <= io.portBDataIn
        portBDataOutReg is invalid @[dut.scala 66:27]
      else :
        wire _readData_WIRE_1 : UInt @[dut.scala 70:32]
        _readData_WIRE_1 is invalid @[dut.scala 70:32]
        when UInt<1>("h1") : @[dut.scala 70:32]
          _readData_WIRE_1 <= io.portBAddr @[dut.scala 70:32]
          node _readData_T_2 = or(_readData_WIRE_1, UInt<14>("h0")) @[dut.scala 70:32]
          node _readData_T_3 = bits(_readData_T_2, 13, 0) @[dut.scala 70:32]
          read mport readData_1 = mem[_readData_T_3], clock @[dut.scala 70:32]
        portBDataOutReg <= readData_1 @[dut.scala 72:27]
    io.portADataOut <= portADataOutReg @[dut.scala 85:21]
    io.portBDataOut <= portBDataOutReg @[dut.scala 86:21]
    node _T = and(io.portAEnable, io.portBEnable) @[dut.scala 91:23]
    node _T_1 = eq(io.portAAddr, io.portBAddr) @[dut.scala 91:57]
    node _T_2 = and(_T, _T_1) @[dut.scala 91:41]
    node _T_3 = or(io.portAWrite, io.portBWrite) @[dut.scala 92:23]
    node _T_4 = and(_T_2, _T_3) @[dut.scala 91:74]
    when _T_4 : @[dut.scala 92:42]
      node _T_5 = bits(reset, 0, 0) @[dut.scala 93:11]
      node _T_6 = eq(_T_5, UInt<1>("h0")) @[dut.scala 93:11]
      when _T_6 : @[dut.scala 93:11]
        printf(clock, UInt<1>("h1"), "Warning: Potential read/write collision detected at address %d\n", io.portAAddr) : printf @[dut.scala 93:11]


