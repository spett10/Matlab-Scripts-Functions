function [origData] = preprocessSvm(noise,rot,origData)
%PREPROCESSSVM 
% preprocess the AuDigits data. 
% if noise>0: Add Gaussian noise to 5982 images, and concatenate to final
% data, increasing data size by 5982 with gauss noise
%
% if rot>0: Add rotation(40,20,-20,40) angles to data set split into four, 
% adding the datasize (5982) to the final data, with rotation applied

% if dim>0 we reduce dimension to dim

%load the auDigits. if Args<=0, this is just returned (no preprocess)
%origData = load('auTrain.mat');
tempData = origData;

%do we need noise?
if(noise>0)
    %try to add Gaussian noise
    %noiseIm  = load('auTrain.mat');
    noiseIm = origData;
    noiseIm.au_train_images = imnoise(noiseIm.au_train_digits,'gaussian');

    %add the "new points" with noise to the end of our data set
    origData.au_train_digits = vertcat(origData.au_train_digits, noiseIm.au_train_digits);
    origData.au_train_labels = vertcat(origData.au_train_labels, noiseIm.au_train_labels);
end

%do we need rotation?
if(rot>0)
   
    %rotIM = load('auTrain.mat');
    rotIM = tempData;
    % create random values in the interal of the angles [-40,40]
    % one for each image size(rotIM.au_train_digits(:,1))
    max = size(rotIM.au_train_digits(:,1));
    max = max(1)
    a=-40;
    b=40;
    r = (b-a).*rand(max,1)+a; %hardcoded!
    
    rotIMdigits = rotIM.au_train_digits;
    %size(rotIMdigits)
    % apply rotation of diff angles to each image
    for t=1:size(rotIMdigits)
        rotIM.au_train_digits(t,:) = reshape(imrotate(reshape(rotIMdigits(t,:),28,28),r(t),'nearest','crop'),1,784);
    end
    %imshow(reshape(rotIM.au_train_digits(1,:),28,28))
    %concatenate data to training data, to add "new" points with
    %rotation
    origData.au_train_digits = vertcat(origData.au_train_digits, rotIM.au_train_digits);
    origData.au_train_labels = vertcat(origData.au_train_labels, rotIM.au_train_labels);
end
end
