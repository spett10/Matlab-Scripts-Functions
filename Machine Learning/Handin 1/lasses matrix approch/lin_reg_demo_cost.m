function [cost,grad] = lin_reg_demo_cost(X,y,theta)
% Demo file showing how to compute the cost and the gradient in linear
% regression.
 cost = (1/length(y))* sum((X*theta-y).^2);
 grad = (1/length(y))*2.*X'*(X*theta-y);
end