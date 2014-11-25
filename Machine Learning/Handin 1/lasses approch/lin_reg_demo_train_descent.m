function [theta_l,cost_l] = lin_reg_demo_train_descent(X,y,theta)
%LIN_REG_DEMO_TRAIN_DESCENT is a simple demo of applying gradient descent.
%We have outsourced the computation of the cost function and gradient
%making it quite generic. Ignoring all the stuff where we store the values
%so we can plot them the recipe should be quite straightforward.
  lr = 0.02;
  max_iter = 100;
  theta_l = nan(max_iter,length(theta));
  cost_l = nan(max_iter,1);
  cost_l(1) = lin_reg_demo_cost(X,y,theta);
  theta_l(1,:) = theta;
  for i=2:max_iter+1
    [cost_l(i-1),grad] = lin_reg_demo_cost(X,y,theta_l(i-1,:)');
    theta_l(i,:) = theta_l(i-1,:)' - lr*grad;      
  end
  [cost_l(end),dum] = lin_reg_demo_cost(X,y,theta_l(end,:)');  
end

