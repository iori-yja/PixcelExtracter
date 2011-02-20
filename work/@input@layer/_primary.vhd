library verilog;
use verilog.vl_types.all;
entity InputLayer is
    port(
        VSYNC           : in     vl_logic;
        HREF            : in     vl_logic;
        pclk            : in     vl_logic;
        pshdta          : in     vl_logic_vector(7 downto 0);
        PixParaBus      : out    vl_logic_vector(11 downto 0);
        SigEn           : out    vl_logic;
        enC             : out    vl_logic;
        Wrtcmplt        : out    vl_logic
    );
end InputLayer;
