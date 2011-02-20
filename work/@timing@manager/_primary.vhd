library verilog;
use verilog.vl_types.all;
entity TimingManager is
    port(
        VSYNC           : in     vl_logic;
        HREF            : in     vl_logic;
        pclk            : in     vl_logic;
        Sig_En          : out    vl_logic;
        enC             : out    vl_logic
    );
end TimingManager;
