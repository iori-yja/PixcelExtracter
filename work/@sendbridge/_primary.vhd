library verilog;
use verilog.vl_types.all;
entity Sendbridge is
    port(
        clk             : in     vl_logic;
        pclk            : in     vl_logic;
        Pushin          : in     vl_logic_vector(15 downto 0);
        Req             : in     vl_logic;
        SIO             : in     vl_logic
    );
end Sendbridge;
