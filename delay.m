function y = delay(x, fs, seconds, nTaps, decay, gain)
%% This is where the help file goes...
%
% Syntax
%   ...
%
% Description
% 'head' is used to set the number of zeroes before the delayed signal.
% 'tail' is used to set the number of zeroes after the delayed signal.
% 'gain' is used to set the amplitude of the signal.
% 'decay' is used to decrease the amplitude of the signal, multiplicatively.
% 'newDelayLine' is used to store the delayed signal at each iteration of the for loop.
%
%
% Examples 
% 
%
% References
%
%   ...
%

nSamples = round(seconds*fs);

y = [x; zeros(nTaps*nSamples, 1)]*gain;

for tapNo = 1:nTaps
    head = zeros(nSamples*tapNo,1)
    tail = zeros((nSamples*nTaps)-(nSamples*tapNo),1)
    newDelayLine = [head; x; tail];
    gain = gain*decay;
    
    y = y + newDelayLine*gain;              
end