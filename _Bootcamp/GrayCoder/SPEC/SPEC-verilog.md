# Specification

## Module Name
GrayCoder

## Overview
The `GrayCoder` module is a digital circuit implemented using the hardware description language. It provides functionality to encode and decode binary numbers into their corresponding Gray code representations and vice versa, based on the input bit width. The module can perform both operations of encoding a binary number to Gray code and decoding a Gray code number back to binary, controlled by a boolean signal.


## Input/Output Interface
  input         clock,
  input         reset,
  input  [63:0] io_in,
  output [63:0] io_out,
  input         io_encode

## Internal Logic
- The module operates in two modes based on the `encode` input signal:
  - **Encoding Mode (`encode == true`):**
    - When the `encode` input is `true`, the module encodes the input binary number (io.in) into Gray code. The encoding is performed by taking the exclusive OR (XOR) of the input with itself right-shifted by one bit: `io.out := io.in ^ (io.in >> 1.U)`.
  
  - **Decoding Mode (`encode == false`):**
    - When the `encode` input is `false`, the module decodes the input Gray code number (io.in) back to a binary number. The decoding process is more complex than encoding and involves iterative XOR operations. It uses a sequential logic block that iterates over the number of bits determined by `log2Ceil(bitwidth)`, where for each iteration, it computes intermediate results using right shifts of the previous result: 
      - Initialize the first intermediate value with `io.in`.
      - For each subsequent iteration, generate the next intermediate value by XORing the previous value with its right shift by powers of two.
      - Finally, the output is obtained from the last computed value of these iterative operations.
  

