# Matlab-Stuff

MATLAB scripts for audio effect DSP.

## What this is

Five classic audio effects, each written out as a short MATLAB function: delay, comb filter, allpass filter, reverb and distortion. DSP (digital signal processing) means changing sound by doing maths on the list of numbers that make up a digital recording. Each file holds one effect's equation with very little around it, so you can read exactly how the effect works.

The repo includes a short test recording, `nobody.wav`, and `nobody_processed.wav`, the same clip after the delay effect. You can run an effect and compare your result with it.

## What you can learn from it

Music Technology:

- What a delay (echo) is: the same sound played again later and quieter, many times over.
- How a reverb, the sense of a sound in a room, can be built from many short echoes.
- What a filter is in DSP terms: a rule that mixes each sample with earlier samples. Comb and allpass filters are two kinds used in reverbs.
- What distortion does: it flattens the loud peaks of a wave, which adds harmonics (the quieter, higher overtones that make a sound brighter and grittier).

Maths and Computer Science:

- How sound is stored as numbers: a sample rate (`fs`, samples per second) and a list of sample values.
- Difference equations: each output sample is worked out from current and past input and output samples.
- Working with vectors and the `filter` function in MATLAB.

## Run it

### On your own computer

**You will need:**

- [MATLAB](https://www.mathworks.com/products/matlab.html). MATLAB needs a paid licence from MathWorks. Many schools, colleges and universities have one, so ask your teacher.
- Or [GNU Octave](https://octave.org/download), a free program that runs most MATLAB code. These scripts only use `audioread`, `audiowrite`, `filter` and basic maths, which Octave also has. They have not been tested in Octave.
- Headphones or speakers.

Steps:

1. Download this repo with **Code > Download ZIP** on GitHub and unzip it.
2. Open MATLAB or Octave and set the current folder to the unzipped folder.
3. Load the test clip and play it. Type this in the Command Window:

   ```matlab
   [x, fs] = audioread('nobody.wav');
   sound(x, fs)
   ```

4. Apply the delay and listen. This uses the same settings as `main.m`: an echo every 0.1 seconds, 10 echoes, each half as loud as the last.

   ```matlab
   y = delay(x, fs, 0.1, 10, 0.5, 1);
   y = y ./ max(abs(y));
   sound(y, fs)
   ```

   `delay.m` prints some arrays to the screen while it runs, which you can ignore. The result should sound like `nobody_processed.wav`.

5. Try the distortion:

   ```matlab
   y = distortion(x, 20);
   sound(y, fs)
   ```

6. Try the reverb, with the settings from `main.m`:

   ```matlab
   y = reverb(x, fs, 0.3, [0.0001, 0.0002, 0.0003, 0.0005], 0.9, [0.05, 0.01, 0.085, 0.07]);
   sound(y, fs)
   ```

7. To save a result as a file:

   ```matlab
   audiowrite('my_result.wav', y, fs)
   ```

`main.m` is meant to run the whole chain in one go, but it has a bug: it loads the clip into `y` and then passes `x` to `delay`. See "Project status".

## How it works

| File or folder | What is in it |
|---|---|
| `delay.m` | Adds `nTaps` copies of the input, each `seconds` later and multiplied again by `decay`. |
| `comb.m` | A feedback comb filter: the output is fed back into itself after a delay, scaled by `gain`. |
| `allpass.m` | An allpass filter: it passes all frequencies at the same level but smears them in time. |
| `reverb.m` | Four comb filters in parallel, averaged, then three allpass filters in series. |
| `distortion.m` | A cubic soft clipper: `x - x^3/3` for quiet samples, and a fixed level of ±2/3 for loud ones. |
| `main.m` | A script that loads `nobody.wav`, applies the effects and writes `nobody_processed.wav`. |
| `nobody.wav` | Test input: 1.5 seconds, mono, 44.1 kHz. |
| `nobody_processed.wav` | The test input after the delay: 2.5 seconds long, because 10 echoes at 0.1 seconds add 1 second. |

## Ideas to try

1. Change the echo. In the `delay` call, try a longer gap (0.3 seconds) and fewer echoes (4).
2. Change how hard the distortion is driven. In `distortion.m`, compare a gain of 2 with a gain of 50.
3. Make a bigger room. Classic reverbs use comb delays of about 30 to 45 milliseconds. Try `[0.030, 0.035, 0.040, 0.045]` as the comb delays when you call `reverb`.
4. Fix `main.m` so it runs: change `[y, fs]` to `[x, fs]` on the first line, then uncomment the distortion and reverb lines one at a time.
5. Ambitious: write `tremolo.m`, which multiplies the signal by a slow sine wave so the volume pulses. Use `distortion.m` as a model for a function file.

## Technical details

From the previous README:

These are written to be read. Each one is the difference equation with as little around it as MATLAB allows, which makes them a reasonable starting point before porting an effect to C++.

Equations, from the code (`D` is the delay in samples, `g` the gain):

- Comb (`comb.m`): `b = [0 ... 0 1]`, `a = [1 0 ... 0 -g]`, so `y[n] = x[n-D] + g·y[n-D]`.
- Allpass (`allpass.m`): `b = [g 0 ... 0 1]`, `a = [1 0 ... 0 g]`, so `y[n] = g·x[n] + x[n-D] - g·y[n-D]`.
- Distortion (`distortion.m`): `y = x - x³/3` for `-1 < x < 1`, clamped to ±2/3 outside. This curve meets the clamp smoothly at ±1.

## Project status

These scripts date from 2020 and are not being developed. Known problems:

- `main.m` reads the clip into `y` and then calls `delay(x, ...)`, so it stops with an error that `x` is not defined.
- `delay.m` is missing semicolons on the `head` and `tail` lines, so it prints large arrays while it runs.
- `reverb.m` takes four allpass delays but uses only the first three.
- The comb delays in `main.m` (0.1 to 0.5 milliseconds) are much shorter than the allpass delays (10 to 85 milliseconds). Classic Schroeder reverbs do the opposite, so the default reverb sounds more like a metallic filter than a room.
- `main.m` and `reverb.m` normalise with `y./max(y)`. If the largest peak is negative, the result can clip. `max(abs(y))` avoids this.
- The example in the help text of `distortion.m` gives `11/24` for an input of `-1/2`. The correct output is `-11/24`.
- `delay.asv` is a MATLAB autosave file and can be deleted.

## Licence

You can use, copy and change this code for any purpose, as long as you keep the copyright notice. See [LICENSE](LICENSE) (MIT).

## Credits

- Written by Abhishek Shivakumar, 2020.
- The reverb follows the comb-and-allpass design of Manfred Schroeder.
