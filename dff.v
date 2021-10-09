module dff (   input d,

               input clk,

               input reset,

               output reg q,

               output qn);

   always @ (negedge clk or negedge reset)

      if (!reset)

         q <= 0;

      else 

         q <= d;

 

   assign qn = ~q;

endmodule

 

module D_Sequential_Circuits ( input INPUT,

                input Reset,

                output A3,A2,A1,A0);

   wire  A0;

   wire  An0;

   wire  A1;

   wire  An1;

   wire  A2;

   wire  An2;

   wire  A3;

   wire  An3;

 

   dff   dff0 ( .d (An0),

                .clk (INPUT),

                .reset (Reset),

                .q (A0),

                .qn (An0));

 

   dff   dff1 ( .d (An1),

                .clk (A0),

                .reset (Reset),

                .q (A1),

                .qn (An1));

 

   dff   dff2 ( .d (An2),

                .clk (A1),

                .reset (Reset),

                .q (A2),

                .qn (An2));

 

   dff   dff3 ( .d (An3),

                .clk (A2),

                .reset (Reset),

                .q (A3),

                .qn (An3));

assign out = {A3, A2, A1, A0};

endmodule

 

module stimulus();

reg INPUT;

reg Reset;

wire A3,A2,A1,A0;

D_Sequential_Circuits D0(INPUT, Reset, A3,A2,A1,A0);

initial

$monitor($time, " Reset = %d, output = %d %d %d %d \n", Reset,A3,A2,A1,A0);

always #5 INPUT = ~INPUT;

initial

begin

                INPUT = 1'b1;

                Reset = 1'b0;

                #5 Reset = 1'b1;

                end

initial #320 $finish;

endmodule