library verilog;
use verilog.vl_types.all;
entity OutputBulkSerialDriver is
    port(
        Serck           : in     vl_logic;
        Serot           : out    vl_logic;
        Req             : out    vl_logic;
        Greq            : out    vl_logic;
        Blreq           : out    vl_logic;
        RedOt           : in     vl_logic_vector(3 downto 0);
        GreOt           : in     vl_logic_vector(3 downto 0);
        BluOt           : in     vl_logic_vector(3 downto 0)
    );
end OutputBulkSerialDriver;
