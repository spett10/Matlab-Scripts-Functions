function [trainDigitsReducedDim, testsReducedDim] = reduceDimension(trainDigits, testDigits, dim)
%DIMENSIONALITYTEST Summary of this function goes here
%   Detailed explanation goes here

% inspired by
% http://matlabdatamining.blogspot.dk/2010/02/principal-components-analysis.html
[coeff, score] = princomp(zscore(trainDigits));
trainDigitsReducedDim = score(:, 1:dim);
testNewBasis = zscore(testDigits)*coeff;
testsReducedDim = testNewBasis(:, 1:dim);

padded = padarray(testsReducedDim, [0 size(testDigits,2)-dim], 0, 'post');
reconstructed = (padded * coeff') .* repmat(std(testDigits),[size(testDigits,1) 1]) + repmat(mean(testDigits),[size(testDigits,1) 1]);
imshow(reshape(reconstructed(55,:),28,28));
end

