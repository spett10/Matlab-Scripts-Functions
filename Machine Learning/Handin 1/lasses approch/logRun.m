function [argmin] = logRun(X, y, theta)
max = 100;
N = length(y);
step = 0.01;
% find global minimum
for t=1:max
   [Ein, dEin] = logCost(X, y, theta);
   dEinN = norm(dEin);
   if Ein < 5e-6 && dEinN < 5e-6
       break;
   end
   stepD = step*dEinN;
   theta = theta - stepD * dEin;
end
argmin = theta;
end
