# Specification

### Module Name
`Queue_my`

### Overview
The `Queue_my` module is a hardware component implemented in Chisel that models a first-in-first-out (FIFO) queue. This queue is parameterized by the type of data it stores, the number of entries it can hold, and whether it includes a flush feature to clear all stored data. The module provides synchronous enqueue and dequeue operations and can signal when it is full or empty.

### Parameters
- `gen: T`: The data type of the elements stored in the queue. This is a generic parameter constrained to subtypes of `Data`.
- `entries: Int`: The maximum number of entries (or capacity) of the queue. Must be a positive integer.
- `hasFlush: Boolean`: An optional parameter that specifies whether the queue supports the flush operation. Defaults to `false`.

### Input/Output Interface
The `Queue_my` module has a structured interface defined as follows:

- **Inputs:**
  - `io.enq.bits: T`: The input data to be enqueued into the queue.
  - `io.enq.valid: Bool`: A signal indicating the data on `io.enq.bits` is valid and ready to be enqueued.
  - `io.deq.ready: Bool`: A signal indicating the consumer is ready to dequeue data.

- **Outputs:**
  - `io.deq.bits: T`: The data output from the queue.
  - `io.deq.valid: Bool`: A signal indicating valid data is present on `io.deq.bits` and ready to be dequeued.
  - `io.enq.ready: Bool`: A signal indicating the queue is ready to accept new data.
  - `io.count: UInt`: The current number of elements in the queue.

- **Optional Input:**
  - `io.flush: Option[Bool]`: An optional input signal available if `hasFlush` is `true`. When high, this signal clears all entries in the queue.

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
   - The number of elements currently in the queue is calculated based on the pointers' positions and whether they match. This involves conditional calculation accounting for circular buffer behavior, particularly when the capacity (`entries`) is a power of two.

