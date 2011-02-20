library verilog;
use verilog.vl_types.all;
entity clkdivider is
    port(
        clk             : in     vl_logic;
        xclk            : out    vl_logic
    );
end clkdivider;
