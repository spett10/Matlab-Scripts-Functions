function [ Ein, dEin ] = logCost(X, y, theta)
%LOGCOST Summary of this function goes here
%   Detailed explanation goes here
    N = length(y);
    Ein = 0;
    dEin = zeros(1, length(theta));
    for n = 1:N
        dotT = dot(theta, X(n,:));
        Ein = Ein + log(1+exp(-y(n)*dotT));
        dEin = dEin - (y(n)*X(n,:)) / (1+exp(y(n)*dotT));
    end
    Ein = Ein/N;
    dEin = dEin/N;
    %dEin = X'*(y-1/(1+exp(X*theta)));

end

