`timescale 1ns / 1ps

module tb();

reg     sys_clk;
reg     sys_rst_n;

wire    ctrl_1;      
wire    ctrl_2;      

always #10 sys_clk = ~sys_clk;

initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    #200
    sys_rst_n = 1'b1;

end

my_design my_design_inst(
    .sys_clk  (sys_clk  ) ,    
    .sys_rst_n(sys_rst_n) ,   

    .ctrl_1	  (ctrl_1	  ) ,
	.ctrl_2   (ctrl_2)
);

endmodule
