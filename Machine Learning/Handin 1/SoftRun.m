function [bestPara] = SoftRun(X,y,theta)
%takes X,y,theta, and runs gradient descent. 
maxIter = 100;
step = 0.1;
%lambda = 0.001;
%plotEin = NaN(maxIter,2);
%find global minimum!
%softcosts Ein returner abnormt store tal? 1,..e^06 etc?! ender på 1..e^03
for t=1:maxIter
   [Ein, dEin] = softCost(X,y,theta);
   if Ein < 5e-6
       break;
   end
   %with weight decay:
   %theta = theta*(1-2*step*lambda) - step * (dEin / norm(dEin));
   %plotEin(t,2) = Ein;
   %without weight decay:
   theta = theta - step * (dEin/ norm(dEin));
end
bestPara = theta;
%plot(plotEin)
end

