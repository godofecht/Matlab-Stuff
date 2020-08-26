function y = distortion(x, gain) 
%% This is where the help file goes...
%
% Syntax
%   length(x) returns the size of the matrix x.
%   The first if statement replaces values equal or greater than 1 with
%   2/3.
%   The second if statement replaces values equal or less than -1 with
%   -2/3.
%   The else clause slightly normalizes any values between 1 and -1.
% Description
%   'x' stores the original signal to be distorted.
%   'y' stores the resultant distorted signal.
%
% Examples 
%   if x is [-1 -1/2 0 1/2 1], distortion(x,1) would return [-2/3 11/24 0 11/24 2/3]
%
% References
%
%   ...
%

x = x.*gain;
 
for i = 1:length(x)
    
 if(x(i) >= 1)        
     y(i) =  2/3;
 elseif(x(i) <= -1)
     y(i) = -2/3;
 else
     y(i) = x(i) - (x(i)^3)/3;
 end
end