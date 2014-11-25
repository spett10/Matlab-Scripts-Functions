function  lin_reg_demo()
%LIN_REG_DEMO and its associated functions shows how to use gradient
%descent for linear regression and plot its cost function progress iteratively.
%
  % Make som 1D data
  X = 5*rand(50,1);
  % Add bias term (all ones)
  X = [ones(size(X,1),1) X];
  % line to predic - notice that it is a column vector e.g. 1 x 2 matrix
  line = [-15;10];
  % make target with gaussian noise (randn returns random gaussian)
  y = X*line + randn(size(X,1),1);
  disp(eig(X'*X));
  % Compute a sequence of gradient descent steps
  start = line - [1;-2];
  [theta_l,cost_l] = lin_reg_demo_train_descent(X,y,start);
  % Compute Optimal Using Formula
  ti = lin_reg_demo_pinv_train(X,y);
  % Compute the cost of optimal
  [ci,grad] = lin_reg_demo_cost(X,y,ti);
  % Compare results
  fprintf('Grad Descent Cost %f, pinv formula cost %f, diff %f\n',cost_l(end),ci,abs(cost_l(end)-ci));
  fprintf('Parameters for pinv formula %f,%f\n',deal(ti));
  fprintf('Parameters for gradient descent %f,%f\n',deal(theta_l(end,:))); 
  fprintf('Parameter Different %f\n',norm(ti-transpose(theta_l(end,:))));
  input('Plot the development in the cost function when using gradient descent step by step','s');
  %ax1 = gca();
  %hold(ax1,'on');
  %plot(ax1,ti(1),ti(2),'rs','markersize',10,'linewidth',3);
  f = figure();
  ax2 = axes('parent',f);
  hold(ax2,'on');
  for i=1:length(cost_l)
    %plot(ax1,theta_l(i,1),theta_l(i,2),'wx','markersize',8,'linewidth',3);    
    plot(ax2,i,cost_l(i),'bx','markersize',8,'linewidth',3);
    input('Next Point','s');
  end

end


function cal = make_cost_contour(X,y,lambda,tm)
  clf();
  xx = linspace(tm(1)-5,tm(1)+5,100);
  xy = linspace(tm(2)-5,tm(2)+5,100);
  cal = nan(length(xx),length(xy));
  for i=1:length(xx)
    for j = 1:length(xy)
      [cal(i,j),dum] = cost(X,y,lambda,[xx(i);xy(j)]);
    end
  end  
 
  contourf(xx,xy,cal,50);
  fprintf('eigenvalues:\n');
  disp(eig(X'*X));
 
end