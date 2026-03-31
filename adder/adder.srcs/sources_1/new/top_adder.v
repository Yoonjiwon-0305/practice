`timescale 1ns / 1ps

module top_adder ();

endmodule

module adder (
    input  [7:0] a,
    input  [7:0] b,
    input        cin,
    output [7:0] sum,
    output       c
);

    wire w_cin;

    full_adder_4bit U_FA4_0 (
        .a0   (a[0]),
        .a1   (a[1]),
        .a2   (a[2]),
        .a3   (a[3]),
        .b0   (b[0]),
        .b1   (b[1]),
        .b2   (b[2]),
        .b3   (b[3]),
        .cin  (cin),
        .sum_0(sum[0]),
        .sum_1(sum[1]),
        .sum_2(sum[2]),
        .sum_3(sum[3]),
        .carry(w_cin)

    );

    full_adder_4bit U_FA4_1 (
        .a0   (a[4]),
        .a1   (a[5]),
        .a2   (a[6]),
        .a3   (a[7]),
        .b0   (b[4]),
        .b1   (b[5]),
        .b2   (b[6]),
        .b3   (b[7]),
        .cin  (w_cin),
        .sum_0(sum[4]),
        .sum_1(sum[5]),
        .sum_2(sum[6]),
        .sum_3(sum[7]),
        .carry(c)

    );



endmodule

module full_adder_4bit (
    input  a0,
    input  a1,
    input  a2,
    input  a3,
    input  b0,
    input  b1,
    input  b2,
    input  b3,
    input  cin,
    output sum_0,
    output sum_1,
    output sum_2,
    output sum_3,
    output carry

);

    wire w_c_0, w_c_1, w_c_2;

    full_adder U_FA_0 (
        .a    (a0),
        .b    (b0),
        .cin  (cin),
        .sum  (sum_0),
        .carry(w_c_0)
    );

    full_adder U_FA_1 (
        .a    (a1),
        .b    (b1),
        .cin  (w_c_0),
        .sum  (sum_1),
        .carry(w_c_1)
    );

    full_adder U_FA_2 (
        .a    (a2),
        .b    (b2),
        .cin  (w_c_1),
        .sum  (sum_2),
        .carry(w_c_2)
    );

    full_adder U_FA_3 (
        .a    (a3),
        .b    (b3),
        .cin  (w_c_2),
        .sum  (sum_3),
        .carry(carry)
    );

endmodule

module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output carry
);
    wire w_ha_sum, w_ha_1, w_ha_0;
    assign carry = w_ha_0 | w_ha_1;

    half_adder U_HA_0 (
        .a    (a),
        .b    (b),
        .sum  (w_ha_sum),
        .carry(w_ha_0)
    );

    half_adder U_HA_1 (
        .a    (w_ha_sum),
        .b    (cin),
        .sum  (sum),
        .carry(w_ha_1)
    );
endmodule


module half_adder (
    input  wire a,
    input  wire b,
    output      sum,
    output      carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule
