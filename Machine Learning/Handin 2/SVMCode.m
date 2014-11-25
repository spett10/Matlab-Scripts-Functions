function [acc,bestParas,bestAcc,model,contour] = SVMCode(train,test,kernel)
%SVMCODE given dataset, do gridsearch for best hyperparameters
%returns acc on test, bestParas found in cross val, and % in crossval
%(bestacc)
%

%Assume data is of the audigits format (see GridSearch for mnist impl)
%a = size(data.au_train_digits(:,1));
%a = a(1);
%b = round(a/10); %size of testset, Train/10 = test

%extract subset for testset!

%trainLabels = data.au_train_labels(1:a-b,:);
%trainData = data.au_train_digits(1:a-b,:);
%trainLabels = data.au_train_labels(b+1:a,:);
%trainData = data.au_train_digits(b+1:a,:);
trainLabels = train.au_train_labels;
trainData = train.au_train_digits;


%size(trainData)

%testLabels = data.au_train_labels(a-b+1:a,:);
%testData = data.au_train_digits(a-b+1:a,:);
%testLabels = data.au_train_labels(1:b,:);
%testData = data.au_train_digits(1:b,:);
testLabels = test.au_train_labels;
testData = test.au_train_digits;


%use grid search to find best parameters on training set:
if kernel==2 %RFB
    [model, bestParas, bestAcc, contour] = OptimizeRFB(trainLabels,trainData);
end
if kernel==1%poly kernel
    [model, bestParas, bestAcc, contour] = OptimizePolyKernel(trainLabels,trainData);
end
if kernel==0%linear kernel
   [model, bestParas, bestAcc, contour] = OptimizeLinear(trainLabels,trainData); 
end

%libsvm_options = '-s 0 -t 2 -c 8 -g 0.0625 -m 800';
%model = svmtrain(trainLabels,trainData,libsvm_options);

%estimate for out of sample using testset
[preb, acc, prob] = svmpredict(testLabels,testData,model,'');
%acc = svmpredict(testLabels,testData,model,'');

end

