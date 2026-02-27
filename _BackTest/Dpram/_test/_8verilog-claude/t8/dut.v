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
    input      [width-1:0]      portadatain;
    input      [width-1:0]      portbdatain;
    input      [addrwidth-1:0]  portaaddr;
    input      [addrwidth-1:0]  portbaddr;
    output     [width-1:0]      portadataout;
    output     [width-1:0]      portbdataout;

    // Internal registers and wires
    reg        [width-1:0]      dpram_content [depth-1:0];
    
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

    // Initialize memory from file if specified
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end

    // Sample inputs on every cycle
    always @(portaclk or portaena or portawe or portaaddr or portadatain) begin
        portaclk_in = portaclk;
        portaena_in = portaena;
        portadatain_in = portadatain;
        portaaddr_in = portaaddr;
    end

    always @(portbclk or portbena or portbwe or portbaddr or portbdatain) begin
        portbclk_in = portbclk;
        portbena_in = portbena;
        portbdatain_in = portbdatain;
        portbaddr_in = portbaddr;
    end

    // Port A operations
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            if (portawe) begin
                // Write operation for port A
                dpram_content[portaaddr_in] <= portadatain_in;
                portadataout_tmp <= portadatain_in;
                
                // Check for write-write conflict
                if (portbwe_latched && (portaaddr_in == portbaddr_latched)) begin
                    dpram_content[portaaddr_in] <= 'bx; // Undefined behavior on conflict
                end
            end
            else begin
                // Read operation for port A
                portadataout_tmp <= dpram_content[portaaddr_in];
                
                // Check for read-write conflict
                if (portbwe_latched && (portaaddr_in == portbaddr_latched)) begin
                    portadataout_tmp <= 'bx; // Undefined behavior on conflict
                end
            end
            
            // Update latched signals
            portawe_latched <= portawe;
            portaaddr_latched <= portaaddr_in;
            
            // Register outputs if in REG mode
            if (output_mode == "REG") begin
                portadataout_reg <= portadataout_tmp;
            end
        end
    end

    // Port B operations
    always @(posedge portbclk_in) begin
        if (portbena_in) begin
            if (portbwe) begin
                // Write operation for port B
                dpram_content[portbaddr_in] <= portbdatain_in;
                portbdataout_tmp <= portbdatain_in;
                
                // Check for write-write conflict
                if (portawe_latched && (portbaddr_in == portaaddr_latched)) begin
                    dpram_content[portbaddr_in] <= 'bx; // Undefined behavior on conflict
                end
            end
            else begin
                // Read operation for port B
                portbdataout_tmp <= dpram_content[portbaddr_in];
                
                // Check for read-write conflict
                if (portawe_latched && (portbaddr_in == portaaddr_latched)) begin
                    portbdataout_tmp <= 'bx; // Undefined behavior on conflict
                end
            end
            
            // Update latched signals
            portbwe_latched <= portbwe;
            portbaddr_latched <= portbaddr_in;
            
            // Register outputs if in REG mode
            if (output_mode == "REG") begin
                portbdataout_reg <= portbdataout_tmp;
            end
        end
    end

    // Handle registered outputs
    always @(portadataout_tmp or portadataout_reg or portaena_in) begin
        if (output_mode == "REG") begin
            portadataout_reg_out = portadataout_reg;
        end
        else begin
            portadataout_reg_out = portadataout_tmp;
        end
    end

    always @(portbdataout_tmp or portbdataout_reg or portbena_in) begin
        if (output_mode == "REG") begin
            portbdataout_reg_out = portbdataout_reg;
        end
        else begin
            portbdataout_reg_out = portbdataout_tmp;
        end
    end

    // Final output selection
    always @(portadataout_reg_out or portadataout_tmp or portaena_in) begin
        if (portaena_in) begin
            portadataout_tmp2 = portadataout_reg_out;
        end
        else begin
            portadataout_tmp2 = 'bx; // Output is undefined when port is disabled
        end
    end

    always @(portbdataout_reg_out or portbdataout_tmp or portbena_in) begin
        if (portbena_in) begin
            portbdataout_tmp2 = portbdataout_reg_out;
        end
        else begin
            portbdataout_tmp2 = 'bx; // Output is undefined when port is disabled
        end
    end

endmodule
