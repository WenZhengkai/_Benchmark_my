module dut (
    portawe,
    portbwe,
    portaena,
    portbena,
    portaclk,
    portbclk,
    portadatain,
    portbdatain,
    portaaddr,
    portbaddr,
    portadataout,
    portbdataout
);

    parameter   operation_mode = "DUAL_PORT" ;
    parameter   addrwidth      = 14          ;
    parameter   width          = 32          ;
    parameter   depth          = 16384       ;
    parameter   ramblock       = 65535       ;
    parameter   output_mode    = "REG"       ;
    parameter   lpm_file       = "NONE"      ;
    parameter   lpm_type       = "alt_exc_dpram";
    parameter   lpm_hint       = "UNUSED"    ;

    input                       portawe;
    input                       portbwe;
    input                       portaena;
    input                       portbena;
    input                       portaclk;
    input                       portbclk;
    input      [width-1:0]      portadatain;
    input      [width-1:0]      portbdatain;
    input      [addrwidth-1:0]  portaaddr;
    input      [addrwidth-1:0]  portbaddr;
    output     [width-1:0]      portadataout;
    output     [width-1:0]      portbdataout;

    reg        [width-1:0]      dpram_content [depth-1:0];
    
    // Internal signals
    reg                         portaclk_in;
    reg                         portbclk_in;
    reg                         portaena_in;
    reg                         portbena_in;
    reg        [width-1:0]      portadatain_in;
    reg        [width-1:0]      portbdatain_in;
    reg        [addrwidth-1:0]  portaaddr_in;
    reg        [addrwidth-1:0]  portbaddr_in;
    
    reg                         portawe_latched;
    reg                         portbwe_latched;
    reg        [addrwidth-1:0]  portaaddr_latched;
    reg        [addrwidth-1:0]  portbaddr_latched;
    
    reg        [width-1:0]      portadataout_tmp;
    reg        [width-1:0]      portbdataout_tmp;
    reg        [width-1:0]      portadataout_reg;
    reg        [width-1:0]      portbdataout_reg;
    reg        [width-1:0]      portadataout_reg_out;
    reg        [width-1:0]      portbdataout_reg_out;
    reg        [width-1:0]      portadataout_tmp2;
    reg        [width-1:0]      portbdataout_tmp2;
    
    // Output assignments
    assign portadataout = portadataout_tmp2;
    assign portbdataout = portbdataout_tmp2;

    // Initialize memory if LPM file is specified
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
    
    // Port A operation
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            // Write operation for Port A
            if (portawe) begin
                dpram_content[portaaddr_in] <= portadatain_in;
                portadataout_tmp <= portadatain_in;  // Write-through behavior
            end
            else begin
                // Read operation for Port A
                portadataout_tmp <= dpram_content[portaaddr_in];
            end
            
            // Register outputs if required
            if (output_mode == "REG") begin
                portadataout_reg <= portadataout_tmp;
            end
            
            // Store latched values for conflict detection
            portawe_latched <= portawe;
            portaaddr_latched <= portaaddr_in;
        end
    end
    
    // Port B operation
    always @(posedge portbclk_in) begin
        if (portbena_in) begin
            // Write operation for Port B
            if (portbwe) begin
                dpram_content[portbaddr_in] <= portbdatain_in;
                portbdataout_tmp <= portbdatain_in;  // Write-through behavior
            end
            else begin
                // Read operation for Port B
                portbdataout_tmp <= dpram_content[portbaddr_in];
            end
            
            // Register outputs if required
            if (output_mode == "REG") begin
                portbdataout_reg <= portbdataout_tmp;
            end
            
            // Store latched values for conflict detection
            portbwe_latched <= portbwe;
            portbaddr_latched <= portbaddr_in;
        end
    end
    
    // Conflict handling
    always @(*) begin
        // Check for write/write conflicts (both ports writing to same address)
        if (portawe_latched && portbwe_latched && 
            (portaaddr_latched == portbaddr_latched)) begin
            dpram_content[portaaddr_latched] = {width{1'bx}}; // Set to unknown on conflict
        end
        
        // Handle registered outputs
        portadataout_reg_out = portadataout_reg;
        portbdataout_reg_out = portbdataout_reg;
        
        // Output selection based on output mode
        if (output_mode == "REG") begin
            portadataout_tmp2 = portadataout_reg_out;
            portbdataout_tmp2 = portbdataout_reg_out;
        end
        else begin
            portadataout_tmp2 = portadataout_tmp;
            portbdataout_tmp2 = portbdataout_tmp;
        end
        
        // Handle read-during-write conflicts
        if (portawe_latched && !portbwe_latched && 
            (portaaddr_latched == portbaddr_latched)) begin
            portbdataout_tmp2 = {width{1'bx}}; // Reading port gets unknown value
        end
        
        if (!portawe_latched && portbwe_latched && 
            (portaaddr_latched == portbaddr_latched)) begin
            portadataout_tmp2 = {width{1'bx}}; // Reading port gets unknown value
        end
    end

endmodule
