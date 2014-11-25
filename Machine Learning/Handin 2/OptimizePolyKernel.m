function [ model, bestParas, bestAcc, contour] = OptimizePolyKernel(dataLabel,dataDigit)
%Grid searches for the best poly kernel
%data = to train on
%cost = the cost of a vector be on the otherside of the line


%Uncomment in tests to to reduce data sets and speed up runs!
%data.au_train_labels = data.au_train_labels(1:2000);
%data.au_train_digits = data.au_train_digits(1:2000,:);




%n = size(data.au_train_labels,1);

bestC = 0;
bestD = 0;
bestAcc = 0;

% prepares contour plot

X = zeros(5,1);
Y = zeros(5,1);
Z = zeros(5,5);
x = 1;
for Cexp=15:2:19
    C = 2^Cexp;
    y = 1;
    for d=2:2
        libsvm_options = sprintf('-s 0 -t 1 -c %f -d %f -v 5 -m 800',C,d);
        acc = svmtrain(dataLabel, dataDigit, libsvm_options);
        if acc > bestAcc
            bestAcc = acc;
            bestD = d;
            bestC = C;
        end
        Z(x,y) = acc;
        Y(y) = d;
        y = y+1;
    end
    X(x) = C;
    x = x+1;
end
%Produce model for best parameters
bestParas = [bestD, bestC];
libsvm_options = sprintf('-s 0 -t 1 -c %f -d %f -m 800',bestC, bestD);
model = svmtrain(dataLabel, dataDigit, libsvm_options);
contour = struct('X', X, 'Y', Y, 'Z', Z);

end

