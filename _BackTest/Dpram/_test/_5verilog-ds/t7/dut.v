module dut #(
    parameter WIDTH = 8,         // Data width
    parameter ADDR_WIDTH = 4,    // Address width
    parameter DEPTH = 16,        // Memory depth
    parameter OUTPUT_MODE = "REG" // Output mode: "REG" or "UNREG"
)(
    input wire portawe,          // Port A write enable
    input wire portbwe,          // Port B write enable
    input wire portaena,         // Port A enable
    input wire portbena,         // Port B enable
    input wire portaclk,         // Port A clock
    input wire portbclk,         // Port B clock
    input wire [WIDTH-1:0] portadatain, // Port A data input
    input wire [WIDTH-1:0] portbdatain, // Port B data input
    input wire [ADDR_WIDTH-1:0] portaaddr, // Port A address
    input wire [ADDR_WIDTH-1:0] portbaddr, // Port B address
    output reg [WIDTH-1:0] portadataout, // Port A data output
    output reg [WIDTH-1:0] portbdataout  // Port B data output
);

    // Internal memory array
    reg [WIDTH-1:0] dpram_content [0:DEPTH-1];

    // Internal signals for registered output mode
    reg [WIDTH-1:0] portadataout_reg, portbdataout_reg;

    // Port A operations
    always @(posedge portaclk) begin
        if (portaena) begin
            if (portawe) begin
                // Write operation for Port A
                dpram_content[portaaddr] <= portadatain;
            end else begin
                // Read operation for Port A
                portadataout_reg <= dpram_content[portaaddr];
            end
        end
    end

    // Port B operations
    always @(posedge portbclk) begin
        if (portbena) begin
            if (portbwe) begin
                // Write operation for Port B
                dpram_content[portbaddr] <= portbdatain;
            end else begin
                // Read operation for Port B
                portbdataout_reg <= dpram_content[portbaddr];
            end
        end
    end

    // Output mode handling
    generate
        if (OUTPUT_MODE == "REG") begin
            // Registered output mode
            always @(posedge portaclk) begin
                if (portaena) begin
                    portadataout <= portadataout_reg;
                end
            end

            always @(posedge portbclk) begin
                if (portbena) begin
                    portbdataout <= portbdataout_reg;
                end
            end
        end else begin
            // Unregistered output mode
            always @(*) begin
                if (portaena) begin
                    portadataout <= dpram_content[portaaddr];
                end
            end

            always @(*) begin
                if (portbena) begin
                    portbdataout <= dpram_content[portbaddr];
                end
            end
        end
    endgenerate

    // Handle simultaneous write conflicts
    always @(*) begin
        if (portawe && portbwe && (portaaddr == portbaddr)) begin
            dpram_content[portaaddr] <= 'hX; // Force unknown on conflict
        end
    end

endmodule
