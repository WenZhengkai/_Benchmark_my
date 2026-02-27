module dut #(
    parameter WIDTH = 8,          // Data width
    parameter ADDR_WIDTH = 4,     // Address width
    parameter DEPTH = 16,         // Memory depth (2^ADDR_WIDTH)
    parameter OUTPUT_MODE = "REG" // Output mode: "REG" or "UNREG"
)(
    input wire portawe,           // Port A write enable
    input wire portbwe,           // Port B write enable
    input wire portaena,          // Port A enable
    input wire portbena,          // Port B enable
    input wire portaclk,          // Port A clock
    input wire portbclk,          // Port B clock
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

    // Port A operation
    always @(posedge portaclk) begin
        if (portaena) begin
            if (portawe) begin
                // Write operation
                dpram_content[portaaddr] <= portadatain;
            end else begin
                // Read operation
                if (OUTPUT_MODE == "REG")
                    portadataout_reg <= dpram_content[portaaddr];
                else
                    portadataout <= dpram_content[portaaddr];
            end
        end
    end

    // Port B operation
    always @(posedge portbclk) begin
        if (portbena) begin
            if (portbwe) begin
                // Write operation
                dpram_content[portbaddr] <= portbdatain;
            end else begin
                // Read operation
                if (OUTPUT_MODE == "REG")
                    portbdataout_reg <= dpram_content[portbaddr];
                else
                    portbdataout <= dpram_content[portbaddr];
            end
        end
    end

    // Registered output mode handling
    generate
        if (OUTPUT_MODE == "REG") begin
            always @(posedge portaclk) begin
                portadataout <= portadataout_reg;
            end
            always @(posedge portbclk) begin
                portbdataout <= portbdataout_reg;
            end
        end
    endgenerate

    // Handle simultaneous read/write conflicts
    always @(*) begin
        if (portaena && portbena && portaaddr == portbaddr) begin
            if (portawe && portbwe) begin
                // Both ports writing to the same address
                dpram_content[portaaddr] <= 'hX; // Force unknown
            end else if (portawe || portbwe) begin
                // One port writing, the other reading
                if (OUTPUT_MODE == "UNREG") begin
                    if (portawe) portbdataout <= 'hX;
                    if (portbwe) portadataout <= 'hX;
                end
            end
        end
    end

endmodule
