library verilog;
use verilog.vl_types.all;
entity ReShynth is
    port(
        clk             : in     vl_logic;
        pclk            : in     vl_logic;
        HREF            : in     vl_logic;
        VSYNC           : in     vl_logic;
        Serck           : in     vl_logic;
        Serot           : out    vl_logic;
        pixdata         : in     vl_logic_vector(7 downto 0);
        xclk            : out    vl_logic;
        PixParaBus      : out    vl_logic_vector(11 downto 0);
        enasg           : out    vl_logic;
        TEST2           : out    vl_logic;
        TEST3           : out    vl_logic;
        nData           : out    vl_logic;
        NREFbg          : out    vl_logic;
        NVSYNCbg        : out    vl_logic
    );
end ReShynth;
