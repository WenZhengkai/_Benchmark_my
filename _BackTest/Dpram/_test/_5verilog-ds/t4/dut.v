module dut #(
    parameter WIDTH = 8,        // Data width
    parameter ADDR_WIDTH = 4,   // Address width
    parameter DEPTH = 16,       // Memory depth
    parameter OUTPUT_MODE = "UNREG" // Output mode: "REG" or "UNREG"
)(
    input wire portawe, portbwe,       // Write enable for Port A and Port B
    input wire portaena, portbena,     // Enable for Port A and Port B
    input wire portaclk, portbclk,    // Clock for Port A and Port B
    input wire [WIDTH-1:0] portadatain, portbdatain, // Data input for Port A and Port B
    input wire [ADDR_WIDTH-1:0] portaaddr, portbaddr, // Address input for Port A and Port B
    output reg [WIDTH-1:0] portadataout, portbdataout // Data output for Port A and Port B
);

    // Internal memory array
    reg [WIDTH-1:0] dpram_content [0:DEPTH-1];

    // Temporary signals for outputs
    reg [WIDTH-1:0] portadataout_tmp, portbdataout_tmp;

    // Registered output signals
    reg [WIDTH-1:0] portadataout_reg, portbdataout_reg;

    // Internal latched signals
    reg portawe_latched, portbwe_latched;
    reg [ADDR_WIDTH-1:0] portaaddr_latched, portbaddr_latched;

    // Clock edge detection for Port A
    always @(posedge portaclk) begin
        if (portaena) begin
            portawe_latched <= portawe;
            portaaddr_latched <= portaaddr;

            // Write operation for Port A
            if (portawe) begin
                if (portbwe && (portaaddr == portbaddr)) begin
                    // Conflict: both ports writing to the same address
                    dpram_content[portaaddr] <= 'bx;
                end else begin
                    dpram_content[portaaddr] <= portadatain;
                end
            end

            // Read operation for Port A
            if (!portawe) begin
                if (portbwe && (portaaddr == portbaddr)) begin
                    // Conflict: Port A reading while Port B is writing to the same address
                    portadataout_tmp <= 'bx;
                end else begin
                    portadataout_tmp <= dpram_content[portaaddr];
                end
            end
        end
    end

    // Clock edge detection for Port B
    always @(posedge portbclk) begin
        if (portbena) begin
            portbwe_latched <= portbwe;
            portbaddr_latched <= portbaddr;

            // Write operation for Port B
            if (portbwe) begin
                if (portawe && (portbaddr == portaaddr)) begin
                    // Conflict: both ports writing to the same address
                    dpram_content[portbaddr] <= 'bx;
                end else begin
                    dpram_content[portbaddr] <= portbdatain;
                end
            end

            // Read operation for Port B
            if (!portbwe) begin
                if (portawe && (portbaddr == portaaddr)) begin
                    // Conflict: Port B reading while Port A is writing to the same address
                    portbdataout_tmp <= 'bx;
                end else begin
                    portbdataout_tmp <= dpram_content[portbaddr];
                end
            end
        end
    end

    // Output mode handling
    generate
        if (OUTPUT_MODE == "REG") begin
            // Registered output mode
            always @(posedge portaclk) begin
                if (portaena) begin
                    portadataout_reg <= portadataout_tmp;
                end
            end

            always @(posedge portbclk) begin
                if (portbena) begin
                    portbdataout_reg <= portbdataout_tmp;
                end
            end

            assign portadataout = portadataout_reg;
            assign portbdataout = portbdataout_reg;
        end else begin
            // Unregistered output mode
            assign portadataout = portadataout_tmp;
            assign portbdataout = portbdataout_tmp;
        end
    endgenerate

endmodule
