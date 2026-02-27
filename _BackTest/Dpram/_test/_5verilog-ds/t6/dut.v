module dut #(
    parameter ADDR_WIDTH = 8,       // Address width
    parameter DATA_WIDTH = 16,      // Data width
    parameter DEPTH      = 256,     // Memory depth
    parameter OUTPUT_MODE = "UNREG" // Output mode: "REG" or "UNREG"
)(
    // Port A signals
    input  wire                     portawe,      // Port A write enable
    input  wire                     portaena,     // Port A enable
    input  wire                     portaclk,     // Port A clock
    input  wire [DATA_WIDTH-1:0]    portadatain,  // Port A data input
    input  wire [ADDR_WIDTH-1:0]    portaaddr,    // Port A address
    output reg  [DATA_WIDTH-1:0]    portadataout, // Port A data output

    // Port B signals
    input  wire                     portbwe,      // Port B write enable
    input  wire                     portbena,     // Port B enable
    input  wire                     portbclk,     // Port B clock
    input  wire [DATA_WIDTH-1:0]    portbdatain,  // Port B data input
    input  wire [ADDR_WIDTH-1:0]    portbaddr,    // Port B address
    output reg  [DATA_WIDTH-1:0]    portbdataout  // Port B data output
);

    // Internal memory array
    reg [DATA_WIDTH-1:0] dpram_content [0:DEPTH-1];

    // Internal signals for registered output mode
    reg [DATA_WIDTH-1:0] portadataout_reg, portbdataout_reg;

    // Port A logic
    always @(posedge portaclk) begin
        if (portaena) begin
            if (portawe) begin
                // Write operation for Port A
                dpram_content[portaaddr] <= portadatain;
            end else begin
                // Read operation for Port A
                if (portbwe && portaaddr == portbaddr) begin
                    // Conflict: Port B is writing to the same address
                    portadataout <= {DATA_WIDTH{1'bx}};
                end else begin
                    portadataout <= dpram_content[portaaddr];
                end
            end
        end
    end

    // Port B logic
    always @(posedge portbclk) begin
        if (portbena) begin
            if (portbwe) begin
                // Write operation for Port B
                dpram_content[portbaddr] <= portbdatain;
            end else begin
                // Read operation for Port B
                if (portawe && portbaddr == portaaddr) begin
                    // Conflict: Port A is writing to the same address
                    portbdataout <= {DATA_WIDTH{1'bx}};
                end else begin
                    portbdataout <= dpram_content[portbaddr];
                end
            end
        end
    end

    // Registered output mode logic
    generate
        if (OUTPUT_MODE == "REG") begin
            always @(posedge portaclk) begin
                if (portaena) begin
                    portadataout_reg <= portadataout;
                end
            end

            always @(posedge portbclk) begin
                if (portbena) begin
                    portbdataout_reg <= portbdataout;
                end
            end

            assign portadataout = portadataout_reg;
            assign portbdataout = portbdataout_reg;
        end
    endgenerate

endmodule
