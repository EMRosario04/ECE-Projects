# Multi-Stage Amplifier: Common Collector to Common Emitter

## Overview
This project expands upon a baseline Common Emitter amplifier by introducing a Common Collector (CC) buffer stage The primary objective is to significantly increase the overall input impedance of the system while maintaining the voltage swing and gain characteristics of the subsequent Common Emitter (CE) load.

## System Specifications
The multi-stage design was engineered to meet the following parameters:
* **Power Supply ($V_{CC}$):** 12V
* **AC Signal Generator Resistance:** 0Ω
* **Input Resistance:** > 60kΩ
* **Component Constraints:** Limited to standard resistor values with exactly 3 resistors in the CC stage
* **Output Swing:** Greater than the maximum peak-to-peak input voltage capable of driving the CE stage

## Circuit Architecture
Both stages utilize 2N4410 NPN BJTs. The CE stage serves as the load for the CC stage, presenting an input impedance of 10.31kΩ. 

**Common Collector Stage Components:**
* **Biasing Network:** R1 = 330kΩ, R2 = 330kΩ (yielding a base parallel input resistance of 165kΩ to comfortably exceed the 60kΩ requirement).
* **Emitter Resistor (Re):** 5kΩ.
* **Coupling Capacitors:** 10µF.

## Mathematical Verification
To ensure the transistor remains in the active region across varying beta values, DC analysis was conducted assuming ideal conditions (infinite beta). The base voltage was calculated via the voltage divider equation:

$$ V_b = V_{CC} \cdot \left(\frac{R_1}{R_1 + R_2}\right) = 12 \cdot \left(\frac{1}{2}\right) = 6\text{V} $$

With an estimated $V_{BE}$ of 0.7V, the emitter voltage is 5.3V, resulting in a collector-emitter voltage ($V_{CE}$) of 6.7V. This calculation confirms the emitter remains well within the active region.

## Simulation Results
The integrated multi-stage circuit was verified using SPICE analysis.
* **AC Sweep (CC Stage Only):** Exhibited an input resistance of 129.57kΩ and a unity gain of 0.99V/V.
* **AC Sweep (Combined Circuit):** The full cascaded system maintained an overall voltage gain of 16.32V/V. The slight reduction from the CE stage's standalone gain of 17.43V/V is attributed to the minor voltage drop across the CC buffer.
* **Transient Analysis:** Utilizing a 10kHz input signal with a 0.295V peak, the final output delivered a 9.0766V peak-to-peak swing, successfully meeting both the required gain (>10) and swing (>3V) thresholds without clipping.
