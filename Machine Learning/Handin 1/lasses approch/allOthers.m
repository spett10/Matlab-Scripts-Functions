function [ theta ] = allOthers()
    trainData = load('mnistTrain.mat');
    X = trainData.images;
    d = length(X(1, :));
    N = length(trainData.labels);
    k = 10;
    theta = zeros(k,d);
    % for each class
    for c=1:k
        %create vector
    	y = NaN(N,1);
        for n=1:N
            if c-1 == trainData.labels(n)
                y(n) = 1;
            else
                y(n) = -1;
            end
        end
        % train
        theta(c,:) = logRun(X, y, theta(c,:));  
    end
end


