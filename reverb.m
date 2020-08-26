function y = reverb(x, fs, combGain, combDelay, allpassGain, allpassDelay)
%% This is where the help file goes...
%
% Syntax
%  comb(signal, samplerate, gain, delay length)
%  allpass(signal, samplerate, gain, delay length)
%
% Description
%   ...
%
% Examples 
%   ...
%
% References
%
%   ...
%

% comb-filters in parallel:
y1 = comb(x, fs, combGain, combDelay(1));
y2 = comb(x, fs, combGain, combDelay(2));
y3 = comb(x, fs, combGain, combDelay(3));
y4 = comb(x, fs, combGain, combDelay(4));
y = (y1+y2+y3+y4)./4;

% allpass in series:
y = allpass(y, fs, allpassGain, allpassDelay(1));
y = allpass(y, fs, allpassGain, allpassDelay(2));
y = allpass(y, fs, allpassGain, allpassDelay(3));

% normalise...
y = y./max(y);