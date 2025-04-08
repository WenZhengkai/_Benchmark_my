# Specification

### Module Name
`Queue_my`

### Overview
The `Queue_my` module is a hardware component that models a first-in-first-out (FIFO) queue. This queue is parameterized by the type of data it stores, the number of entries it can hold, and whether it includes a flush feature to clear all stored data. The module provides synchronous enqueue and dequeue operations and can signal when it is full or empty.


### Input/Output Interface
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [4:0] io_count
### Internal Logic
1. **Memory for Storage (`ram`)**: The queue uses a memory block (`Mem`) to physically store the data entries, sized according to the `entries` parameter.

2. **Pointer Management**:
   - `enq_ptr` and `deq_ptr` are counters tracking the indices for enqueueing and dequeueing, respectively.
   - `ptr_match` determines if the `enq_ptr` and `deq_ptr` values are equal.
  
3. **Full/Empty Logic**:
   - The queue is deemed full if `ptr_match` is true and `maybe_full` is true.
   - The queue is empty if `ptr_match` is true and `maybe_full` is false.

4. **Data Enqueue/Dequeue**:
   - When `do_enq` is valid, data is written into `ram` at the `enq_ptr` position and the `enq_ptr` is incremented.
   - When `do_deq` is valid, the `deq_ptr` is incremented.

5. **Flush Mechanism**:
   - If `hasFlush` is true and `io.flush` is asserted, both `enq_ptr` and `deq_ptr` are reset, and `maybe_full` is cleared.

6. **Count Calculation**:
   - define `diff`: `Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, (entries.U + enq_ptr) - deq_ptr)`, 
   - when `full` is true, `count` is `entries.U`, otherwise, `count` is `diff`


