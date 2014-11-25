function [model, bestC, bestAcc, contour] = OptimizeLinear(dataLabels,dataDigits)
%OptimizeLinear optimize linear kernel, use m-fold cross evaluation
%to find best parameter for the cost c:

%we do m-fold:
m = 5;


%For testing purposes, we only use a small amount of data:
%data.au_train_labels = data.au_train_labels(1:2000);
%data.au_train_digits = data.au_train_digits(1:2000,:);

bestC = 0;
bestAcc = 0;

% for contour plot:
X = zeros(m,1); %for Cost
Y = zeros(m,1); %for Gamma
Z = zeros(m,m); %for Acc
x = 1;

%C: 2^-3, 2^-1..2^5

for Cexp=5:2:11
    C = 2^Cexp;
    y = 1;
       libsvm_options = sprintf('-s 0 -t 0 -c %f -v %d',C,m);
       acc = svmtrain(dataLabels,dataDigits,libsvm_options);
       if acc > bestAcc
          bestAcc = acc;
          bestC = C;
       end
       Z(x,y) = acc;
       %Y(y) = gamma;
       y = y+1;
    X(x) = C;
    x = x+1;
end

%report the best found parameters

%train model with the best found parameters on entire data. 
libsvm_options = sprintf('-s 0 -t 0 -c %f',bestC);
model = svmtrain(dataLabels,dataDigits,libsvm_options);

%contour plot
contour = struct('X', X, 'Y', Y, 'Z', Z);


end

