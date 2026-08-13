`timescale 1ns/1ps

module johnson_counter_tb;

    reg clk;
    reg reset;
    wire [3:0] q;

    // Instantiate the Johnson Counter
    johnson_counter uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin

        // Create waveform file
        $dumpfile("johnson_counter.vcd");
        $dumpvars(0, johnson_counter_tb);

        // Monitor signals
        $monitor("Time = %0t ns | Reset = %b | Q = %b",
                 $time, reset, q);

        // Apply reset
        reset = 1'b1;
        #10;

        // Release reset
        reset = 1'b0;

        // Wait for 8 clock cycles
        #80;

        $display("Simulation completed successfully.");
        $finish;
    end

    // Automatic verification
    initial begin

        #12;
        if (q !== 4'b1000)
            $display("ERROR: Expected 1000, Got %b", q);

        #10;
        if (q !== 4'b1100)
            $display("ERROR: Expected 1100, Got %b", q);

        #10;
        if (q !== 4'b1110)
            $display("ERROR: Expected 1110, Got %b", q);

        #10;
        if (q !== 4'b1111)
            $display("ERROR: Expected 1111, Got %b", q);

        #10;
        if (q !== 4'b0111)
            $display("ERROR: Expected 0111, Got %b", q);

        #10;
        if (q !== 4'b0011)
            $display("ERROR: Expected 0011, Got %b", q);

        #10;
        if (q !== 4'b0001)
            $display("ERROR: Expected 0001, Got %b", q);

        #10;
        if (q !== 4'b1000)
            $display("ERROR: Expected 1000, Got %b", q);

    end

endmodule
`timescale 1ns/1ps

module johnson_counter_tb;

    reg clk;
    reg reset;
    wire [3:0] q;

    reg [3:0] expected;
    integer i;

    johnson_counter uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test
    initial begin

        $dumpfile("johnson_counter.vcd");
        $dumpvars(0, johnson_counter_tb);

        $display("======================================");
        $display("      4-BIT JOHNSON COUNTER TEST");
        $display("======================================");

        // Reset
        reset = 1'b1;

        @(posedge clk);
        #1;

        if (q == 4'b0000)
            $display("RESET TEST: PASS  Q = %b", q);
        else
            $display("RESET TEST: FAIL  Q = %b", q);

        // Release reset
        reset = 1'b0;

        // Expected Johnson Counter sequence
        expected = 4'b1000;

        for (i = 0; i < 8; i = i + 1) begin

            @(posedge clk);
            #1;

            if (q == expected)
                $display("Cycle %0d: PASS  Q = %b", i + 1, q);
            else
                $display("Cycle %0d: FAIL  Expected = %b, Got = %b",
                         i + 1, expected, q);

            case (expected)
                4'b1000: expected = 4'b1100;
                4'b1100: expected = 4'b1110;
                4'b1110: expected = 4'b1111;
                4'b1111: expected = 4'b0111;
                4'b0111: expected = 4'b0011;
                4'b0011: expected = 4'b0001;
                4'b0001: expected = 4'b1000;
                default: expected = 4'b1000;
            endcase

        end

        $display("======================================");
        $display("       SIMULATION COMPLETED");
        $display("======================================");

        #10;
        $finish;

    end

endmodule
