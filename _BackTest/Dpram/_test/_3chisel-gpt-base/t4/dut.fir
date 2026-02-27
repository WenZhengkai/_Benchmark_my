circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip porta_we : UInt<1>, flip porta_en : UInt<1>, flip porta_clk : Clock, flip porta_data_in : UInt<32>, flip porta_addr : UInt<14>, porta_data_out : UInt<32>, flip portb_we : UInt<1>, flip portb_en : UInt<1>, flip portb_clk : Clock, flip portb_data_in : UInt<32>, flip portb_addr : UInt<14>, portb_data_out : UInt<32>}

    smem mem : UInt<32> [16384] @[dut.scala 34:24]
    node _T = and(io.porta_we, io.porta_en) @[dut.scala 41:22]
    when _T : @[dut.scala 41:38]
      write mport MPORT = mem[io.porta_addr], io.porta_clk
      MPORT <= io.porta_data_in
    wire porta_reg_out : UInt<32> @[dut.scala 48:34]
    porta_reg_out <= UInt<32>("h0") @[dut.scala 48:34]
    node _porta_reg_out_T = eq(io.porta_we, UInt<1>("h0")) @[dut.scala 49:59]
    node _porta_reg_out_T_1 = and(io.porta_en, _porta_reg_out_T) @[dut.scala 49:56]
    wire _porta_reg_out_WIRE : UInt @[dut.scala 49:28]
    _porta_reg_out_WIRE is invalid @[dut.scala 49:28]
    when _porta_reg_out_T_1 : @[dut.scala 49:28]
      _porta_reg_out_WIRE <= io.porta_addr @[dut.scala 49:28]
      node _porta_reg_out_T_2 = or(_porta_reg_out_WIRE, UInt<14>("h0")) @[dut.scala 49:28]
      node _porta_reg_out_T_3 = bits(_porta_reg_out_T_2, 13, 0) @[dut.scala 49:28]
      read mport porta_reg_out_MPORT = mem[_porta_reg_out_T_3], clock @[dut.scala 49:28]
    porta_reg_out <= porta_reg_out_MPORT @[dut.scala 49:17]
    reg porta_data_out_reg : UInt, clock with :
      reset => (UInt<1>("h0"), porta_data_out_reg) @[dut.scala 53:37]
    porta_data_out_reg <= porta_reg_out @[dut.scala 53:37]
    io.porta_data_out <= porta_data_out_reg @[dut.scala 54:23]
    node _T_1 = and(io.portb_we, io.portb_en) @[dut.scala 64:22]
    when _T_1 : @[dut.scala 64:38]
      write mport MPORT_1 = mem[io.portb_addr], io.portb_clk
      MPORT_1 <= io.portb_data_in
    wire portb_reg_out : UInt<32> @[dut.scala 71:34]
    portb_reg_out <= UInt<32>("h0") @[dut.scala 71:34]
    node _portb_reg_out_T = eq(io.portb_we, UInt<1>("h0")) @[dut.scala 72:59]
    node _portb_reg_out_T_1 = and(io.portb_en, _portb_reg_out_T) @[dut.scala 72:56]
    wire _portb_reg_out_WIRE : UInt @[dut.scala 72:28]
    _portb_reg_out_WIRE is invalid @[dut.scala 72:28]
    when _portb_reg_out_T_1 : @[dut.scala 72:28]
      _portb_reg_out_WIRE <= io.portb_addr @[dut.scala 72:28]
      node _portb_reg_out_T_2 = or(_portb_reg_out_WIRE, UInt<14>("h0")) @[dut.scala 72:28]
      node _portb_reg_out_T_3 = bits(_portb_reg_out_T_2, 13, 0) @[dut.scala 72:28]
      read mport portb_reg_out_MPORT = mem[_portb_reg_out_T_3], clock @[dut.scala 72:28]
    portb_reg_out <= portb_reg_out_MPORT @[dut.scala 72:17]
    reg portb_data_out_reg : UInt, clock with :
      reset => (UInt<1>("h0"), portb_data_out_reg) @[dut.scala 76:37]
    portb_data_out_reg <= portb_reg_out @[dut.scala 76:37]
    io.portb_data_out <= portb_data_out_reg @[dut.scala 77:23]

