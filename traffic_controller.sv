module traffic_controller(
    input clk,
    input reset,
    output reg [2:0] roadA,
    output reg [2:0] roadB
);

// Light encoding
parameter RED = 3'b100;
parameter YELLOW = 3'b010;
parameter GREEN = 3'b001;

// States
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state;
reg [3:0] timer;

// State + Timer Logic
always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= S0;
        timer <= 0;
    end else begin
        timer <= timer + 1;

        case(state)
            S0: if(timer == 5) begin state <= S1; timer <= 0; end
            S1: if(timer == 2) begin state <= S2; timer <= 0; end
            S2: if(timer == 5) begin state <= S3; timer <= 0; end
            S3: if(timer == 2) begin state <= S0; timer <= 0; end
        endcase
    end
end

// Output Logic
always @(*) begin
    case(state)
        S0: begin roadA = GREEN; roadB = RED; end
        S1: begin roadA = YELLOW; roadB = RED; end
        S2: begin roadA = RED; roadB = GREEN; end
        S3: begin roadA = RED; roadB = YELLOW; end
    endcase
end

endmodule
