module dut (
    // Port A signals
    input                      portaclk,
    input                      portaena,
    input                      portawe,
    input      [addrwidth-1:0] portaaddr,
    input      [width-1:0]     portadatain,
    output reg [width-1:0]     portadataout,
    
    // Port B signals
    input                      portbclk,
    input                      portbena,
    input                      portbwe,
    input      [addrwidth-1:0] portbaddr,
    input      [width-1:0]     portbdatain,
    output reg [width-1:0]     portbdataout
);

    // Parameters
    parameter operation_mode = "DUAL_PORT";
    parameter addrwidth      = 14;
    parameter width          = 32;
    parameter depth          = 16384;
    parameter ramblock       = 65535;
    parameter output_mode    = "REG";
    parameter lpm_file       = "NONE";
    parameter lpm_type       = "alt_exc_dpram";
    parameter lpm_hint       = "UNUSED";

    // Internal memory array
    reg [width-1:0] dpram_content [0:depth-1];
    
    // Internal signals
    reg [width-1:0] portadataout_tmp, portbdataout_tmp;
    reg [width-1:0] portadataout_reg, portbdataout_reg;
    reg [width-1:0] portadataout_reg_out, portbdataout_reg_out;
    reg [width-1:0] portadataout_tmp2, portbdataout_tmp2;
    
    reg portawe_latched, portbwe_latched;
    reg [addrwidth-1:0] portaaddr_latched, portbaddr_latched;
    
    // Input buffer registers
    reg portaclk_in, portbclk_in;
    reg portaena_in, portbena_in;
    reg [width-1:0] portadatain_in, portbdatain_in;
    reg [addrwidth-1:0] portaaddr_in, portbaddr_in;
    
    // Initialize memory if lpm_file is specified
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end
    
    // Input buffering
    always @(*) begin
        portaclk_in = portaclk;
        portbclk_in = portbclk;
        portaena_in = portaena;
        portbena_in = portbena;
        portadatain_in = portadatain;
        portbdatain_in = portbdatain;
        portaaddr_in = portaaddr;
        portbaddr_in = portbaddr;
    end
    
    // Port A operations
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            if (portawe) begin
                // Write operation on Port A
                dpram_content[portaaddr_in] <= portadatain_in;
                portawe_latched <= 1'b1;
            end else begin
                portawe_latched <= 1'b0;
            end
            portaaddr_latched <= portaaddr_in;
            
            // Register output if in REG mode
            if (output_mode == "REG") begin
                portadataout_reg <= dpram_content[portaaddr_in];
            end
        end
    end
    
    // Port B operations
    always @(posedge portbclk_in) begin
        if (portbena_in) begin
            if (portbwe) begin
                // Write operation on Port B
                dpram_content[portbaddr_in] <= portbdatain_in;
                portbwe_latched <= 1'b1;
            end else begin
                portbwe_latched <= 1'b0;
            end
            portbaddr_latched <= portbaddr_in;
            
            // Register output if in REG mode
            if (output_mode == "REG") begin
                portbdataout_reg <= dpram_content[portbaddr_in];
            end
        end
    end
    
    // Handle read conflicts
    always @(*) begin
        // Port A read data
        if (portawe_latched) begin
            // If last operation was write, output the written data
            portadataout_tmp = portadatain_in;
        end else begin
            // Normal read
            portadataout_tmp = dpram_content[portaaddr_latched];
            
            // Check for write conflict with Port B
            if (portbwe_latched && (portaaddr_latched == portbaddr_latched)) begin
                // Conflict: Port B writes to the same address Port A is reading from
                portadataout_tmp = 'bx; // Set to unknown
            end
        end
        
        // Port B read data
        if (portbwe_latched) begin
            // If last operation was write, output the written data
            portbdataout_tmp = portbdatain_in;
        end else begin
            // Normal read
            portbdataout_tmp = dpram_content[portbaddr_latched];
            
            // Check for write conflict with Port A
            if (portawe_latched && (portbaddr_latched == portaaddr_latched)) begin
                // Conflict: Port A writes to the same address Port B is reading from
                portbdataout_tmp = 'bx; // Set to unknown
            end
        end
    end
    
    // Output mode selection
    always @(*) begin
        if (output_mode == "REG") begin
            // Registered output mode
            portadataout_reg_out = portadataout_reg;
            portbdataout_reg_out = portbdataout_reg;
            portadataout_tmp2 = portadataout_reg_out;
            portbdataout_tmp2 = portbdataout_reg_out;
        end else begin
            // Unregistered output mode (direct)
            portadataout_tmp2 = portadataout_tmp;
            portbdataout_tmp2 = portbdataout_tmp;
        end
        
        // Final output assignment
        portadataout = portadataout_tmp2;
        portbdataout = portbdataout_tmp2;
    end

endmodule
