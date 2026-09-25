# Compiles and runs all three testbenches in one go instead of cd-ing into
# each folder and typing the iverilog/vvp commands by hand every time.
# Requires Icarus Verilog (iverilog/vvp) on PATH.

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

function Run-Stage($name, $dir, $files) {
    Write-Host "=== $name ===" -ForegroundColor Cyan
    Push-Location (Join-Path $root $dir)
    try {
        iverilog -o sim @files
        vvp sim
        Remove-Item -Force sim -ErrorAction SilentlyContinue
    } finally {
        Pop-Location
    }
    Write-Host ""
}

Run-Stage "Half Adder"  "half-adder"  @("half_adder.v", "half_adder_tb.v")
Run-Stage "Full Adder"  "full-adder"  @("half_adder.v", "full_adder.v", "full_adder_tb.v")
Run-Stage "4-Bit Adder" "4bit-adder"  @("half_adder.v", "full_adder.v", "adder_4bit.v", "adder_4bit_tb.v")

Write-Host "All stages ran. Check output above for any MISMATCH lines." -ForegroundColor Green
