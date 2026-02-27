module dut (
    portawe, portbwe,
    portaena, portbena,
    portaclk, portbclk,
    portadatain, portbdatain,
    portaaddr, portbaddr,
    portadataout, portbdataout
);

    // Module parameters
    parameter   operation_mode = "DUAL_PORT";
    parameter   addrwidth      = 14;
    parameter   width          = 32;
    parameter   depth          = 16384;
    parameter   ramblock       = 65535;
    parameter   output_mode    = "REG";
    parameter   lpm_file       = "NONE";
    parameter   lpm_type       = "alt_exc_dpram";
    parameter   lpm_hint       = "UNUSED";

    // Port declarations
    input                     portawe, portbwe;
    input                     portaena, portbena;
    input                     portaclk, portbclk;
    input      [width-1:0]    portadatain, portbdatain;
    input      [addrwidth-1:0] portaaddr, portbaddr;
    output     [width-1:0]    portadataout, portbdataout;

    // Internal memory storage
    reg        [width-1:0]    dpram_content [depth-1:0];
    
    // Internal signals
    reg                       portawe_latched, portbwe_latched;
    reg        [addrwidth-1:0] portaaddr_latched, portbaddr_latched;
    reg        [width-1:0]    portadataout_tmp, portbdataout_tmp;
    reg        [width-1:0]    portadataout_reg, portbdataout_reg;
    reg        [width-1:0]    portadataout_reg_out, portbdataout_reg_out;
    reg        [width-1:0]    portadataout_tmp2, portbdataout_tmp2;
    
    // Registered input signals
    reg                       portaclk_in, portbclk_in;
    reg                       portaena_in, portbena_in;
    reg        [width-1:0]    portadatain_in, portbdatain_in;
    reg        [addrwidth-1:0] portaaddr_in, portbaddr_in;
    
    // Wire assignments for outputs
    assign portadataout = portadataout_tmp2;
    assign portbdataout = portbdataout_tmp2;
    
    // Initialize memory if file is specified
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end
    
    // Input signal buffering
    always @* begin
        portaclk_in = portaclk;
        portbclk_in = portbclk;
        portaena_in = portaena;
        portbena_in = portbena;
        portadatain_in = portadatain;
        portbdatain_in = portbdatain;
        portaaddr_in = portaaddr;
        portbaddr_in = portbaddr;
    end
    
    // Port A operation
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            if (portawe) begin
                // Write operation on port A
                dpram_content[portaaddr_in] = portadatain_in;
                portawe_latched = 1'b1;
                portaaddr_latched = portaaddr_in;
            end else begin
                // Read operation on port A
                portadataout_tmp = dpram_content[portaaddr_in];
                portawe_latched = 1'b0;
                portaaddr_latched = portaaddr_in;
            end
            
            // Handle registered output for port A
            if (output_mode == "REG") begin
                portadataout_reg <= portadataout_tmp;
            end
        end
    end
    
    // Port B operation (only in dual port mode)
    always @(posedge portbclk_in) begin
        if (portbena_in && operation_mode == "DUAL_PORT") begin
            if (portbwe) begin
                // Write operation on port B
                dpram_content[portbaddr_in] = portbdatain_in;
                portbwe_latched = 1'b1;
                portbaddr_latched = portbaddr_in;
            end else begin
                // Read operation on port B
                portbdataout_tmp = dpram_content[portbaddr_in];
                portbwe_latched = 1'b0;
                portbaddr_latched = portbaddr_in;
            end
            
            // Handle registered output for port B
            if (output_mode == "REG") begin
                portbdataout_reg <= portbdataout_tmp;
            end
        end
    end
    
    // Check for port conflicts and set output
    always @* begin
        // Default assignments
        portadataout_reg_out = portadataout_reg;
        portbdataout_reg_out = portbdataout_reg;
        
        // Handle write-read conflicts
        if (portawe_latched && !portbwe_latched && 
            portaaddr_latched == portbaddr_latched && 
            operation_mode == "DUAL_PORT") begin
            // Port A wrote to an address that Port B is reading from
            portbdataout_tmp = {width{1'bx}}; // Undefined result
        end
        
        if (!portawe_latched && portbwe_latched && 
            portaaddr_latched == portbaddr_latched && 
            operation_mode == "DUAL_PORT") begin
            // Port B wrote to an address that Port A is reading from
            portadataout_tmp = {width{1'bx}}; // Undefined result
        end
        
        // Check for simultaneous write to same address
        if (portawe_latched && portbwe_latched && 
            portaaddr_latched == portbaddr_latched && 
            operation_mode == "DUAL_PORT") begin
            // Both ports wrote to the same address - result is undefined
            dpram_content[portaaddr_latched] = {width{1'bx}};
        end
        
        // Set final outputs based on output mode
        if (output_mode == "REG") begin
            portadataout_tmp2 = portadataout_reg_out;
            portbdataout_tmp2 = portbdataout_reg_out;
        end else begin
            portadataout_tmp2 = portadataout_tmp;
            portbdataout_tmp2 = portbdataout_tmp;
        end
    end

endmodule
