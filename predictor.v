module predictor (
    input  wire request,
    input  wire result,
    input  wire clk,
    input  wire taken,
    output reg  prediction
);

  parameter [1:0] STRONG_TAKEN = 3, WEAK_TAKEN = 2, WEAK_NOT_TAKEN = 1, STRONG_NOT_TAKEN = 0;
  reg [1:0] y = STRONG_TAKEN;

  always @(posedge clk) begin
    if (result) begin
      case ({
        taken, y[1:0]
      })
        {1'b1, 2'b11} : y <= STRONG_TAKEN;
        {1'b0, 2'b11} : y <= WEAK_TAKEN;
        {1'b1, 2'b10} : y <= STRONG_TAKEN;
        {1'b0, 2'b10} : y <= WEAK_NOT_TAKEN;
        {1'b1, 2'b01} : y <= WEAK_TAKEN;
        {1'b0, 2'b01} : y <= STRONG_NOT_TAKEN;
        {1'b1, 2'b00} : y <= WEAK_NOT_TAKEN;
        {1'b0, 2'b00} : y <= STRONG_NOT_TAKEN;
        default: y <= STRONG_TAKEN;
      endcase
    end
    if (request) begin
      prediction <= y[1];
    end
  end

endmodule
