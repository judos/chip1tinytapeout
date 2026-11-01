# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Exhaustively test all combinations of the 6 used inputs
    for v in range(64):
        dut.ui_in.value = v
        await ClockCycles(dut.clk, 1)

        b = [(v >> i) & 1 for i in range(8)]
        expected = 0
        expected |= b[0] << 0                # identity
        expected |= (1 - b[1]) << 1          # invert
        expected |= (b[2] ^ b[3]) << 2       # half adder sum
        expected |= (b[2] & b[3]) << 3       # half adder carry
        expected |= 1 << (4 + (b[5] << 1 | b[4]))  # decoder

        got = int(dut.uo_out.value)
        assert got == expected, f"ui_in={v:08b}: uo_out={got:08b}, expected {expected:08b}"
