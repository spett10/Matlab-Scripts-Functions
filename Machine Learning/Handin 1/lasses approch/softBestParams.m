%STATUS! Ein fra softCost er forkerte, giver mega store tal

%Load data and create X (n x d+1)
trainDataMnist = load('mnistTrain.mat');
X = trainDataMnist.images;
%add bias terms (all ones)
X = [ones(size(X,1),1) X];
%size(X)
labels = trainDataMnist.labels;

%number of data points
N = length(X(:,1));
% number of classes
K = 10;
% dimension of each data point
d = length(X(1,:));

%Construct matrix Y (n x K). 
%each column is a vector y of 0's, except that y(i) = 1 iff a target
%belongs to class i. 
Y = zeros(N,K);
%size(Y)
for n=1:N
   i = labels(n); %hvad tal er det n'te punkt? (0..9)
   Y(n,i+1) = 1; %smid et 1 ind på den rigtige plads (1...10)
end

% START TRAINING
theta = zeros(d,K); %could also start with random
theta = SoftRun(X,Y,theta);

% prøv at plotte vægte?
%{
plottheta = theta([2:length(theta(:,1))],:);
%size(plottheta)
for h=1:10
   tempRow = plottheta(:,h);
   imshow(reshape(tempRow,28,28), 'DisplayRange',[min(tempRow),max(tempRow)]);
   input('click to see next');
end
%}

%Compare against Test Set!
testData = load('mnistTest.mat');
testX = testData.images;
%prop en "bias" række ind? så dim passer..
testX = [ones(size(testX,1),1) testX];

testy = testData.labels;
testSize = 10000;
connectness = 0;

pY = testX*theta;

for i=1:testSize;
        % compare against each class
        argmax = 0;
        hmaxVal = 0;
        for k=1:10
            s = pY(i,k);
            if s > hmaxVal
                hmaxVal = s;
                argmax = k-1;
            end
        end
        if argmax == testy(i)
            connectness = connectness + 1;
        end
end
fprintf('correctness on mnist:');
connectness = connectness/testSize

%define bestparameters for mnistTrain
softThetaMinst = theta;

%DO THE SAME FOR AUDIGITS, i.e TRAIN ON IT! 
auTrain = load('auTrain.mat');
auX = auTrain.au_train_digits;
auLabels = auTrain.au_train_labels;

%add bias terms (all ones)
auX = [ones(size(auX,1),1) auX];

%number of data points
N = length(auX(:,1));
% number of classes
K = 10;
% dimension of each data point
d = length(auX(1,:));

Y = zeros(N,K);

for n=1:N
   i = auLabels(n); %hvad tal er det n'te punkt? (0..9)
   Y(n,i+1) = 1; %smid et 1 ind på den rigtige plads (1...10)
end

% START TRAINING
theta = rand(d,K);
theta = SoftRun(auX,Y,theta);

%Compare against Test Set!
testData = load('mnistTest.mat');
testX = testData.images;
%prop en "bias" række ind? så dim passer..
testX = [ones(size(testX,1),1) testX];

testy = testData.labels;
testSize = 10000;
connectness = 0;

pY = testX*theta;

for i=1:testSize;
        % compare against each class
        argmax = 0;
        hmaxVal = 0;
        for k=1:10
            s = pY(i,k);
            if s > hmaxVal
                hmaxVal = s;
                argmax = k-1;
            end
        end
        if argmax == testy(i)
            connectness = connectness + 1;
        end
end
fprintf('correctness on au train:');
connectness = connectness/testSize

softThetaAu = theta;