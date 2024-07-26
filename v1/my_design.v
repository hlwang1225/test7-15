module my_design(
    input       sys_clk ,      //系统时钟 50MHz
    input       sys_rst_n ,    //系统复位，低电平有效
    
    output reg  ctrl_1,
	output reg  ctrl_2
);
//parameter
parameter CNT_MAX	= 11'd1563; //时钟计数
parameter CNT_N_MAX	= 10'd780 ; //可修改N值
parameter DEALY	= 6'd40	; //延时

reg [10:0] cnt;      
reg       inc_dec_flag; //inc_dec_flag为低递增,为高递减

//*****************************************************
//**                  main
//*****************************************************

//0:递增 1:递减
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
		inc_dec_flag <= 1'b0;
		cnt <= 0;
	end
	else begin
		case(inc_dec_flag)
			0://递增
			begin
				cnt <= cnt + 1'b1;
				if(cnt == (CNT_MAX - 11'b1))begin
					inc_dec_flag <= 1;
				end
			end
			1://递减
			begin
				cnt <= cnt - 1'b1;
				if(cnt == 1)begin
					inc_dec_flag <= 0;
				end
			end
		endcase
	end
end

//输出控制信号ctrl_1,大于CNT_N_MAX时输出高电平
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ctrl_1 <= 1'b0;
    else if(cnt >= CNT_N_MAX)
        ctrl_1 <= 1'b1;
    else
        ctrl_1 <= 1'b0;
end

//输出控制信号ctrl_2,大于CNT_N_MAX-DEALY时输出高电平
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ctrl_2 <= 1'b0;
    else if(cnt >= CNT_N_MAX-DEALY)
        ctrl_2 <= 1'b0;
    else
        ctrl_2 <= 1'b1;
end

endmodule