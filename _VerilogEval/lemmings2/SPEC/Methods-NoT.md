## Base Method-Verilog
Please act as a professional Verilog designer. Give me the complete Verilog code.

```
# Specification

## Module Name
dut

## Overview

The game Lemmings involves critters with fairly simple brains. So simple that we are going to model it using a finite state machine. In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1).

## I/O Ports
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah

## Internal Logic

- In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1). It will switch directions if it hits an obstacle. 
- In particular, if a Lemming is bumped on the left (by receiving a 1 on bump_left), it will walk right. If it's bumped on the right (by receiving a 1 on bump_right), it will walk left. If it's bumped on both sides at the same time, it will still switch directions.
- In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!". When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. 
- Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction.
- Implement a Moore state machine that models this behaviour. areset is
positive edge triggered asynchronous reseting the Lemming machine to walk left.
```
Give me the complete Verilog code.


## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

# Specification

## Module Name
dut

## Overview

The game Lemmings involves critters with fairly simple brains. So simple that we are going to model it using a finite state machine using Chisel. In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1).

## I/O Ports
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah

## Internal Logic

- In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1). It will switch directions if it hits an obstacle. 
- In particular, if a Lemming is bumped on the left (by receiving a 1 on bump_left), it will walk right. If it's bumped on the right (by receiving a 1 on bump_right), it will walk left. If it's bumped on both sides at the same time, it will still switch directions.
- In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!". When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. 
- Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction.
- Implement a Moore state machine that models this behaviour. `reset` is positive edge triggered asynchronous reseting the Lemming machine to walk left.

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks for Chisel.

```

# Specification

## Module Name
Lemmings

## Overview

The game Lemmings involves critters with fairly simple brains. So simple that we are going to model it using a finite state machine using Chisel. In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1).

## I/O Ports
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah

## Internal Logic

- In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1). It will switch directions if it hits an obstacle. 
- In particular, if a Lemming is bumped on the left (by receiving a 1 on bump_left), it will walk right. If it's bumped on the right (by receiving a 1 on bump_right), it will walk left. If it's bumped on both sides at the same time, it will still switch directions.
- In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!". When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. 
- Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction.
- Implement a Moore state machine that models this behaviour. `reset` is positive edge triggered asynchronous reseting the Lemming machine to walk left.


```
Slice the `Internal logic` into several coding tasks for Chisel.
### Task n: 
**Objective:**
**Step:**


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.


