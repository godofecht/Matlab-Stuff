# Matlab-Stuff

Audio effect DSP written out as MATLAB scripts, one effect per file.

| Script | Effect |
|---|---|
| `delay.m` | A single delay line. |
| `comb.m` | Comb filter. |
| `allpass.m` | Allpass filter, the building block for the reverb. |
| `reverb.m` | Comb and allpass sections combined. |
| `distortion.m` | Waveshaping distortion. |

`nobody.wav` is the test input and `nobody_processed.wav` is one of the outputs,
so a script can be run and its result compared against a known result rather
than judged by ear alone.

These are written to be read. Each one is the difference equation with as little
around it as MATLAB allows, which makes them a reasonable starting point before
porting an effect to C++.

## Run

Open a script in MATLAB or Octave and run it. Each reads `nobody.wav` from the
working directory.
