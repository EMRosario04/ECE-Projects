# Common Emitter Amplifier Design

## Overview
This repository contains the design, mathematical verification, and SPICE simulation of a capacitively coupled Common Emitter (CE) amplifier. The circuit is engineered to provide high voltage gain while meeting strict input resistance and output swing thresholds using a limited number of standard components.

## System Specifications
The amplifier was designed to satisfy the following operational constraints:
* **Power Supply ($V_{CC}$):** 12V
* **Load Resistance ($R_L$):** 20kΩ
* **Voltage Gain ($|A_v|$):** > 10 V/V
* **Input Resistance ($R_{in}$):** > 8kΩ
* **Output Voltage Swing:** > 3V peak-to-peak
* **Component Constraints:** Exactly 5 resistors (standard values only)

## Circuit Architecture & Component Selection
The core active component is a **2N4410 NPN BJT**. A voltage divider bias network was specifically implemented to ensure the input resistance remains beta-independent and securely above the 8kΩ threshold.

* **Biasing Network:** $R_1 = 180\text{k}\Omega$, $R_2 = 15\text{k}\Omega$ (Yielding a base DC input resistance of $13.84\text{k}\Omega$)
* **Collector Resistor ($R_C$):** $5.1\text{k}\Omega$
* **Emitter Resistor ($R_E$):** $200\Omega$
* **Coupling Capacitors ($C_1, C_2$):** $10\text{\mu F}$

## Mathematical Verification
To achieve the target voltage gain of at least 10, the collector and emitter resistors were calculated using the standard CE gain approximation. Assuming the intrinsic emitter resistance ($r_e'$) is negligible for the boundary calculation:

$$|A_v| \approx \frac{R_C \parallel R_L}{R_E} \ge 10$$

Given the $20\text{k}\Omega$ load and a chosen $5.1\text{k}\Omega$ collector resistor, the emitter resistor must be $R_E < 406\Omega$. A standard $200\Omega$ resistor was selected to safely exceed the gain requirement.

## Simulation & Verification Results
The design was rigorously verified using SPICE analysis (DC, AC, and Transient) to ensure real-world viability.

* **DC Operating Point:** The collector-emitter voltage ($V_{CE}$) stabilized at **6.17V**. This confirms the transistor operates squarely in the active region, providing ample headroom for the required 3V output swing before hitting saturation.
* **AC Sweep:** Frequency analysis yielded an actual voltage gain of **17.4 V/V** and an input resistance of **10.31kΩ**, comfortably exceeding both design constraints. The equivalent output resistance ($R_{out}$) was measured at $5.039\text{k}\Omega$.
* **Transient Analysis:** When driven by a 10kHz, 0.3V peak input signal, the amplifier output demonstrated a clean, distortion-free voltage swing of **9.1V peak-to-peak**.
