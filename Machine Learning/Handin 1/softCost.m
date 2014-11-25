function [ Ein, dEin ] = softCost(X, y, theta)
    N = length(y(:,1));
    Ein = 0;
    K = 10;
    
    parfor t=1:N
        for j=1:K
            if y(t,j) == 1
                Ein = Ein + log(softmaxLasse(theta'*X(t,:)',j));%giv kolonne transponeret af X (da X er (--x^T--))
            end
        end
    end
    %The sum has a negative sign
    Ein = Ein*(-1);
    
    % make softmax for X*theta. For each row, get the
    % column vector from softmax for the product. 
    temp = X*theta;
    S = zeros(N,K);
    % kan vi slippe helt for forloopet?
    for q=1:N
        S(q,:) = softmaxSoeren(temp(q,:));
    end
    %compute gradient as one single matrix product
    %given softmax used on x*theta (S)
    dEin = -(X'*(y-S));
end

function [lasse] = softmaxLasse(x,j)
    c = max(x);
    k = length(x);
    sum = 0;
    for i=1:k
        sum = sum + exp(x(i)-c);
    end
    lasse = exp((x(j)-(c + log(sum))));
end
    
function[soeren] = softmaxSoeren(x)
%Given column vector x, return column vector soeren    
    soeren = zeros(1,length(x));
    c = max(x);    
    sum = 0;
    %compute sum
    for i=1:10
        sum = sum + exp(x(i)-c);
    end
    %compute all elements of the vector, given the sum
    for j=1:10
       soeren(1,j) = exp(x(j)-(c+log(sum))); 
    end
end