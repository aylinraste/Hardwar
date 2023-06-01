module predictor (
    input  wire request,
    result,
    clk,
    taken,
    output reg  prediction
);

  reg [1:0] y;
  parameter [2:0] STRONG_TAKEN = 3, WEAK_TAKEN = 2, WEAK_NOT_TAKEN = 1, STRONG_NOT_TAKEN = 0;

  always @(posedge clk) begin
    if (result) begin
      case ({
        taken, y
      })
        (1, STRONG_TAKEN): y <= STRONG_TAKEN;
        (0, STRONG_TAKEN): y <= WEAK_TAKEN;
        (1, WEAK_TAKEN): y <= STRONG_TAKEN;
        (0, WEAK_TAKEN): y <= WEAK_NOT_TAKEN;
        (1, WEAK_NOT_TAKEN): y <= WEAK_TAKEN;
        (0, WEAK_NOT_TAKEN): y <= STRONG_NOT_TAKEN;
        (1, STRONG_NOT_TAKEN): y <= WEAK_NOT_TAKEN;
        (0, STRONG_NOT_TAKEN): y <= STRONG_NOT_TAKEN;
      endcase
    end
    if (request) begin
      prediction <= y[0];
    end
  end

endmodule
