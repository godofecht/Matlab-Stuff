function y = comb(x, fs, gain, delayLength)
% note, gain should be less than 1. 

delayLength = round(delayLength*fs);

% create coefficients
b = [zeros(1, delayLength), 1];
a = [1,    zeros(1, delayLength-1), -gain];

% filter the input signal 
y = filter(b,a,x);