```
---
# Specification

## Module Name
Lemmings

## Overview

The game Lemmings involves critters with fairly simple brains. So simple that we are going to model it using a finite state machine using Chisel. In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1).

## I/O Ports
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
## Design Task
### Task 1:  
**Objective:** Define the Finite State Machine (FSM) states for the Lemming.  
**Steps:**  
1. Enumerate states for the FSM: `WalkLeft`, `WalkRight`, and `Fall`.  
2. Implement these states in a Chisel `state` `Enum` construct.  

---

### Task 2:  
**Objective:** Define the module I/O ports.  
**Steps:**  
1. Define all input ports: `bump_left`, `bump_right`, `ground`, and `reset`.  
2. Define all output ports: `walk_left`, `walk_right`, and `aaah`.  
3. Create `Chisel` `Bool()`-typed ports for these signals.  

---

### Task 3:  
**Objective:** Handle the reset functionality.  
**Steps:**  
1. Implement a positive edge-triggered asynchronous `reset` condition.  
2. When reset is active, set the default state to `WalkLeft`.  
3. Ensure that internal direction and state variables are reset correctly on this signal.  

---

### Task 4:   
**Objective:** Handle transitions based on `bump_left` and `bump_right`.  
**Steps:**  
1. Verify the current state (either `WalkLeft` or `WalkRight`).  
2. On a `bump_left` signal (`bump_left=1`), transition from `WalkLeft` to `WalkRight`.  
3. On a `bump_right` signal (`bump_right=1`), transition from `WalkRight` to `WalkLeft`.  
4. Handle the simultaneous `bump_left` and `bump_right` case and toggle the direction regardless of the current state.  

---

### Task 5:  
**Objective:** Implement the falling behavior when `ground = 0`.  
**Steps:**  
1. Determine when `ground` is 0 and move the FSM to the `Fall` state from any walking state.  
2. Ensure that the walking direction (`WalkLeft` or `WalkRight`) is preserved while the FSM is in the `Fall` state.  
3. Transition back to the preserved walking direction (`WalkLeft` or `WalkRight`) when `ground` becomes 1.  

---

### Task 6:  
**Objective:** Implement output logic to drive `walk_left`, `walk_right`, and `aaah`.  
**Steps:**  
1. Define the assignment of `walk_left` and `walk_right` based on the FSM state.  
   - `walk_left=1` when the state is `WalkLeft`.  
   - `walk_right=1` when the state is `WalkRight`.  
2. Drive `aaah` to be 1 only when the FSM is in the `Fall` state.  
3. Drive all other output signals to 0 when not in their respective states.  

---

### Task 7:  
**Objective:** Define the state transition logic and implement it in the FSM.  
**Steps:**  
1. Use a `switch...is` block (or similar pattern) to describe state transitions based on the input signals (`bump_left`, `bump_right`, `ground`).  
2. Ensure transitions follow the described behavior:
   - Switch walking direction on bumps in `WalkLeft` or `WalkRight` states.  
   - Transition to `Fall` state when `ground=0`.  
   - Transition back to the preserved walking state when `ground=1`.  
3. Verify that being bumped while falling does not affect walking direction or transitions.  

---
```

Give me the complete Chisel code.


## NOT-TAG Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.

```
# Specification

## Module Name
Lemmings

## Overview

The game Lemmings involves critters with fairly simple brains. So simple that we are going to model it using a finite state machine using Chisel. In the Lemmings' 2D world, Lemmings can be in one of two states: walking left(walk_left is 1) or walking right (walk_right is 1).

## I/O Ports
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
## Design Task
### Task 1: **State Enumeration & Reset Implementation**  
**Objective:** Define valid states and initialize state machine with proper reset behavior.  
**Steps:**  
1. Create a Chisel `Enum` with four states:  
   - `WalkLeft` (walk_left=1)  
   - `WalkRight` (walk_right=1)  
   - `FallLeft` (aaah=1, retains left direction)  
   - `FallRight` (aaah=1, retains right direction)  
2. Declare a state register (`val state = RegInit(...)`) with asynchronous reset to `WalkLeft`.

---

### Task 2: **Walking State Transitions**  
**Objective:** Handle direction changes due to bumps and transitions to falling when `ground=0`.  
**Steps:**  
1. For `WalkLeft` state:  
   - If `ground=0`, move to `FallLeft` (start falling).  
   - Else, check `bump_left`:  
     - If true, switch to `WalkRight`.  
     - Else, stay in `WalkLeft`.  
2. For `WalkRight` state:  
   - If `ground=0`, move to `FallRight`.  
   - Else, check `bump_right`:  
     - If true, switch to `WalkLeft`.  
     - Else, stay in `WalkRight`.

---

### Task 3: **Falling State Transitions**  
**Objective:** Handle falling behavior and resume walking when `ground=1`.  
**Steps:**  
1. For `FallLeft` state:  
   - If `ground=1`, return to `WalkLeft`.  
   - Else, remain in `FallLeft`.  
2. For `FallRight` state:  
   - If `ground=1`, return to `WalkRight`.  
   - Else, remain in `FallRight`.

---

### Task 4: **Output Logic**  
**Objective:** Generate Moore outputs based on the current state.  
**Steps:**  
1. Assign outputs combinatorially:  
   - `walk_left` = 1 when state is `WalkLeft`, else 0.  
   - `walk_right` = 1 when state is `WalkRight`, else 0.  
   - `aaah` = 1 when state is `FallLeft` or `FallRight`, else 0.

---

### Task 5: **Edge Case Handling**  
**Objective:** Ensure bumps during transitions or falling have no effect.  
**Steps:**  
1. In falling states (`FallLeft`, `FallRight`), explicitly ignore `bump_left` and `bump_right` during transitions.  
2. Validate that bumps during the cycle when `ground` changes (walking → falling or falling → walking) do not alter direction.
```


