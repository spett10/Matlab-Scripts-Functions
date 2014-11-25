function [States] = fromAnnoToStates(geno,anno)
%FROMANNOTOSTATES given NNNNNNCCC... map it to states in our model
% so we can use counting to set up parameters 

N = length(geno(1,:));
%invariant der fortæller os om vi koder eller ej.
coding = 0; % vi starter altid som non-coding

States = ones(N,1);
startCodonsC = ['ATG';'ATC';'ATA';'GTG';'ATT';'CTG';'GTT';'CTC';'TTA';'TTG'];
startStatesC = [2 3 4; 5 6 7; 8 9 10; 11 12 13; 14 15 16; 17 18 19; 20 21 22; 23 24 25; 26 27 28; 29 30 31];
stopCodonsC = ['TAG';'TGA';'TAA'];
stopStatesC = [ 38 39 40; 41 42 43; 35 36 37];
loopStatesC = [ 32 33 34 ];

startCodonsR = ['TAT';'ATG';'GAT';'CAT';'AAT';'TAC';'CAC';'CAA';'CAG'];
startStatesR = [56 57 58; 59 60 61; 62 63 64; 65 66 67; 68 69 70; 71 72 73; 74 75 76; 77 78 79; 80 81 82];
stopCodonsR = ['TTA';'CTA';'TCA'];
stopStatesR = [44 45 46; 47 48 49; 50 51 52];
loopStateR = [53 54 55];



i=1;
while i<N
    %kig først på 4, for at se om CCCN
    len = N-i;
    if len > 3
        tempstr4 = anno(1,i:i+3);
    else
        tempstr4 = '';
    end
    %men ellers kigger vi på 3
    if len > 2
        tempstr = anno(1,i:i+2);
    else
        tempstr = '';
    end
        
    if strcmp(tempstr4,'CCCN') %stopcodon C!
        [a,b,c] = checkGenoStop(geno(1,i:i+2),stopCodonsC,stopStatesC); %check hvilken 
        States(i) = a;
        States(i+1) = b;
        States(i+2) = c;
        coding = 0;
        i = i+3;
    
    elseif strcmp(tempstr4,'RRRN') %startcodon R
        [a,b,c] = checkGenoStart(geno(1,i:i+2),startCodonsR,startStatesR);
        States(i) = a;
        States(i+1) = b;
        States(i+2) = c;
        coding = 0;
        i = i+3;
    elseif strcmp(tempstr,'CCC')
        if coding < 1 %& false %hvis vi kom fra ikke kodning, ved vi det start tag
        [a,b,c] = checkGenoStart(geno(1,i:i+2),startCodonsC,startStatesC); % check hvilken
        States(i) = a;
        States(i+1) = b;
        States(i+2) = c;    
        else %ellers ved vi at vi bare looper i kodning, state 32 33 34
        States(i) = loopStatesC(1,1);
        States(i+1) = loopStatesC(1,2);
        States(i+2) = loopStatesC(1,3);    
        end
        coding = 1;
        i = i+3;
    
    elseif strcmp(tempstr,'RRR')
        if coding < 1 %hvis der står RRR og vi kom fra ikke kodende, er det et stop codon den anden vej
        [a,b,c] = checkGenoStop(geno(1,i:i+2),stopCodonsR,stopStatesR);
        States(i) = a;
        States(i+1) = b;
        States(i+2) = c;    
        else % eller looper vi i R kodning, state 53 54 55
        States(i) = loopStateR(1,1);
        States(i+1) = loopStateR(1,2);
        States(i+2) = loopStateR(1,3);    
        end
        coding = 1;
        i = i+3;
    else %N
        coding = 0;
        %States(i) = 1; %er sat til 1 fra starten af 
        i = i+1;
    end
end

end
function [a, b, c] = checkGenoStop(string,stopCodons,stopStates)
   %if we dont recognize, just start by setting to most likely..
   %otherwise, matlab bitches
    a = stopStates(3,1);
    b = stopStates(3,2);
    c = stopStates(3,3);
    for j=1:length(stopCodons)
        if strcmp(string,stopCodons(j,:))
           a = stopStates(j,1);
           b = stopStates(j,2);
           c = stopStates(j,3);
           break;
        end
    end
end

function [a, b, c] = checkGenoStart(string,startCodons,startStates)
    %if we dont recognize, just start by setting to most likely..
    a = startStates(1,1);
    b = startStates(1,2);
    c = startStates(1,3);
    for j=1:length(startCodons)
       if strcmp(string,startCodons(j,:))
           a = startStates(j,1);
           b = startStates(j,2);
           c = startStates(j,3);
           break;
        end
    end
end