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

    // Port declarations
    input                       portawe;
    input                       portbwe;
    input                       portaena;
    input                       portbena;
    input                       portaclk;
    input                       portbclk;
    input       [width-1:0]     portadatain;
    input       [width-1:0]     portbdatain;
    input       [addrwidth-1:0] portaaddr;
    input       [addrwidth-1:0] portbaddr;
    output      [width-1:0]     portadataout;
    output      [width-1:0]     portbdataout;

    // Internal signals
    reg         [width-1:0]     portadataout;
    reg         [width-1:0]     portbdataout;
    reg         [width-1:0]     dpram_content [depth-1:0];
    
    // Internal signals for edge detection and latching
    reg                         portaclk_in;
    reg                         portbclk_in;
    reg                         portaena_in;
    reg                         portbena_in;
    reg         [width-1:0]     portadatain_in;
    reg         [width-1:0]     portbdatain_in;
    reg         [addrwidth-1:0] portaaddr_in;
    reg         [addrwidth-1:0] portbaddr_in;
    
    // Latched signals for write operations
    reg                         portawe_latched;
    reg                         portbwe_latched;
    reg         [addrwidth-1:0] portaaddr_latched;
    reg         [addrwidth-1:0] portbaddr_latched;
    
    // Temporary and registered outputs
    reg         [width-1:0]     portadataout_tmp;
    reg         [width-1:0]     portbdataout_tmp;
    reg         [width-1:0]     portadataout_reg;
    reg         [width-1:0]     portbdataout_reg;
    reg         [width-1:0]     portadataout_reg_out;
    reg         [width-1:0]     portbdataout_reg_out;
    reg         [width-1:0]     portadataout_tmp2;
    reg         [width-1:0]     portbdataout_tmp2;
    
    // Memory initialization (optional - reads from file if specified)
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end
    
    // Input signal capture
    always @(portaclk or portaena or portawe or portaaddr or portadatain) begin
        portaclk_in = portaclk;
        portaena_in = portaena;
        portaaddr_in = portaaddr;
        portadatain_in = portadatain;
    end
    
    always @(portbclk or portbena or portbwe or portbaddr or portbdatain) begin
        portbclk_in = portbclk;
        portbena_in = portbena;
        portbaddr_in = portbaddr;
        portbdatain_in = portbdatain;
    end
    
    // Port A operations
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            if (portawe) begin
                // Write operation on Port A
                dpram_content[portaaddr_in] = portadatain_in;
                portawe_latched = 1'b1;
                portaaddr_latched = portaaddr_in;
            end else begin
                // Read operation on Port A
                portadataout_tmp = dpram_content[portaaddr_in];
                portawe_latched = 1'b0;
                portaaddr_latched = portaaddr_in;
            end
            
            // Handle registered output mode
            if (output_mode == "REG") begin
                portadataout_reg = portadataout_tmp;
            end
        end
    end
    
    // Port B operations
    always @(posedge portbclk_in) begin
        if (portbena_in) begin
            if (portbwe) begin
                // Write operation on Port B
                dpram_content[portbaddr_in] = portbdatain_in;
                portbwe_latched = 1'b1;
                portbaddr_latched = portbaddr_in;
            end else begin
                // Read operation on Port B
                portbdataout_tmp = dpram_content[portbaddr_in];
                portbwe_latched = 1'b0;
                portbaddr_latched = portbaddr_in;
            end
            
            // Handle registered output mode
            if (output_mode == "REG") begin
                portbdataout_reg = portbdataout_tmp;
            end
        end
    end
    
    // Registered output logic for Port A
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            portadataout_reg_out <= portadataout_reg;
        end
    end
    
    // Registered output logic for Port B
    always @(posedge portbclk_in) begin
        if (portbena_in) begin
            portbdataout_reg_out <= portbdataout_reg;
        end
    end
    
    // Output multiplexing based on output_mode
    always @(*) begin
        if (output_mode == "REG") begin
            portadataout_tmp2 = portadataout_reg_out;
            portbdataout_tmp2 = portbdataout_reg_out;
        end else begin
            portadataout_tmp2 = portadataout_tmp;
            portbdataout_tmp2 = portbdataout_tmp;
        end
        
        // Handle read-during-write conflicts
        if (portawe_latched && (portaaddr_latched == portbaddr_latched) && !portbwe_latched) begin
            portbdataout_tmp2 = {width{1'bx}}; // X on read-during-write conflict
        end
        
        if (portbwe_latched && (portbaddr_latched == portaaddr_latched) && !portawe_latched) begin
            portadataout_tmp2 = {width{1'bx}}; // X on read-during-write conflict
        end
        
        // Final output assignment
        portadataout = portadataout_tmp2;
        portbdataout = portbdataout_tmp2;
    end
    
    // Handle dual-port write collision
    always @(posedge portaclk_in or posedge portbclk_in) begin
        if (portawe && portbwe && (portaaddr == portbaddr) && portaena && portbena) begin
            // Write collision detected - mark memory location as 'X'
            dpram_content[portaaddr] = {width{1'bx}};
        end
    end
    
endmodule
