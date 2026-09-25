# Half Adder

The simplest building block of binary addition. Takes two 1-bit inputs and
spits out a sum bit and a carry bit. No carry-in, so it can't be chained on
its own for multi-bit addition (that's what the full adder is for).

## Files

- `half_adder.v` - the module
- `half_adder_tb.v` - testbench, sweeps all 4 input combos

## Truth Table

| a | b | sum | carry |
|---|---|-----|-------|
| 0 | 0 |  0  |   0   |
| 0 | 1 |  1  |   0   |
| 1 | 0 |  1  |   0   |
| 1 | 1 |  0  |   1   |

`sum = a XOR b`, `carry = a AND b`.

## Running the testbench

If you have Icarus Verilog installed:

```bash
iverilog -o half_adder_sim half_adder.v half_adder_tb.v
vvp half_adder_sim
```

If you don't have Icarus installed, paste both files into
[EDA Playground](https://www.edaplayground.com/) with Icarus Verilog selected
as the simulator and hit Run.
