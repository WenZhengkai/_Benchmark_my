module dut (
    portaclk,     // Port A clock
    portawe,      // Port A write enable
    portaaddr,    // Port A address
    portadatain,  // Port A data input
    portadataout, // Port A data output
    portaena,     // Port A enable
    
    portbclk,     // Port B clock
    portbwe,      // Port B write enable
    portbaddr,    // Port B address
    portbdatain,  // Port B data input
    portbdataout, // Port B data output
    portbena      // Port B enable
);

    // Parameters
    parameter operation_mode = "DUAL_PORT";
    parameter addrwidth = 14;
    parameter width = 32;
    parameter depth = 16384;
    parameter ramblock = 65535;
    parameter output_mode = "REG";
    parameter lpm_file = "NONE";
    parameter lpm_type = "alt_exc_dpram";
    parameter lpm_hint = "UNUSED";
    
    // Port declarations
    input portaclk;
    input portawe;
    input [addrwidth-1:0] portaaddr;
    input [width-1:0] portadatain;
    output [width-1:0] portadataout;
    input portaena;
    
    input portbclk;
    input portbwe;
    input [addrwidth-1:0] portbaddr;
    input [width-1:0] portbdatain;
    output [width-1:0] portbdataout;
    input portbena;
    
    // Internal registers and wires
    reg [width-1:0] dpram_content [0:depth-1];
    
    reg portaclk_in;
    reg portbclk_in;
    reg portaena_in;
    reg portbena_in;
    reg [width-1:0] portadatain_in;
    reg [width-1:0] portbdatain_in;
    reg [addrwidth-1:0] portaaddr_in;
    reg [addrwidth-1:0] portbaddr_in;
    
    reg portawe_latched;
    reg portbwe_latched;
    reg [addrwidth-1:0] portaaddr_latched;
    reg [addrwidth-1:0] portbaddr_latched;
    
    reg [width-1:0] portadataout_tmp;
    reg [width-1:0] portbdataout_tmp;
    reg [width-1:0] portadataout_reg;
    reg [width-1:0] portbdataout_reg;
    reg [width-1:0] portadataout_reg_out;
    reg [width-1:0] portbdataout_reg_out;
    
    wire [width-1:0] portadataout_tmp2;
    wire [width-1:0] portbdataout_tmp2;
    
    // Memory initialization from file (if specified)
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
        // Initialize registers
        portawe_latched = 1'b0;
        portbwe_latched = 1'b0;
        portaaddr_latched = {addrwidth{1'b0}};
        portbaddr_latched = {addrwidth{1'b0}};
        portadataout_tmp = {width{1'b0}};
        portbdataout_tmp = {width{1'b0}};
        portadataout_reg = {width{1'b0}};
        portbdataout_reg = {width{1'b0}};
        portadataout_reg_out = {width{1'b0}};
        portbdataout_reg_out = {width{1'b0}};
    end
    
    // Input synchronization
    always @(posedge portaclk) begin
        portaclk_in <= portaclk;
        portaena_in <= portaena;
        portadatain_in <= portadatain;
        portaaddr_in <= portaaddr;
    end
    
    always @(posedge portbclk) begin
        portbclk_in <= portbclk;
        portbena_in <= portbena;
        portbdatain_in <= portbdatain;
        portbaddr_in <= portbaddr;
    end
    
    // Port A operation
    always @(posedge portaclk) begin
        if (portaena) begin
            if (portawe) begin
                // Write operation
                portawe_latched <= 1'b1;
                portaaddr_latched <= portaaddr;
                dpram_content[portaaddr] <= portadatain;
                
                // Check for conflict with Port B
                if (portbwe_latched && (portaaddr == portbaddr_latched)) begin
                    // Write conflict - force X
                    dpram_content[portaaddr] <= {width{1'bx}};
                end
            end else begin
                // Read operation
                portawe_latched <= 1'b0;
                portaaddr_latched <= portaaddr;
                
                // Check for conflict with Port B
                if (portbwe_latched && (portaaddr == portbaddr_latched)) begin
                    // Read during write conflict - output X
                    portadataout_tmp <= {width{1'bx}};
                end else begin
                    // Normal read
                    portadataout_tmp <= dpram_content[portaaddr];
                end
            end
            
            // Register output if required
            if (output_mode == "REG") begin
                portadataout_reg <= portadataout_tmp;
            end
        end
    end
    
    // Port B operation
    always @(posedge portbclk) begin
        if (portbena) begin
            if (portbwe) begin
                // Write operation
                portbwe_latched <= 1'b1;
                portbaddr_latched <= portbaddr;
                dpram_content[portbaddr] <= portbdatain;
                
                // Check for conflict with Port A
                if (portawe_latched && (portbaddr == portaaddr_latched)) begin
                    // Write conflict - force X
                    dpram_content[portbaddr] <= {width{1'bx}};
                end
            end else begin
                // Read operation
                portbwe_latched <= 1'b0;
                portbaddr_latched <= portbaddr;
                
                // Check for conflict with Port A
                if (portawe_latched && (portbaddr == portaaddr_latched)) begin
                    // Read during write conflict - output X
                    portbdataout_tmp <= {width{1'bx}};
                end else begin
                    // Normal read
                    portbdataout_tmp <= dpram_content[portbaddr];
                end
            end
            
            // Register output if required
            if (output_mode == "REG") begin
                portbdataout_reg <= portbdataout_tmp;
            end
        end
    end
    
    // Handle registered outputs
    always @(posedge portaclk) begin
        if (portaena) begin
            portadataout_reg_out <= portadataout_reg;
        end
    end
    
    always @(posedge portbclk) begin
        if (portbena) begin
            portbdataout_reg_out <= portbdataout_reg;
        end
    end
    
    // Output muxing based on output mode
    assign portadataout_tmp2 = (output_mode == "REG") ? portadataout_reg_out : portadataout_tmp;
    assign portbdataout_tmp2 = (output_mode == "REG") ? portbdataout_reg_out : portbdataout_tmp;
    
    // Final output assignments
    assign portadataout = portadataout_tmp2;
    assign portbdataout = portbdataout_tmp2;
    
endmodule
