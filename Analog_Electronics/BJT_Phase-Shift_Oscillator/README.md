# BJT Phase-Shift Oscillator

## Overview
This repository contains the schematic capture, simulation database, and transient analysis for a three-stage RC phase-shift oscillator. The circuit is built around a 2N2222A bipolar junction transistor (BJT) configured as a common-emitter amplifier. 

## Circuit Architecture & Component Selection
To achieve sustained oscillations (satisfying the Barkhausen criterion), the common-emitter amplifier provides a 180-degree phase shift, and the three-stage RC ladder network provides the remaining 180-degree shift. 

**Key Components:**
* **Transistor:** 2N2222A NPN BJT
* **Power Supply ($V_{CC}$):** 12V
* **Feedback Network:** Three RC stages utilizing 10nF capacitors and 10kΩ resistors.
* **Emitter Degeneration:** 1kΩ resistor bypassed by a 10µF capacitor to stabilize AC gain.
* **Biasing/Load:** Standard voltage divider biasing utilizing 10kΩ resistors.

## Mathematical Verification
The theoretical frequency of oscillation for a three-stage RC network is determined by the feedback components. Using the standard derivation for a BJT phase-shift oscillator where the RC stages are equal, the frequency is modeled as:

$$f = \frac{1}{2\pi R C \sqrt{6 + 4\frac{R_C}{R}}}$$

Given our component values ($R = 10\text{ k}\Omega$, $C = 10\text{ nF}$), this mathematical model dictates the expected frequency boundary, which was then tested against the SPICE simulation.

## Simulation & Transient Analysis Results
A 50ms transient analysis was conducted to verify the startup conditions and steady-state stability of the oscillator. 

**Key Observations from the Graph:**
* **Startup Phase (0ms - 25ms):** The inherent circuit noise is successfully amplified, and the feedback loop drives the exponential growth of the waveform.
* **Steady-State (25ms - 50ms):** The output node `V(Vout)` achieves a stable, continuous sinusoidal oscillation. It oscillates reliably within its voltage ceiling without clipping, verifying the calculated loop gain $|A\beta| \ge 1$.
