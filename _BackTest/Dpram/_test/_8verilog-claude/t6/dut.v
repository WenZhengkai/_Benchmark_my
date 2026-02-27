module dut #(
    parameter operation_mode = "DUAL_PORT",
    parameter addrwidth      = 14,
    parameter width          = 32,
    parameter depth          = 16384,
    parameter ramblock       = 65535,
    parameter output_mode    = "REG",
    parameter lpm_file       = "NONE",
    parameter lpm_type       = "alt_exc_dpram",
    parameter lpm_hint       = "UNUSED"
)(
    input wire                    portawe,      // Port A write enable
    input wire                    portaena,     // Port A enable
    input wire                    portaclk,     // Port A clock
    input wire [width-1:0]        portadatain,  // Port A data input
    input wire [addrwidth-1:0]    portaaddr,    // Port A address
    output reg [width-1:0]        portadataout, // Port A data output
    
    input wire                    portbwe,      // Port B write enable
    input wire                    portbena,     // Port B enable
    input wire                    portbclk,     // Port B clock
    input wire [width-1:0]        portbdatain,  // Port B data input
    input wire [addrwidth-1:0]    portbaddr,    // Port B address
    output reg [width-1:0]        portbdataout  // Port B data output
);

    // Memory array
    reg [width-1:0] dpram_content [0:depth-1];

    // Internal signals
    reg                    portaclk_in;
    reg                    portbclk_in;
    reg                    portaena_in;
    reg                    portbena_in;
    reg [width-1:0]        portadatain_in;
    reg [width-1:0]        portbdatain_in;
    reg [addrwidth-1:0]    portaaddr_in;
    reg [addrwidth-1:0]    portbaddr_in;
    
    reg                    portawe_latched;
    reg                    portbwe_latched;
    reg [addrwidth-1:0]    portaaddr_latched;
    reg [addrwidth-1:0]    portbaddr_latched;
    
    reg [width-1:0]        portadataout_tmp;
    reg [width-1:0]        portbdataout_tmp;
    reg [width-1:0]        portadataout_reg;
    reg [width-1:0]        portbdataout_reg;
    reg [width-1:0]        portadataout_reg_out;
    reg [width-1:0]        portbdataout_reg_out;
    reg [width-1:0]        portadataout_tmp2;
    reg [width-1:0]        portbdataout_tmp2;

    // Initialize memory if a file is provided
    initial begin
        if (lpm_file != "NONE") begin
            $readmemh(lpm_file, dpram_content);
        end
    end
    
    // Sample input signals
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

    // Port A memory operations
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            if (portawe) begin
                // Write operation on Port A
                dpram_content[portaaddr_in] <= portadatain_in;
                portawe_latched <= 1'b1;
                portaaddr_latched <= portaaddr_in;
            end else begin
                // Read operation on Port A
                portawe_latched <= 1'b0;
                portaaddr_latched <= portaaddr_in;
                portadataout_tmp <= dpram_content[portaaddr_in];
            end
        end
    end

    // Port B memory operations (only in DUAL_PORT mode)
    generate
        if (operation_mode == "DUAL_PORT") begin
            always @(posedge portbclk_in) begin
                if (portbena_in) begin
                    if (portbwe) begin
                        // Write operation on Port B
                        dpram_content[portbaddr_in] <= portbdatain_in;
                        portbwe_latched <= 1'b1;
                        portbaddr_latched <= portbaddr_in;
                    end else begin
                        // Read operation on Port B
                        portbwe_latched <= 1'b0;
                        portbaddr_latched <= portbaddr_in;
                        portbdataout_tmp <= dpram_content[portbaddr_in];
                    end
                end
            end
        end
    endgenerate

    // Handle read-during-write conflicts
    always @(*) begin
        // Check for Port A read during Port B write to same address
        if ((operation_mode == "DUAL_PORT") && !portawe_latched && portbwe_latched && 
            (portaaddr_latched == portbaddr_latched)) begin
            portadataout_tmp2 = {width{1'bx}}; // Undefined behavior
        end else begin
            portadataout_tmp2 = portadataout_tmp;
        end
        
        // Check for Port B read during Port A write to same address
        if ((operation_mode == "DUAL_PORT") && !portbwe_latched && portawe_latched && 
            (portbaddr_latched == portaaddr_latched)) begin
            portbdataout_tmp2 = {width{1'bx}}; // Undefined behavior
        end else begin
            portbdataout_tmp2 = portbdataout_tmp;
        end
    end

    // Output registers for Port A
    always @(posedge portaclk_in) begin
        if (portaena_in) begin
            portadataout_reg <= portadataout_tmp2;
        end
    end

    // Output registers for Port B
    generate
        if (operation_mode == "DUAL_PORT") begin
            always @(posedge portbclk_in) begin
                if (portbena_in) begin
                    portbdataout_reg <= portbdataout_tmp2;
                end
            end
        end
    endgenerate

    // Output mode selection
    always @(*) begin
        if (output_mode == "REG") begin
            portadataout_reg_out = portadataout_reg;
            portbdataout_reg_out = portbdataout_reg;
        end else begin
            portadataout_reg_out = portadataout_tmp2;
            portbdataout_reg_out = portbdataout_tmp2;
        end
    end

    // Final output assignment
    always @(*) begin
        portadataout = portadataout_reg_out;
        portbdataout = portbdataout_reg_out;
    end

endmodule
