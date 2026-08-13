
---

# 3. Verilog design — `src/johnson_counter.v`

This is the actual Johnson Counter RTL.

```verilog
`timescale 1ns/1ps

module johnson_counter (
    input  wire       clk,
    input  wire       reset,
    output reg  [3:0] q
);

    always @(posedge clk) begin
        if (reset)
            q <= 4'b0000;
        else
            q <= {~q[0], q[3:1]};
    end

endmodule
q <= {~q[0], q[3:1]};
q = 0111
~q[0] = ~1 = 0
q[3:1] = 011
0011
0000 → 1000 → 1100 → 1110 → 1111
       ↓
0001 ← 0011 ← 0111
