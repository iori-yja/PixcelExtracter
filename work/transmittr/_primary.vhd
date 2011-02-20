library verilog;
use verilog.vl_types.all;
entity transmittr is
    port(
        Srialclk        : in     vl_logic;
        Wrtcmplt        : in     vl_logic;
        data            : in     vl_logic_vector(11 downto 0);
        SrialData       : out    vl_logic
    );
end transmittr;
