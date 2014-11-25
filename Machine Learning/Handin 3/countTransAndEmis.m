function [A,sigma,pi] = countTransAndEmis(states,genom,normalize)
%COUNTTRANSANDEMIS Givet vores states i en lang smørre,
% og tilhørende gen, kan vi teste emmision og transition vha. counting.
% returnerer A, transition matrix, sigma, emission prob. og pi, starthalløj
% ###output###
% A: K(states) x K(states) 
% sigma: K(states) x D(symboler)
% phi: K x 1
% ###input###
% states, a vector of our states ( a long ass vector..)
N = length(states);

% init trans with known trans
A = zeros(82,82);
A = setUpA(A);
% init sigma with know emis
sigma = zeros(82,4);
sigma = setUpSigma(sigma);

% init pi with know start
pi = zeros(82,1);
pi(1) = 1; % starter altid i state 1. 

prev = states(1);
%glemmer emission fra første state.
% 
 for i=2:N
     curr = states(i);
     
     %Transitions
     
     %check for ones
     if prev == 1
          A(prev,curr) = A(prev,curr)+1;
     %check for end of loop state (34)
     elseif prev == 34
          A(prev,curr) = A(prev,curr)+1;
     elseif prev == 55
          A(prev,curr) = A(prev,curr)+1;
     end
     
    
     %Emissions
     temp = fromCharToInt(genom(i));
     if curr == 1
         sigma(curr,temp) = sigma(curr,temp)+1;
     elseif curr == 32
         sigma(curr,temp) = sigma(curr,temp)+1;
     elseif curr == 33
         sigma(curr,temp) = sigma(curr,temp)+1;
     elseif curr == 34
         sigma(curr,temp) = sigma(curr,temp)+1;
     elseif curr == 53
         sigma(curr,temp) = sigma(curr,temp)+1;
     elseif curr == 54
         sigma(curr,temp) = sigma(curr,temp)+1;
     elseif curr == 55
         sigma(curr,temp) = sigma(curr,temp)+1;
     end
     prev = curr;
 end
 A(34,1) = 0;%dirthack

 if normalize > 0
 % Done counting, calc. average. But only in those we counted
 
 %get total transitions from ones
 %divide each entry with this  
 sumOnes = sum(A(1,:));
 A(1,:) = A(1,:)./sumOnes;
 
 sumThirtFour = sum(A(34,:));
 A(34,:) = A(34,:)./sumThirtFour;
 
 sumFifFive = sum(A(55,:));
 A(55,:) = A(55,:)./sumFifFive;
 
 %Do the same for sigma
 sumSigmaOnes = sum(sigma(1,:));
 sigma(1,:) = sigma(1,:)./sumSigmaOnes;
 
 sumSigma32 = sum(sigma(32,:));
 sigma(32,:) = sigma(32,:)./sumSigma32;
 sumSigma33 = sum(sigma(33,:));
 sigma(33,:) = sigma(33,:)./sumSigma33;
 sumSigma34 = sum(sigma(34,:));
 sigma(34,:) = sigma(34,:)./sumSigma34;
 
 
 sumSigma53 = sum(sigma(53,:));
 sigma(53,:) = sigma(53,:)./sumSigma53;
 sumSigma54 = sum(sigma(54,:));
 sigma(54,:) = sigma(54,:)./sumSigma54;
 sumSigma55 = sum(sigma(55,:));
 sigma(55,:) = sigma(55,:)./sumSigma55;
 
 
 
 
 end

end

function [int] = fromCharToInt(char)
    int = 0;
    if strcmp(char,'A')
       int = 1;
    elseif strcmp(char,'C')
        int = 2;
    elseif strcmp(char,'G')
        int = 3;
    elseif strcmp(char,'T')
        int = 4;
    end
end

function [A] = setUpA(A)
%we also need to assume every start is seen atleast once
startloop = 32;
for j=2:3:29
   A(1,j) = 1; %here we assume all starts are seen at least once
   A(j,j+1) = 1; %2->3.. etc
   A(j+1,j+2) = 1;%3->4
   A(j+2,startloop) = 1; %4->startloop
end
%between stop codons
for j=35:3:41
    A(j,j+1) = 1;
    A(j+1,j+2) = 1;
    A(j+2,1) = 1; %from last of stop codon to n state. 
end
%between loops
A(32,33) = 1;
A(33,34) = 1;



%%%do the same for R's
startloopR = 53;
%stopcodons R
for j=44:3:50
   A(1,j)=1; %all seen once
   A(j,j+1) = 1;
   A(j+1,j+2) = 1;
   A(j+2,startloopR) = 1;
end
%startcodons R
for j=56:3:80 
    A(j,j+1) = 1;
    A(j+1,j+2) = 1;
    A(j+2,1) = 1;
end
%between loops
A(53,54) = 1;
A(54,55) = 1;

end

function [sigma] = setUpSigma(sigma)
startCodonsC = ['ATG';'ATC';'ATA';'GTG';'ATT';'CTG';'GTT';'CTC';'TTA';'TTG'];
startStatesC = [2 3 4; 5 6 7; 8 9 10; 11 12 13; 14 15 16; 17 18 19; 20 21 22; 23 24 25; 26 27 28; 29 30 31];
stopCodonsC = ['TAG';'TGA';'TAA'];
stopStatesC = [ 38 39 40; 41 42 43; 35 36 37];


startCodonsR = ['TAT';'ATG';'GAT';'CAT';'AAT';'TAC';'CAC';'CAA';'CAG'];
startStatesR = [56 57 58; 59 60 61; 62 63 64; 65 66 67; 68 69 70; 71 72 73; 74 75 76; 77 78 79; 80 81 82];
stopCodonsR = ['TTA';'CTA';'TCA'];
stopStatesR = [44 45 46; 47 48 49; 50 51 52];

%for hver start state, aflæs hvad emission er
for i=1:length(startStatesC)
    tempState = startStatesC(i,:);
    for j=1:3
        sigma(tempState(j),fromCharToInt(startCodonsC(i,j))) = 1;
    end
end

%for hver stop state, gør det samme
for i=1:length(stopStatesC)
    tempState = stopStatesC(i,:);
    for j=1:3
        sigma(tempState(j),fromCharToInt(stopCodonsC(i,j))) = 1;
    end
end


%gør det samme for R'er
for i=1:length(startStatesR)
   tempState = startStatesR(i,:); 
   for j=1:3
       sigma(tempState(j),fromCharToInt(startCodonsR(i,j))) = 1;
   end
end

for i=1:length(stopStatesR)
    tempState = stopStatesR(i,:);
    for j=1:3
        sigma(tempState(j),fromCharToInt(stopCodonsR(i,j))) = 1;
    end

end
end