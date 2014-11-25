function load_and_show()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    s = load('mnistTrain.mat');% or whatever you have called the file
    images = s.images;
    fprintf('images is a %d x%d matrix\n',deal(size(images)));
    labels = s.labels;
    for i=1:10
        imshow(reshape(images(i,:),28,28));
        fprintf('This is an image of a %d - ',labels(i));
        input('click to see next');
    end

end

