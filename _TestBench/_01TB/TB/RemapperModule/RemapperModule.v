module RemapperModule(
  input   clock,
  input   reset,
  input   io_remap_ldsts_oh_0_0,
  input   io_remap_ldsts_oh_0_1,
  input   io_remap_pdsts_0,
  input   io_com_remap_ldsts_oh_0_0,
  input   io_com_remap_ldsts_oh_0_1,
  input   io_com_remap_pdsts_0,
  output  io_remap_table_out_0_0,
  output  io_remap_table_out_0_1,
  output  io_remap_table_out_1_0,
  output  io_remap_table_out_1_1,
  output  io_com_remap_table_out_0_0,
  output  io_com_remap_table_out_0_1,
  output  io_com_remap_table_out_1_0,
  output  io_com_remap_table_out_1_1
);
  assign io_remap_table_out_0_0 = 1'h0; // @[rename.scala 19:25 31:25]
  assign io_remap_table_out_0_1 = 1'h0; // @[rename.scala 19:25 31:25]
  assign io_remap_table_out_1_0 = io_remap_ldsts_oh_0_0 & io_remap_pdsts_0; // @[rename.scala 25:69]
  assign io_remap_table_out_1_1 = io_remap_ldsts_oh_0_1 & io_remap_pdsts_0; // @[rename.scala 25:69]
  assign io_com_remap_table_out_0_0 = 1'h0; // @[rename.scala 20:29 32:29]
  assign io_com_remap_table_out_0_1 = 1'h0; // @[rename.scala 20:29 32:29]
  assign io_com_remap_table_out_1_0 = io_com_remap_ldsts_oh_0_0 & io_com_remap_pdsts_0; // @[rename.scala 28:73]
  assign io_com_remap_table_out_1_1 = io_com_remap_ldsts_oh_0_1 & io_com_remap_pdsts_0; // @[rename.scala 28:73]
endmodule
