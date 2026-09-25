#!/usr/bin/env bash
# Compiles and runs all three testbenches in one go instead of cd-ing into
# each folder and typing the iverilog/vvp commands by hand every time.
# Requires Icarus Verilog (iverilog/vvp) on PATH.
set -e

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_stage() {
    name="$1"; dir="$2"; shift 2
    echo "=== $name ==="
    (cd "$root/$dir" && iverilog -o sim "$@" && vvp sim && rm -f sim)
    echo
}

run_stage "Half Adder"  "half-adder"  half_adder.v half_adder_tb.v
run_stage "Full Adder"  "full-adder"  half_adder.v full_adder.v full_adder_tb.v
run_stage "4-Bit Adder" "4bit-adder"  half_adder.v full_adder.v adder_4bit.v adder_4bit_tb.v

echo "All stages ran. Check output above for any MISMATCH lines."
