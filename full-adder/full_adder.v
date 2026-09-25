// Full adder: adds two bits plus a carry-in. Built from two half adders + an OR gate.
// sum = a XOR b XOR cin, carry_out = (a AND b) OR (cin AND (a XOR b))
module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

    wire sum1, carry1, carry2;

    // first half adder: adds a + b
    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(sum1),
        .carry(carry1)
    );

    // second half adder: adds that sum + cin
    half_adder ha2 (
        .a(sum1),
        .b(cin),
        .sum(sum),
        .carry(carry2)
    );

    // carry out if either half adder produced a carry
    assign cout = carry1 | carry2;

endmodule
