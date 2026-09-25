# digital-logic

Beginner Verilog project building up a 4-bit adder from scratch: half adder
-> full adder -> 4-bit ripple carry adder. Built while learning digital logic
as a Computer Engineering student.

## What an adder actually does

An adder takes two binary numbers and adds them, bit by bit, the same way
you'd add two numbers by hand in base 10 - except in binary you only have 0
and 1, and any time both bits are 1 you generate a "carry" that gets added
into the next column over. A half adder handles one column with no carry-in
(so it only works for the very first bit). A full adder handles one column
*with* a carry-in, which means you can chain a bunch of them together to add
numbers wider than 1 bit. Chain 4 full adders and you get a 4-bit adder that
can add numbers from 0-15 (plus a carry in/out for chaining into even wider
adders).

## Why this matters for CPU design

The ALU (arithmetic logic unit) in every CPU has adder circuits at its core
- addition, subtraction (which is usually just addition with an inverted
operand and a carry-in trick), and even multiplication (repeated shift-and-add)
all lean on adder hardware. Understanding ripple carry adders is the
"hello world" of computer architecture: it's the simplest correct way to
build an adder, and it sets up why faster designs (carry-lookahead,
carry-select, carry-save) exist - they're all just different tradeoffs
between speed, area, and power for the same basic job.

## Structure

- [`half-adder/`](half-adder/) - 1-bit adder, no carry-in
- [`full-adder/`](full-adder/) - 1-bit adder with carry-in, built from 2 half adders
- [`4bit-adder/`](4bit-adder/) - 4-bit ripple carry adder, built from 4 full adders

Each folder has its own `.v` module(s), a testbench, and a README with a
truth table and instructions for running it.

## Running the simulations

All testbenches were written for [Icarus Verilog](http://iverilog.icarus.com/).
If you have it installed:

```bash
cd half-adder
iverilog -o sim half_adder.v half_adder_tb.v
vvp sim
```

Same pattern for the other two folders (see each folder's README for the
exact file list). If you don't want to install anything, every file here
also runs fine on [EDA Playground](https://www.edaplayground.com/) - just
paste the module + testbench files in and pick Icarus Verilog as the
simulator.

## What I learned

- How binary addition actually maps to logic gates (XOR for sum, AND for
  carry) instead of just being an abstract "the computer does math" thing.
- How to build bigger modules out of smaller ones in Verilog (module
  instantiation, wiring internal signals between instances).
- Why ripple carry adders are simple but not what real CPUs use for wide
  additions - the carry has to propagate through every stage, which caps how
  fast you can clock a wide ripple carry adder.
- How to write a self-checking testbench (comparing DUT output against
  `a + b + cin` computed directly in the testbench itself) instead of just
  eyeballing printed values - much faster way to catch a wiring mistake than
  reading through a wall of `$display` output by hand.
