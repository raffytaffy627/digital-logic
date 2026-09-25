// Testbench for adder_4bit. Runs a handful of directed test cases plus a
// randomized sweep, and checks the result against plain addition in the
// testbench itself so it flags mismatches instead of just printing values.
`timescale 1ns/1ps

module adder_4bit_tb;

    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    integer errors;
    integer i;
    reg [4:0] expected;

    adder_4bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task check;
        begin
            #10;
            expected = a + b + cin;
            if ({cout, sum} !== expected) begin
                $display("MISMATCH: a=%d b=%d cin=%b -> got sum=%d cout=%b, expected %d",
                          a, b, cin, sum, cout, expected);
                errors = errors + 1;
            end else begin
                $display("OK: a=%d b=%d cin=%b -> sum=%d cout=%b", a, b, cin, sum, cout);
            end
        end
    endtask

    initial begin
        errors = 0;

        // a few directed cases, including carry-out and carry-in edge cases
        a = 4'd0;  b = 4'd0;  cin = 0; check;
        a = 4'd7;  b = 4'd8;  cin = 0; check;
        a = 4'd15; b = 4'd1;  cin = 0; check; // overflow -> cout = 1, sum wraps to 0
        a = 4'd15; b = 4'd15; cin = 1; check; // max + max + carry
        a = 4'd5;  b = 4'd3;  cin = 1; check;

        // randomized sweep
        for (i = 0; i < 20; i = i + 1) begin
            a   = $random;
            b   = $random;
            cin = $random;
            check;
        end

        if (errors == 0)
            $display("All tests passed.");
        else
            $display("%0d test(s) FAILED.", errors);

        $finish;
    end

endmodule
