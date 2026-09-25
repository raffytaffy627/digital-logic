// Half adder: adds two single bits, no carry-in.
// Copied in here so this folder builds standalone (see ../half-adder for the original + its own testbench).
// sum = a XOR b, carry = a AND b
module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule
