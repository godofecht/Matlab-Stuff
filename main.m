% Read input signal:
[y, fs] = audioread('nobody.wav');

% Apply delay to the signal:
seconds = 0.1;
nTaps = 10;
decay = 0.5;
gain = 1;
y = delay(x, fs, seconds, nTaps, decay, gain);

% Apply distortion to the signal:
gain = 20;
%y = distortion(y, gain);

% Apply reverb to the signal: 
combGain = 0.3;
allpassGain = 0.9;
combDelayLen = [0.0001, 0.0002, 0.0003, 0.0005]; %early delay time in seconds
allpassDelayLen = [0.05, 0.01, 0.085, 0.07]; %late time in seconds
%y = reverb(y, fs, combGain, combDelayLen, allpassGain, allpassDelayLen);

% Normalise and write the signal to a wav file:
y = y./max(y);
audiowrite('nobody_processed.wav',y,fs)