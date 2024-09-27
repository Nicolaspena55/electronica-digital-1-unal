module Mux_2x1_NBits #(
    parameter Bits = 2
)
(
    input [0:0] sel,
    input [(Bits - 1):0] in_0,
    input [(Bits - 1):0] in_1,
    output reg [(Bits - 1):0] out
);
    always @ (*) begin
        case (sel)
            1'h0: out = in_0;
            1'h1: out = in_1;
            default:
                out = 'h0;
        endcase
    end
endmodule

module comparator(input wire [7:0]a, input wire [7:0]b, output wire equal);
assign equal = a <= b;
endmodule

module PWM2 (
  input CLK,
  output PWM
);
  wire [7:0] s0;
  wire [7:0] s1;
  // counter
  counter counter_i0 (
    .LIMIT( 8'b101 ),
    .CLK( CLK ),
    .Q( s0 )
  );
  Mux_2x1_NBits #(
    .Bits(8)
  )
  Mux_2x1_NBits_i1 (
    .sel( 1'b0 ),
    .in_0( 8'b10 ),
    .in_1( 8'b10 ),
    .out( s1 )
  );
  // comparator
  comparator comparator_i2 (
    .a( s0 ),
    .b( s1 ),
    .equal( PWM )
  );
endmodule
