# Finite_Impluse_Response_Filter

A Moving Average FIR filter smooths an input signal by averaging the current and previous N-1 samples. It acts as a low-pass filter, attenuating high-frequency noise while preserving the underlying signal trend.
The transfer function for an 8-tap moving average filter is: 
y[n] = (1/8) * (x[n] + x[n-1] + x[n-2] + x[n-3] + x[n-4] + x[n-5] + x[n-6] + x[n-7])
All 8 coefficients are equal: h[k] = 1/8

Finite_Impulse_Response_Filter/
├── fir_filter.v          # RTL design — 8-tap moving average FIR filter module
├── fir_filter_tb.v       # Testbench — sine wave input stimulus and output verification
├── input.data            # Input samples generated using Python (sine wave)
├── save.data             # Output samples captured from Vivado simulation
├── FIR_filter.png        # Simulation waveform screenshot from Vivado
└── README.md


# Module Description
fir_filter.v

Implements an 8-tap FIR moving average filter
Features: synchronous reset and enable control
Input: signed digital samples
Output: filtered/averaged output samples

fir_filter_tb.v

Reads sine wave samples from input.data
Applies samples to the filter module clock cycle by clock cycle
Writes the filtered output to save.data
Can be used to verify correct filtering behavior

