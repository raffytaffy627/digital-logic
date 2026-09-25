# 4-Bit Ripple Carry Adder

Four full adders chained together: the carry-out of bit 0 feeds the carry-in
of bit 1, bit 1's carry-out feeds bit 2, and so on up to bit 3. That's the
"ripple" - the carry has to propagate through all 4 stages before you can
trust the final sum, which is also the main weakness of this design (see
below).

## Files

- `adder_4bit.v` - the 4-bit adder, instantiates `full_adder` x4
- `full_adder.v` / `half_adder.v` - copies of the earlier modules so this
  folder compiles standalone
- `adder_4bit_tb.v` - testbench with directed edge cases (overflow, max+max+carry)
  plus a randomized sweep, self-checked against `a + b + cin`

## Truth Table (partial)

A full 4-bit truth table has 512 rows (2^9 combinations of a, b, cin), so
here's a representative sample instead of the whole thing:

| a (dec) | b (dec) | cin | sum (dec) | cout |
|---------|---------|-----|-----------|------|
| 0       | 0       | 0   | 0         | 0    |
| 7       | 8       | 0   | 15        | 0    |
| 15      | 1       | 0   | 0         | 1    | ← overflow wraps around
| 15      | 15      | 1   | 15        | 1    | ← max + max + carry-in
| 5       | 3       | 1   | 9         | 0    |

The rule is just: `{cout, sum} = a + b + cin`, all in binary, where the
5-bit result (`cout` + 4-bit `sum`) can represent 0 to 30.

## Running the testbench

```bash
iverilog -o adder_4bit_sim half_adder.v full_adder.v adder_4bit.v adder_4bit_tb.v
vvp adder_4bit_sim
```

No Icarus? Paste all four files into [EDA Playground](https://www.edaplayground.com/)
with Icarus Verilog as the simulator.

## Why ripple carry is "slow"

Each full adder can't produce a valid output until it gets a valid carry-in
from the stage before it. For 4 bits that delay is small, but scale this up
to 32 or 64 bits and the worst-case carry path (a long chain of carries
rippling all the way through) becomes the critical path that limits your
clock speed. That's why real CPUs use carry-lookahead or carry-select
adders instead - they calculate carries in parallel rather than waiting for
them to ripple. Ripple carry is the simplest to understand and build, which
is exactly why it's the starting point here.
