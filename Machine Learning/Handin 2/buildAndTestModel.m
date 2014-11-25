function [model,acc] = buildAndTestModel(traindata,testdata,libsvm_options)
%BUILDANDTESTMODEL Train SVM with libsvm_options on traindata, 
%afterwards, test on testdata. Return model and ACC on testdata.

%if train is au
%trainLabel = traindata.au_train_labels;
%trainDigit = traindata.au_train_digits;

%if train is mnist
trainLabel = traindata.labels;
trainDigit = traindata.images;

%if the test is from au
%testLabel = testdata.au_train_labels;
%testDigit = testdata.au_train_digits;

%if the test is mnist
testLabel = testdata.labels;
testDigit = testdata.images;

%train
model = svmtrain(trainLabel,trainDigit,libsvm_options);

%test
[preb, acc, prob] = svmpredict(testLabel,testDigit,model,'');

end

