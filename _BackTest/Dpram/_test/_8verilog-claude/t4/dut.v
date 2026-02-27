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

    // Port definitions
    input                       portawe, portbwe;
    input                       portaena, portbena;
    input                       portaclk, portbclk;
    input      [width-1:0]      portadatain, portbdatain;
    input      [addrwidth-1:0]  portaaddr, portbaddr;
    output     [width-1:0]      portadataout, portbdataout;

    // Internal storage
    reg        [width-1:0]      dpram_content[depth-1:0];
    
    // Internal signals
    reg                        portaclk_in, portbclk_in;
    reg                        portaena_in, portbena_in;
    reg        [width-1:0]     portadatain_in, portbdatain_in;
    reg        [addrwidth-1:0] portaaddr_in, portbaddr_in;
    
    reg                        portawe_latched, portbwe_latched;
    reg        [addrwidth-1:0] portaaddr_latched, portbaddr_latched;
    
    reg        [width-1:0]     portadataout_tmp, portbdataout_tmp;
    reg        [width-1:0]     portadataout_reg, portbdataout_reg;
    reg        [width-1:0]     portadataout_reg_out, portbdataout_reg_out;
    reg        [width-1:0]     portadataout_tmp2, portbdataout_tmp2;

    // Output assignments
    assign portadataout = portadataout_tmp2;
    assign portbdataout = portbdataout_tmp2;

    // Initialize memory if a file is specified
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end

    // Port A operation
    always @(posedge portaclk) begin
        portaclk_in <= portaclk;
        portaena_in <= portaena;
        portadatain_in <= portadatain;
        portaaddr_in <= portaaddr;
        
        if (portaena) begin
            portawe_latched <= portawe;
            portaaddr_latched <= portaaddr;
            
            if (portawe) begin
                // Write operation
                dpram_content[portaaddr] <= portadatain;
                
                // Handle simultaneous write to same address from both ports
                if (portbwe_latched && (portaaddr == portbaddr_latched)) begin
                    dpram_content[portaaddr] <= 'bx;  // Undefined behavior
                end
            end
            else begin
                // Read operation
                if (portbwe_latched && (portaaddr == portbaddr_latched)) begin
                    portadataout_tmp <= 'bx;  // Conflict - read during write
                end
                else begin
                    portadataout_tmp <= dpram_content[portaaddr];
                end
            end
            
            // Handle registered output mode
            portadataout_reg <= portadataout_tmp;
        end
    end

    // Port B operation
    always @(posedge portbclk) begin
        portbclk_in <= portbclk;
        portbena_in <= portbena;
        portbdatain_in <= portbdatain;
        portbaddr_in <= portbaddr;
        
        if (portbena) begin
            portbwe_latched <= portbwe;
            portbaddr_latched <= portbaddr;
            
            if (portbwe) begin
                // Write operation
                dpram_content[portbaddr] <= portbdatain;
                
                // Handle simultaneous write to same address from both ports
                if (portawe_latched && (portbaddr == portaaddr_latched)) begin
                    dpram_content[portbaddr] <= 'bx;  // Undefined behavior
                end
            end
            else begin
                // Read operation
                if (portawe_latched && (portbaddr == portaaddr_latched)) begin
                    portbdataout_tmp <= 'bx;  // Conflict - read during write
                end
                else begin
                    portbdataout_tmp <= dpram_content[portbaddr];
                end
            end
            
            // Handle registered output mode
            portbdataout_reg <= portbdataout_tmp;
        end
    end

    // Output mode handling for Port A
    always @(portadataout_tmp or portadataout_reg or portaena) begin
        if (output_mode == "REG") begin
            if (portaena) begin
                portadataout_reg_out <= portadataout_reg;
            end
            portadataout_tmp2 <= portadataout_reg_out;
        end
        else begin  // "UNREG" mode
            portadataout_tmp2 <= portadataout_tmp;
        end
    end

    // Output mode handling for Port B
    always @(portbdataout_tmp or portbdataout_reg or portbena) begin
        if (output_mode == "REG") begin
            if (portbena) begin
                portbdataout_reg_out <= portbdataout_reg;
            end
            portbdataout_tmp2 <= portbdataout_reg_out;
        end
        else begin  // "UNREG" mode
            portbdataout_tmp2 <= portbdataout_tmp;
        end
    end

endmodule
