module dut (
    portawe, portbwe, portaena, portbena,
    portaclk, portbclk,
    portadatain, portbdatain,
    portaaddr, portbaddr,
    portadataout, portbdataout
);

    // Parameters
    parameter   operation_mode = "DUAL_PORT" ;
    parameter   addrwidth      = 14          ;
    parameter   width          = 32          ;
    parameter   depth          = 16384       ;
    parameter   ramblock       = 65535       ;
    parameter   output_mode    = "REG"       ;
    parameter   lpm_file       = "NONE"      ;
    parameter   lpm_type       = "alt_exc_dpram";
    parameter   lpm_hint       = "UNUSED"    ;

    // Port declarations
    input                     portawe, portbwe;
    input                     portaena, portbena;
    input                     portaclk, portbclk;
    input      [width-1:0]    portadatain, portbdatain;
    input      [addrwidth-1:0] portaaddr, portbaddr;
    output     [width-1:0]    portadataout, portbdataout;

    // Internal variables
    reg        [width-1:0]    dpram_content [depth-1:0];
    
    reg                       portaclk_in, portbclk_in;
    reg                       portaena_in, portbena_in;
    reg        [width-1:0]    portadatain_in, portbdatain_in;
    reg        [addrwidth-1:0] portaaddr_in, portbaddr_in;
    
    reg                       portawe_latched, portbwe_latched;
    reg        [addrwidth-1:0] portaaddr_latched, portbaddr_latched;
    
    reg        [width-1:0]    portadataout_tmp, portbdataout_tmp;
    reg        [width-1:0]    portadataout_reg, portbdataout_reg;
    reg        [width-1:0]    portadataout_reg_out, portbdataout_reg_out;
    reg        [width-1:0]    portadataout_tmp2, portbdataout_tmp2;
    
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
    always @(portaclk or portaena or portawe or portadatain or portaaddr) begin
        portaclk_in = portaclk;
        portaena_in = portaena;
        portadatain_in = portadatain;
        portaaddr_in = portaaddr;
    end

    always @(portbclk or portbena or portbwe or portbdatain or portbaddr) begin
        portbclk_in = portbclk;
        portbena_in = portbena;
        portbdatain_in = portbdatain;
        portbaddr_in = portbaddr;
    end

    // Port A operations
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            if (portawe) begin
                // Write operation on Port A
                dpram_content[portaaddr_in] = portadatain_in;
                portadataout_tmp = portadatain_in;
                portawe_latched = 1'b1;
                portaaddr_latched = portaaddr_in;
            end else begin
                // Read operation on Port A
                portadataout_tmp = dpram_content[portaaddr_in];
                portawe_latched = 1'b0;
                portaaddr_latched = portaaddr_in;
            end
            
            // Register output if configured
            if (output_mode == "REG") begin
                portadataout_reg = portadataout_tmp;
            end
        end
    end

    // Port B operations (in dual port mode)
    always @(posedge portbclk_in) begin
        if (operation_mode == "DUAL_PORT" && portbena_in) begin
            if (portbwe) begin
                // Write operation on Port B
                dpram_content[portbaddr_in] = portbdatain_in;
                portbdataout_tmp = portbdatain_in;
                portbwe_latched = 1'b1;
                portbaddr_latched = portbaddr_in;
            end else begin
                // Read operation on Port B
                portbdataout_tmp = dpram_content[portbaddr_in];
                portbwe_latched = 1'b0;
                portbaddr_latched = portbaddr_in;
            end
            
            // Register output if configured
            if (output_mode == "REG") begin
                portbdataout_reg = portbdataout_tmp;
            end
        end
    end

    // Conflict detection
    always @(portaaddr_in or portbaddr_in or portawe or portbwe) begin
        // Check for address conflict in dual port mode
        if (operation_mode == "DUAL_PORT" &&
            portaaddr_in == portbaddr_in &&
            portawe && portbwe) begin
            // Write-write conflict
            dpram_content[portaaddr_in] = {width{1'bx}};
        end
        
        // Check for read-during-write conflicts
        if (operation_mode == "DUAL_PORT") begin
            if (portawe && !portbwe && portaaddr_in == portbaddr_in) begin
                // Port A writes, Port B reads
                portbdataout_tmp = {width{1'bx}};
            end
            if (!portawe && portbwe && portaaddr_in == portbaddr_in) begin
                // Port B writes, Port A reads
                portadataout_tmp = {width{1'bx}};
            end
        end
    end

    // Output mode logic
    always @(*) begin
        // Port A output
        if (output_mode == "REG") begin
            portadataout_reg_out = portadataout_reg;
            portadataout_tmp2 = portadataout_reg_out;
        end else begin
            portadataout_tmp2 = portadataout_tmp;
        end
        
        // Port B output (in dual port mode)
        if (operation_mode == "DUAL_PORT") begin
            if (output_mode == "REG") begin
                portbdataout_reg_out = portbdataout_reg;
                portbdataout_tmp2 = portbdataout_reg_out;
            end else begin
                portbdataout_tmp2 = portbdataout_tmp;
            end
        end else begin
            // In single port mode, Port B output is undefined
            portbdataout_tmp2 = {width{1'bx}};
        end
    end

endmodule
