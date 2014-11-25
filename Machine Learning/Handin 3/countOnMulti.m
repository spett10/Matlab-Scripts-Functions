function [A,sigma,pi,prob] = countOnMulti(leaveOneOut)
%COUNTONMULTI calls the counting function on all but leaveOneOut
%   returns transition matrix, emission prob, and start pi,
% as well as sum of respective probabilites for all. prob should
% thus be a matrix of 1's, else something went wrong. 


A = zeros(82,82);
sigma = zeros(82,4);
pi = zeros(82,1);
pi(1,1) = 1;

%calc sum of all rows, all prob should sum to one
prob = zeros(82,2);



%load the states
load('XZ.mat');

load('state1both.mat');
load('state2both.mat');
load('state3both.mat');
load('state4both.mat');
load('state5both.mat');


%leave one out for cross val. Call on the remaining four. 
% calling with 0 as 3rd arg, so the count func doesnt normalize
% like it usually does
if leaveOneOut ~= 1
[a, b] = countTransAndEmis(state1both,genomes.genome1,0);
A = A+a;
sigma = sigma+b;
end
if leaveOneOut ~= 2
[a, b] = countTransAndEmis(state2both,genomes.genome2,0);
A = A+a;
sigma = sigma+b;
end
if leaveOneOut ~= 3
[a, b] = countTransAndEmis(state3both,genomes.genome3,0);
A = A+a;
sigma = sigma+b;
end
if leaveOneOut ~= 4
[a, b] = countTransAndEmis(state4both,genomes.genome4,0);
A = A+a;
sigma = sigma+b;
end
if leaveOneOut ~=5
[a, b] = countTransAndEmis(state5both,genomes.genome5,0);
A = A+a;
sigma = sigma+b;
end

%normalize
% we have to normalize the fixed states as well, since they've been
% four doubled, and then the specific states we counted ourselves.

%we have to act as though we've seen one of at least everything!

sizeA = size(A,1);
sizeSigma = size(sigma,1);

%normalize A
for i=1:sizeA
    tempSum = sum(A(i,:));
    A(i,:) = A(i,:)./tempSum;
end

%normalize sigma
for j=1:sizeSigma
    tempSum = sum(sigma(j,:));
    sigma(j,:) = sigma(j,:)./tempSum;
end

%calc sum of prob, should be 1!! for all 
for i=1:sizeA
   tempProb = sum(A(i,:));
   prob(i,1) = tempProb;
end

for j=1:sizeSigma
   tempProb = sum(sigma(j,:));
   prob(j,2) = tempProb;
end


end

