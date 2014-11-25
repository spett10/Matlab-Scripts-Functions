function [predictions] = runBestSVM(images)
%RUNBESTSVM Input is n images (as a matrix n x image vector)
%and output is a vector of predictions.

%Assume user has the supplied best Support Vector Machine
model = load('bestSvm.mat');

%extract the classifier for auDigits:
classifier = model.model;

%since we just want prediction vector, feed it random labels
%and ignore its output of acc (it needs labels)
labels = rand(size(images(:,1)));

%only extract the predictions, discard the rest
predictions = svmpredict(labels,images,classifier);
end

