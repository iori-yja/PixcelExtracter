library verilog;
use verilog.vl_types.all;
entity InputsideQueueArray is
    port(
        pshdta          : in     vl_logic_vector(11 downto 0);
        Wrtcmplt        : in     vl_logic;
        Req             : in     vl_logic;
        Greq            : in     vl_logic;
        Blreq           : in     vl_logic;
        RedOt           : out    vl_logic_vector(3 downto 0);
        GreOt           : out    vl_logic_vector(3 downto 0);
        BluOt           : out    vl_logic_vector(3 downto 0);
        Remp            : out    vl_logic;
        Gemp            : out    vl_logic;
        Bemp            : out    vl_logic
    );
end InputsideQueueArray;
