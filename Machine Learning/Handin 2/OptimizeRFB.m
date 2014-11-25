function [model, bestParas, bestAcc, contour] = OptimizeRFB(dataLabels,dataDigits)
%Do grid search for best parameters for RFB kernel
%I.e. we search for C and gamma
% we do it m fold:
m = 5;

%For testing purposes, we only use a small amount of data:
%data.au_train_labels = data.au_train_labels(1:2000);
%data.au_train_digits = data.au_train_digits(1:2000,:);

bestC = 0;
bestGamma = 0;
bestAcc = 0;

% for contour plot:
X = zeros(m,1); %for Cost
Y = zeros(m,1); %for Gamma
Z = zeros(m,m); %for Acc
x = 1;

%C: 2^-3, 2^-1..2^5
%gamma: 2^-10, 2^-8,..2^-2

for Cexp=-3:2:5
    C = 2^Cexp;
    y = 1;
    for gammaExp=-10:2:-2
       gamma = 2^gammaExp;
       libsvm_options = sprintf('-s 0 -t 2 -c %f -g %f -v %d -m 800 -q',C,gamma,m);
       acc = svmtrain(dataLabels,dataDigits,libsvm_options);
       if acc > bestAcc
          bestAcc = acc;
          bestGamma = gamma;
          bestC = C;
       end
       Z(x,y) = acc;
       Y(y) = gamma;
       y = y+1;
    end
    X(x) = C;
    x = x+1;
end

%report the best found parameters
bestParas = [bestGamma, bestC];

%train model with the best found parameters on entire data. 
libsvm_options = sprintf('-s 0 -t 2 -c %f -g %f',bestC,bestGamma);
model = svmtrain(dataLabels,dataDigits,libsvm_options);

%contour plot
contour = struct('X', X, 'Y', Y, 'Z', Z);
end

