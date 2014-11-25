function [acc,bestParas,bestAcc,model,contour] = GridSearch(trainD,trainL,testD,testL,kernel)
%GridSearch given mnist data, do grid search for best hyperparameters.
%
%returns acc on test, bestParas found in cross val, and % in crossval
%(bestacc)
%
%Same as SVMCode, but here train and test are given as arguments (mnist)

%use grid search to find best parameters on training set:
if kernel==2 %RFB
    [model, bestParas, bestAcc, contour] = OptimizeRFB(trainL,trainD);
end
if kernel==1%poly kernel
    [model, bestParas, bestAcc, contour] = OptimizePolyKernel(trainL,trainD);
end
if kernel==0%linear kernel
   [model, bestParas, bestAcc, contour] = OptimizeLinear(trainL,trainD); 
end

%libsvm_options = '-s 0 -t 2 -c 8 -g 0.0625 -m 800';
%model = svmtrain(trainLabels,trainData,libsvm_options);


%estimate for out of sample using testset
[preb, acc, prob] = svmpredict(testL,testD,model,'');
%acc = svmpredict(testLabels,testData,model,'');
%train again, but on whole set? 
end

