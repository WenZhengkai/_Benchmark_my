# Specification
## Module Name

DCCreditSender

## Overview

The `DCCreditSender` module is a credit-based flow control sender. This module is intended to manage the flow control in digital communication systems, environment-insensitive to variable latency delays. It accepts input data through an enqueue interface and sends output data through a dequeue interface with the use of credit-based flow control. The credit mechanism helps ensure that the data exchange between different modules remains synchronized and prevents data overflow or underflow conditions.


## Input/Output Interface
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  output       io_deq_valid,
  input        io_deq_credit,
  output [7:0] io_deq_bits,
  output [2:0] io_curCredit
## Internal Logic

- **Credit Register (icredit):** Internally maintains the latched status of the dequeue credit signal. This helps in decision-making when the module determines whether to credit or debit its credit count.

- **Credit Counter (curCredit):** A register initialized to the `maxCredit` value that keeps track of the currently available credits. Its value is incremented when a credit is received (icredit high, enq.fire is low), and decremented when the enqueued data is sent (icredit low, enq.fire is high).

- **Ready Signal (`io.enq.ready`):** A readiness indication flag for the enqueue interface, toggling high when `curCredit` is greater than zero, signifying it's ready to accept new data.

- **Data Register (dataOut) & Valid Register (validOut):** Temporary registers for holding data payloads meant for dequeue and maintaining a valid status flag respectively utilizing RegEnable and RegNext primitives. `validOut` is determined by io.enq.fire. 
