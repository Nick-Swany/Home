`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SDSU CompE 470
// Engineer: Nick Swanson
// 
// Create Date: 11/15/2023 06:56:30 PM
// Design Name: 
// Module Name: StopLight
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

//This is a Moore machine. Output only depends on the current state.
//There are 8 states. Grenn and yellow at each of the four lights(pairs). All other lights are set to red.
//It is designed for only one car at a time in each lane.
module StopLight#(delay = 1) //number of clok cycle to deal till
                (input ns_traffic, ew_traffic, sw_ne_traffic, wn_es_traffic, clk, rst,
                output reg [2:0] ns_light, ew_light, sw_ne_light, wn_es_light);
    reg [3:0] state;
    localparam [3:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7, s8 = 8;
    //s0 = no traffic/s1==nsGreen/s2nsYellow/
    reg traffic;
    reg [16:0] counter;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= s0;
            counter <= 0;
            traffic <= 0;
        end
        else if (state == s0) begin
            if (traffic) begin
                if (ns_traffic) state <= s1;
                else if (ew_traffic) state <= s3;
                else if (sw_ne_traffic) state <= s5;
                else if (wn_es_traffic) state <= s7;
                else begin
                    traffic <= 0;
                    state <= s0;
                end
            end
            else state <= s0;
            counter <= 0;
        end    
        else if (state == s1) begin
            if (counter == delay) begin
                state <= s2;
                counter <= 0;
            end
            else counter <= counter + 1;
        end 
        else if (state == s2) begin
            if (counter == delay) begin
                if (ew_traffic) state <= s3;
                else if (sw_ne_traffic) state <= s5;
                else if (wn_es_traffic) state <= s7;
                else begin
                    traffic <= 0;
                    state <= s0;
                end
                counter <= 0;
            end
            else counter <= counter + 1;
        end
        else if (state == s3) begin
            if (counter == delay) begin
                state <= s4;
                counter <= 0;
            end
            else counter <= counter + 1;
        end 
        else if (state == s4) begin
            if (counter == delay) begin
                if (sw_ne_traffic) state <= s5;
                else if (wn_es_traffic) state <= s7;
                else begin
                    traffic <= 0;
                    state <= s0;
                end
                counter <= 0;
            end
            else counter <= counter + 1;
        end
        else if (state == s5) begin
            if (counter == delay) begin
                state <= s6;
                counter <= 0;
            end
            else counter <= counter + 1;
        end 
        else if (state == s6) begin
            if (counter == delay) begin
                if (wn_es_traffic) state <= s7;
                else begin
                    traffic <= 0;
                    state <= s0;
                end
                counter <= 0;
            end
            else counter <= counter + 1;
        end
        else if (state == s7) begin
            if (counter == delay) begin
                state <= s8;
                counter <= 0;
            end
            else counter <= counter + 1;
        end
        else if (state == s8) begin
            if (counter == delay) begin
                traffic <= 0;
                state <= s0;  
                counter <= 0;
            end
            else counter <= counter + 1;
        end
        else state <= 1'bx;
    end 
    
    always @(*) begin
        if (state == s0) begin
            ns_light = 3'b100;
            ew_light = 3'b100;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b100;
        end
        else if (state == s1) begin
            ns_light = 3'b001;
            ew_light = 3'b100;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b100;
        end
        else if (state == s2) begin
            ns_light = 3'b010;
            ew_light = 3'b100;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b100;
        end
        else if (state == s3) begin
            ns_light = 3'b100;
            ew_light = 3'b001;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b100;
        end
        else if (state == s4) begin
            ns_light = 3'b100;
            ew_light = 3'b010;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b100;
        end
        else if (state == s5) begin
            ns_light = 3'b100;
            ew_light = 3'b100;
            sw_ne_light = 3'b001;
            wn_es_light = 3'b100;
        end
        else if (state == s6) begin
            ns_light = 3'b100;
            ew_light = 3'b100;
            sw_ne_light = 3'b010;
            wn_es_light = 3'b100;
        end
        else if (state == s7) begin
            ns_light = 3'b100;
            ew_light = 3'b100;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b001;
        end
        else if (state == s8) begin
            ns_light = 3'b100;
            ew_light = 3'b100;
            sw_ne_light = 3'b100;
            wn_es_light = 3'b010;
        end
        else ns_light = 3'bxxx;
    end
    always @(ns_traffic or ew_traffic or sw_ne_traffic or wn_es_traffic) begin
        traffic = 1;
    end
endmodule

            
