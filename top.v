`include "./controlador_motor.v"
`include "./pwm.v"
module top
(
  input wire ts1,
  input wire ts2,
  input wire CLK1,
  output wire tm1,
  output wire tm2,
  output wire PWM1
   output wire pwm2
  
);
controlador_motor micontrolador_motor (
.s1 (ts1), 
.s2 (ts2),
.m1 (tm1),
.m2 (tm2)
);

pwm mipwm (
.CLK(CLK1),
.PWM(PWM1),

);
PWM2 mipwm (
.CLK(CLK2),
.PWM(PWM2),

);
endmodule
