function theta = lin_reg_demo_pinv_train(X,y)
% Demo file showing how to train linear regression classifier with
% pseudoinverse
%
% Input Data matrix X, Target vector Y
% Output optimal weight vector theta
  theta = pinv(X)*y;  
end