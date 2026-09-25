# Full Adder

Takes the half adder and adds a carry-in, so now it can actually be chained
with other full adders to build multi-bit adders. This is the piece that
makes the whole ripple-carry thing possible.

Built out of two half adders and an OR gate: first half adder adds `a + b`,
second one adds that result to `cin`, and the two carry-out bits get OR'd
together to make the final carry-out.

## Files

- `full_adder.v` - the module (instantiates `half_adder` twice)
- `half_adder.v` - copy of the half adder module so this folder compiles on its own
- `full_adder_tb.v` - testbench, sweeps all 8 input combos

## Truth Table

| a | b | cin | sum | cout |
|---|---|-----|-----|------|
| 0 | 0 |  0  |  0  |  0   |
| 0 | 0 |  1  |  1  |  0   |
| 0 | 1 |  0  |  1  |  0   |
| 0 | 1 |  1  |  0  |  1   |
| 1 | 0 |  0  |  1  |  0   |
| 1 | 0 |  1  |  0  |  1   |
| 1 | 1 |  0  |  0  |  1   |
| 1 | 1 |  1  |  1  |  1   |

## Running the testbench

```bash
iverilog -o full_adder_sim half_adder.v full_adder.v full_adder_tb.v
vvp full_adder_sim
```

No Icarus? Drop all three files into [EDA Playground](https://www.edaplayground.com/)
with Icarus Verilog as the simulator and run it there instead.
