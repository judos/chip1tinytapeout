<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This is a simple processor versatile for any application

## How to test

Current test circuit (only dedicated pins, no clock needed):

| Function | Inputs | Outputs |
|---|---|---|
| Identity | ui[0] | uo[0] = ui[0] |
| Inverter | ui[1] | uo[1] = not ui[1] |
| Half adder | ui[2], ui[3] | uo[2] = sum (xor), uo[3] = carry (and) |
| 2-to-4 decoder | ui[4] (low), ui[5] (high) | exactly one of uo[4..7] is 1, selected by the 2-bit number |

Example: ui[5]=1, ui[4]=0 selects 2, so uo[6] is 1 and uo[4], uo[5], uo[7] are 0.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
TODO: add doc
