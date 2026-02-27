module dut (
    // Port A inputs
    input                        portaclk,    // Clock for port A
    input                        portaena,    // Enable for port A
    input                        portawe,     // Write enable for port A
    input      [addrwidth-1:0]   portaaddr,   // Address for port A
    input      [width-1:0]       portadatain, // Data input for port A
    output reg [width-1:0]       portadataout, // Data output for port A
    
    // Port B inputs
    input                        portbclk,    // Clock for port B
    input                        portbena,    // Enable for port B
    input                        portbwe,     // Write enable for port B
    input      [addrwidth-1:0]   portbaddr,   // Address for port B
    input      [width-1:0]       portbdatain, // Data input for port B
    output reg [width-1:0]       portbdataout  // Data output for port B
);

    // Parameters
    parameter   operation_mode = "DUAL_PORT";
    parameter   addrwidth      = 14;
    parameter   width          = 32;
    parameter   depth          = 16384;
    parameter   ramblock       = 65535;
    parameter   output_mode    = "REG";
    parameter   lpm_file       = "NONE";
    parameter   lpm_type       = "alt_exc_dpram";
    parameter   lpm_hint       = "UNUSED";

    // Memory array
    reg [width-1:0] dpram_content [0:depth-1];
    
    // Internal signals for port A
    reg                      portaclk_in;
    reg                      portaena_in;
    reg                      portawe_in;
    reg [addrwidth-1:0]      portaaddr_in;
    reg [width-1:0]          portadatain_in;
    reg                      portawe_latched;
    reg [addrwidth-1:0]      portaaddr_latched;
    reg [width-1:0]          portadataout_tmp;
    reg [width-1:0]          portadataout_reg;
    reg [width-1:0]          portadataout_reg_out;
    reg [width-1:0]          portadataout_tmp2;
    
    // Internal signals for port B
    reg                      portbclk_in;
    reg                      portbena_in;
    reg                      portbwe_in;
    reg [addrwidth-1:0]      portbaddr_in;
    reg [width-1:0]          portbdatain_in;
    reg                      portbwe_latched;
    reg [addrwidth-1:0]      portbaddr_latched;
    reg [width-1:0]          portbdataout_tmp;
    reg [width-1:0]          portbdataout_reg;
    reg [width-1:0]          portbdataout_reg_out;
    reg [width-1:0]          portbdataout_tmp2;

    // Initialize memory from file if specified
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end

    // Port A operations
    always @(posedge portaclk) begin
        portaclk_in <= 1'b1;
        portaena_in <= portaena;
        portawe_in <= portawe;
        portaaddr_in <= portaaddr;
        portadatain_in <= portadatain;
        
        if (portaena) begin
            if (portawe) begin
                // Write operation for port A
                dpram_content[portaaddr] <= portadatain;
                portawe_latched <= 1'b1;
                portaaddr_latched <= portaaddr;
            end else begin
                // Read operation for port A
                portawe_latched <= 1'b0;
                portaaddr_latched <= portaaddr;
                
                // Check for read-during-write on same port
                if (portawe_latched && (portaaddr_latched == portaaddr)) begin
                    portadataout_tmp <= portadatain_in;
                end else begin
                    // Normal read
                    portadataout_tmp <= dpram_content[portaaddr];
                end
            end
            
            // Register outputs if required
            if (output_mode == "REG") begin
                portadataout_reg <= portadataout_tmp;
                portadataout_reg_out <= portadataout_reg;
            end
        end
    end

    // Port B operations (only in DUAL_PORT mode)
    always @(posedge portbclk) begin
        if (operation_mode == "DUAL_PORT") begin
            portbclk_in <= 1'b1;
            portbena_in <= portbena;
            portbwe_in <= portbwe;
            portbaddr_in <= portbaddr;
            portbdatain_in <= portbdatain;
            
            if (portbena) begin
                if (portbwe) begin
                    // Write operation for port B
                    dpram_content[portbaddr] <= portbdatain;
                    portbwe_latched <= 1'b1;
                    portbaddr_latched <= portbaddr;
                    
                    // Check for simultaneous write to same address from both ports
                    if (portawe_in && (portaaddr_in == portbaddr) && portaena_in) begin
                        // Both ports writing to same address - mark as undefined
                        dpram_content[portbaddr] <= {width{1'bx}};
                    end
                end else begin
                    // Read operation for port B
                    portbwe_latched <= 1'b0;
                    portbaddr_latched <= portbaddr;
                    
                    // Check for read-during-write on same port
                    if (portbwe_latched && (portbaddr_latched == portbaddr)) begin
                        portbdataout_tmp <= portbdatain_in;
                    end 
                    // Check for read-during-write from other port
                    else if (portawe_in && (portaaddr_in == portbaddr) && portaena_in) begin
                        portbdataout_tmp <= {width{1'bx}}; // Port A writing to location Port B is reading
                    end else begin
                        // Normal read
                        portbdataout_tmp <= dpram_content[portbaddr];
                    end
                end
                
                // Register outputs if required
                if (output_mode == "REG") begin
                    portbdataout_reg <= portbdataout_tmp;
                    portbdataout_reg_out <= portbdataout_reg;
                end
            end
        end
    end

    // Output multiplexing based on output mode
    always @(*) begin
        if (output_mode == "REG") begin
            portadataout_tmp2 = portadataout_reg_out;
            portbdataout_tmp2 = portbdataout_reg_out;
        end else begin
            portadataout_tmp2 = portadataout_tmp;
            portbdataout_tmp2 = portbdataout_tmp;
        end
        
        portadataout = portadataout_tmp2;
        portbdataout = portbdataout_tmp2;
    end

endmodule