Give me the complete Chisel code.


## Think Process
Thinking...
> 
> Okay, let's see. I need to break down the internal logic of the Lemmings module into several coding tasks for Chisel. The user wants each task to have an objective and steps. Let me start by understanding the problem thoroughly.
> 
> First, the module is a state machine for a Lemming. The states are walking left, walking right, and maybe a falling state. Wait, the overview mentions two states, but the internal logic also talks about falling when ground is 0. So maybe there are more states. Let me re-read the specs.
> 
> The I/O ports include ground. When ground is 0, the Lemming falls and aaah is 1. When ground comes back, it resumes walking in the previous direction. Also, during falling, bump inputs don't affect direction. So the state machine must track whether the Lemming is walking or falling.
> 
> Hmm. So the states are probably:
> 
> - Walking left
> - Walking right
> - Falling left (to remember direction after falling)
> - Falling right?
> 
> Wait, but when the Lemming is falling, it's not walking. So maybe the state needs to track both the direction (left or right) and whether it's falling. Alternatively, have separate states for falling left and falling right. But the Moore machine's output depends on the current state.
> 
> Wait, the outputs are walk_left, walk_right, and aaah. So when the Lemming is falling, walk_left and walk_right should be 0, and aaah should be 1. When it's walking, aaah is 0, and either walk_left or walk_right is 1.
> 
> So the possible states are:
> 
> - WalkLeft: walk_left=1, others 0
> - WalkRight: walk_right=1, others 0
> - Falling: aaah=1, walk_*=0. But also need to remember the direction before falling to resume after.
> 
> Wait, when the ground comes back (ground=1), the Lemming resumes walking in the same direction as before the fall. So the state during falling must remember the direction. Therefore, the falling state needs to have the direction stored. So perhaps the state has two parts: the main state (walking or falling) and the direction. But in a Moore machine, the outputs are purely a function of the current state. So maybe the states are:
> 
> - WalkLeft
> - WalkRight
> - FallLeft (when falling, direction was left)
> - FallRight (when falling, direction was right)
> 
> Alternatively, have a state register for direction (left/right) and a state for walking/falling. But how to model that in a Moore machine.
> 
> Alternatively, use two state variables: one to track direction (left or right), and another to track whether the Lemming is walking or falling. But since the direction is needed even when falling, this approach might be better. Let's see:
> 
> State variables:
> 
> - walking: Bool (true if walking, false if falling)
> - direction: Bool (left or right)
> 
> Wait, but in Chisel, how to model this? Maybe with an enumeration. Let's think about possible states:
> 
> The states could be:
> 
> - Walking left (walk_left=1)
> - Walking right (walk_right=1)
> - Falling left (aaah=1, walk_*=0, but direction stored as left)
> - Falling right (aaah=1, walk_*=0, direction stored as right)
> 
> Alternatively, when in falling state, the direction is stored in a separate register, so that when ground is restored, the direction is known.
> 
> But in a Moore machine, the outputs are determined solely by the current state. So when the Lemming is in the FallingLeft state, the outputs would be aaah=1, walk_*=0, and when transitioning back, it goes back to WalkingLeft. Similarly for FallingRight.
> 
> So the state enumeration could be:
> 
> - WalkLeft
> - WalkRight
> - FallLeft
> - FallRight
> 
> But maybe that's four states. Let's verify the transitions.
> 
> In WalkLeft state:
> 
> - If ground becomes 0, transition to FallLeft.
> 
> In FallLeft state:
> 
> - If ground becomes 1, transition back to WalkLeft.
> 
> But during WalkLeft, if bump_left is 1 (since it's walking left, bump_left would mean it hits an obstacle), then it should switch to WalkRight.
> 
> Wait, the spec says: "if a Lemming is bumped on the left (by receiving a 1 on bump_left), it will walk right. If it's bumped on the right (by receiving a 1 on bump_right), it will walk left. If it's bumped on both sides at the same time, it will still switch directions."
> 
> So when in WalkLeft state:
> 
> - If bump_left is 1, switch to WalkRight.
> 
> Wait, but when walking left, bump_left would mean it's hitting an obstacle on the left, so it turns around to walk right. Similarly, if in WalkRight state and bump_right is 1, switch to WalkLeft.
> 
> But if both bumps are active at the same time, then the direction is flipped regardless. So for example, if in WalkLeft and both bump_left and bump_right are 1, then switch to WalkRight. Or maybe the priority is such that if both are active, it still switches direction. So regardless of the current state, if a bump occurs on the side it's moving towards, it switches.
> 
> But when the Lemming is walking left, bump_left is the trigger. Similarly, walking right, bump_right is the trigger. So in WalkLeft, if bump_left is 1, switch to WalkRight. If in WalkRight, bump_right is 1, switch to WalkLeft.
> 
> But the problem is, what if both bumps are high when in WalkLeft? Since bump_left is 1, it would switch. If in WalkRight and both bumps are 1, then bump_right is 1, so switch. But the note says, "if it's bumped on both sides at the same time, it will still switch directions." So, for example, when in WalkLeft state and both bumps are high, the direction switches to WalkRight. So the code for state transitions would check the current direction and the corresponding bump signal.
> 
> Now, during the falling state (FallLeft or FallRight), the bumps don't affect the direction. Also, when ground is 0, the Lemming is in falling state. So transitions to falling happen when ground is 0. When the Lemming is in walking state (WalkLeft or WalkRight) and ground becomes 0, transition to the corresponding falling state. While in falling state, if ground becomes 1, transition back to walking in the stored direction.
> 
> So the steps for coding this would involve:
> 
> 1. Define the states (WalkLeft, WalkRight, FallLeft, FallRight) as an enum.
> 2. Handle the reset condition (asynchronous reset to WalkLeft).
> 3. For each state, determine the next state based on inputs (bump, ground).
> 4. Handle transitions between walking and falling states.
> 5. Ensure that during falling, bumps are ignored.
> 6. Handle the case where ground is 0 when the Lemming is walking (transition to falling).
> 7. Handle the case where ground becomes 1 while falling (transition back to walking).
> 8. Output the correct walk_left, walk_right, and aaah signals based on the current state.
> 
> Now, to break this into tasks. Each task should be a manageable coding step.
> 
> Task 1: Define the state enumeration and state register.
> 
> Objective: Create an enumeration for the Lemming's states and instantiate the state register with asynchronous reset to WalkLeft.
> 
> Steps:
> - Define an enumeration type with four states: WalkLeft, WalkRight, FallLeft, FallRight.
> - Declare a state register initialized to WalkLeft with asynchronous reset.
> 
> Task 2: Implement the state transitions for walking states considering bump inputs.
> 
> Objective: Handle direction switching when the Lemming is walking and bumped, and transitions to falling when ground is lost.
> 
> Steps:
> - For WalkLeft and WalkRight states, check bump_left and bump_right respectively.
> - If bumped, switch direction (WalkLeft becomes WalkRight, WalkRight becomes WalkLeft).
> - Also, check if ground is 0. If so, transition to the corresponding falling state (WalkLeft → FallLeft, WalkRight → FallRight).
> 
> Task 3: Handle falling state transitions and direction retention.
> 
> Objective: Manage transitions from falling states back to walking when ground is restored.
> 
> Steps:
> - For FallLeft and FallRight states, check if ground is 1.
> - If ground is 1, transition back to WalkLeft or WalkRight respectively.
> - If ground remains 0, stay in the falling state.
> 
> Task 4: Manage output signals based on current state.
> 
> Objective: Assign walk_left, walk_right, and aaah outputs according to the current state.
> 
> Steps:
> - In WalkLeft: walk_left = 1, others 0.
> - In WalkRight: walk_right = 1, others 0.
> - In FallLeft/FallRight: aaah = 1, walk_* = 0.
> 
> Task 5: Handle edge cases where ground and bumps change in the same cycle.
> 
> Objective: Ensure that bumps during falling or during transitions don't affect direction.
> 
> Steps:
> - In falling states, ignore bump signals when determining next state.
> - When transitioning from walking to falling, ensure that bumps in the same cycle when ground is lost are ignored.
> - When transitioning back from falling, ensure that bumps in the same cycle when ground is restored are considered (but according to the spec, during falling, bumps don't affect direction).
> 
> Wait, the spec says: "Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction."
> 
> So during the transition from walking to falling (when ground becomes 0), if there's a bump in the same cycle, it should not affect direction. Because in that cycle, the Lemming is transitioning to falling. So the order of checking ground and bumps matters. But according to the code structure, when in the walking state (current state is WalkLeft or WalkRight), if ground is 0, the next state is falling, regardless of bumps. So even if the bump occurs in the same cycle as ground=0, the direction is switched only if the ground is 1.
> 
> Wait, when the Lemming is walking (so current state is WalkLeft or WalkRight), and ground is 0, then regardless of the bumps, the next state is the falling state. So even if a bump happens when ground is 0, the Lemming transitions to falling first. Then, in the falling state, bumps are ignored.
> 
> But during the transition from walking to falling, the bumps in the same cycle as ground=0 do not affect direction because the next state is falling, and in the falling state, the direction is remembered. So when the ground returns, the direction is restored. So in this case, when ground=0, the state transitions to falling, and any bumps in that cycle would not affect the direction. For example, in WalkLeft state, if ground=0, the next state is FallLeft. If during that cycle, bump_left is 1 (which would normally cause a transition to WalkRight), but since ground=0, it transitions to FallLeft. So the bump is ignored.
> 
> Therefore, the code structure should make sure that when ground=0, the next state is falling, and the direction is stored. So in the walking states, the next state is determined first by ground. If ground is 0, transition to falling. Otherwise, check bumps.
> 
> So, in code:
> 
> when (currentState is WalkLeft) {
>   if (ground) {
>     check bump_left, and switch direction if needed. If bumped, next state is WalkRight. Else, stay WalkLeft.
>   } else {
>     next state is FallLeft.
>   }
> }
> 
> Similarly for WalkRight.
> 
> Thus, in Task 2, during the walking states, the transitions first check ground. If ground is 0, transition to falling. Otherwise, check bumps to switch direction.
> 
> So for the code steps:
> 
> In WalkLeft state:
> 
> if (ground == 0) {
>   nextState = FallLeft
> } else {
>   if (bump_left) {
>     nextState = WalkRight
>   } else {
>     nextState = WalkLeft
>   }
> }
> 
> Similarly for WalkRight.
> 
> Therefore, the code properly handles the case where ground is lost, transitioning to falling and ignoring bumps in the same cycle.
> 
> So the tasks outlined earlier seem to cover this.
> 
> Another edge case: when the Lemming is in a falling state, and ground becomes 1, but in the same cycle, there's a bump. But according to the spec, when ground reappears, the direction is the same as before falling, and bumps during that transition do not affect the direction. So when transitioning from FallLeft to WalkLeft, even if there's a bump_left in that cycle, the state transitions to WalkLeft first, and then in the next cycle, during WalkLeft, the bump would be considered. So during the transition from falling to walking, the direction is restored, and bumps in the same cycle as ground being restored are ignored. Wait, but the spec says: "being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction."
> 
> So if the Lemming is in FallLeft state, and ground is 1, the next state is WalkLeft. Even if in that cycle there's a bump_left (which would normally cause WalkLeft to transition to WalkRight), but the current state is FallLeft. However, the transition from FallLeft to WalkLeft happens regardless of bumps, and once in WalkLeft, the bump is evaluated. Wait, but the spec says that in the same cycle as ground reappears (transitioning back to walking), the bumps in that cycle do not affect the direction. Hmm. Wait, the spec says:
> 
> "being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction."
> 
> So when the ground disappears (transitioning from walking to falling), and in that same cycle a bump occurs, the bump is ignored. Similarly, when the ground reappears (transitioning from falling to walking), and in that same cycle a bump occurs, the bump is ignored. So even in the first cycle when transitioning back to walking, the bumps in that cycle do not affect the direction.
> 
> Wait, no. The spec says that when the ground reappears while still falling (so the transition to walking happens), the bumps in that same cycle do not affect the direction.
> 
> For example: suppose the Lemming is in FallLeft state. Then ground becomes 1. So next state is WalkLeft. But during that transition (same cycle as ground becomes 1), if there's a bump_left, the code would transition to WalkLeft. Then, in the next cycle, the state is WalkLeft, and the bump_left is checked. So in that case, the bump in the same cycle as ground reappears (the transition to WalkLeft) is not considered. But according to the spec, bumps in that cycle should not affect the walking direction.
> 
> Wait, perhaps during the transition from falling to walking, the code should ignore bumps. Let me re-examine the spec.
> 
> "being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction."
> 
> So the cases are:
> 
> 1. Bumped while falling (state is falling) → no effect.
> 
> 2. Bumped in the same cycle as ground disappears (i.e., when transitioning to falling) → no effect.
> 
> 3. Bumped in the same cycle as ground reappears (transitioning back to walking) → no effect.
> 
> So in all these cases, bumps are ignored.
> 
> So during the transition from walking to falling (when ground is 0), even if there's a bump in that cycle, the direction switching due to bump is ignored. Similarly, during the transition from falling to walking (when ground becomes 1), any bumps in that cycle are ignored.
> 
> Wait, but how is that handled in the code? Let's think.
> 
> When in WalkLeft state, and ground becomes 0, next state is FallLeft. The code checks ground first. So in that case, even if there's a bump_left in the same cycle, the next state is FallLeft. So the bump is ignored. Similarly, when in FallLeft state, ground becomes 1: next state is WalkLeft. Even if there's a bump_left in that cycle, the next state is WalkLeft, and the bump is processed in the next cycle. So in the same cycle as transitioning back to walking, the bump is not considered. But once the state is WalkLeft, in the next cycle, the bump will be considered.
> 
> So according to the code structure outlined, the spec's requirements are met. Hence, the code as structured handles these edge cases.
> 
> So the tasks are:
> 
> Task 1: Define the state enumeration and state register.
> 
> Task 2: Implement transitions for walking states, considering ground and bumps.
> 
> Task 3: Implement transitions for falling states, considering ground.
> 
> Task 4: Assign outputs based on current state.
> 
> Additionally, maybe a task to handle the reset.
> 
> Wait, the reset is part of Task 1. The state register is initialized to WalkLeft on reset.
> 
> Another possible task: testing and handling of all edge cases. But since the user wants to split into coding tasks, not testing tasks.
> 
> So the tasks as outlined earlier seem appropriate.
> 
> So, summarizing the tasks:
> 
> Task 1: Create the state enumeration and register.
> 
> Task 2: Handle walking state transitions (ground and bumps).
> 
> Task 3: Handle falling state transitions (ground).
> 
> Task 4: Set outputs based on state.
> 
> But maybe need to separate the walking state transitions into two parts: bump handling and ground handling.
> 
> Alternatively, the steps can be structured as such.
> 
> Now, let's structure each task with their specific steps.
> 
