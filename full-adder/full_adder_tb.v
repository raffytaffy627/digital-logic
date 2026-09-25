// Testbench for full_adder. Walks all 8 input combos and prints the result.
`timescale 1ns/1ps

module full_adder_tb;

    reg  a, b, cin;
    wire sum, cout;

    full_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    integer i;

    initial begin
        $display("a b cin | sum cout");
        $display("--------+---------");
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i[2:0];
            #10;
            $display("%b %b  %b  |  %b    %b", a, b, cin, sum, cout);
        end
        $finish;
    end

endmodule
