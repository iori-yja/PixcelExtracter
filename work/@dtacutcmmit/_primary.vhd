library verilog;
use verilog.vl_types.all;
entity Dtacutcmmit is
    port(
        SigEn           : in     vl_logic;
        pshdta          : in     vl_logic_vector(7 downto 0);
        WrCmplt         : out    vl_logic;
        popdta          : out    vl_logic_vector(11 downto 0)
    );
end Dtacutcmmit;
