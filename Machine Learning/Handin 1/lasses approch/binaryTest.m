function [  ] = binaryTest()

    trainData = load('mnistTrain.mat');
    c1 = 1;
    c2 = 2;

    % extract entries c1 and c2 and give c1 label 1 and c2 label -1 in y 
    [X, y] = extract(c1, c2, trainData);
    % start training
    theta = zeros(1,length(trainData.images(1,:)));
    theta = logRun(X, y, theta);

    % test
    

    testData = load('mnistTest.mat');
    [testX, testy] = extract(c1, c2, testData); 
    theta
    imshow(reshape(theta,28,28), 'DisplayRange', [-0.1 0.1]);
    for i=1:10;
        s = dot(testX(i, :), theta);
        h = exp(s)/(1+exp(s));
        fprintf('h=%i y=%i\n', h, testy(i));
        %imshow(reshape(testX(i, :),28,28));
        %pause
    end
end

% extract entries c1 and c2 and give c1 label 1 and c2 label -1 in y
function [X, y] = extract(c1, c2, s)
    N = 0;
    for i = 1:length(s.labels)
        if s.labels(i) == c1 || s.labels(i) == c2
            N = N+1;
        end
    end
    y = NaN(1, N);
    X = NaN(N, length(s.images(1,:)));
    n = 1;
    for i = 1:length(s.labels)
        if s.labels(i) == c1 || s.labels(i) == c2
            if s.labels(i) == c1
                y(n) = 1;
            else
                y(n) = -1;
            end
            X(n,:) = s.images(i,:);
            n = n+1;
        end
    end
end

