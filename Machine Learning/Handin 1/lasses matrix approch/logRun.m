function [argmin] = logRun(X, Y, theta)
max = 600;
step = 0.2;
% find global minimum
for t=1:max
    sigma = 1./(1+exp(-(X*theta)));
    dEin = (-X')*(Y-sigma);
    if mod(t, 10) == 0
        [Ein, dEinSlow] = logCost(X, Y, theta); 
        Ein
        if Ein < 0.01
            break
        end
    end
    dEinN = norm(dEin);
    if dEinN < 1e-3
        break;
    end
    theta = theta - step*(dEin/dEinN);
end
argmin = theta;
end
