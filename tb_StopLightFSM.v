`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nick Swanson
// 
// Create Date: 11/15/2023 08:52:02 PM
// Design Name: 
// Module Name: tb_StopLight
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_StopLight;
    reg ns_traffic, ew_traffic, sw_ne_traffic, wn_es_traffic, clk, rst;
    wire [2:0] ns_light, ew_light, sw_ne_light, wn_es_light;
  
    localparam [16:0] delay = 3;
    StopLight #(.delay(delay)) D00(.ns_traffic(ns_traffic), .ns_light(ns_light), .ew_traffic(ew_traffic), .ew_light(ew_light), .sw_ne_traffic(sw_ne_traffic), .sw_ne_light(sw_ne_light), .wn_es_traffic(wn_es_traffic), .wn_es_light(wn_es_light), .clk(clk), .rst(rst));
  
    always #5 clk = ~clk;
    
    initial begin
        ns_traffic = 0;
        ew_traffic = 0;
        sw_ne_traffic = 0;
        wn_es_traffic = 0;
        clk = 0;
        rst = 1;
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        ns_traffic = 1;
        #100
        ns_traffic = 0;
        ew_traffic = 1;
        #90
        ew_traffic =0;
        sw_ne_traffic = 1;
        #90
        sw_ne_traffic = 0;
        wn_es_traffic = 1;
        #90;
        $finish;
        end
endmodule
