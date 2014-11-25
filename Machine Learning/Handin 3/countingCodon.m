function [countedStarts, countedStops] = countingCodon(string1,string2,printing)
%COUNTINGCODON Counting Codons and transitions, given
% X(emmisions) string1,  and Z(transitions) string 2
% 10 possible start codons: ATG, ATC, ATA, GTG, ATT, CTG, GTT, CTC, TTA, TTG
startcodon = 'NCCC';
stopcodon = 'CCCN';

startCodons = ['ATG';'ATC';'ATA';'GTG';'ATT';'CTG';'GTT';'CTC';'TTA';'TTG'];
stopCodons = ['TAG';'TGA';'TAA'];

countedStarts = zeros(length(startCodons),1);
countedStops = zeros(length(stopCodons),1);

N = length(string1(1,:));
if N ~= length(string2(1,:))
   error('strings must be equal length') 
end

for i=1:N-3
   %look at 4 characters at a time 
   temp2 = string2(1,i:i+3); % the N,C,R string
   %check if start codon
   if strcmp(temp2,startcodon)
       % if startcodon, which one? update vector of startcodons
       temp1 = string1(1,i+1:i+3);
       countedStarts = checkStartCodon(temp1,countedStarts,startCodons);
   
   elseif strcmp(temp2,stopcodon)
       temp1 = string1(1,i:i+2);
       countedStops = checkStopCodon(temp1,countedStops,stopCodons);
   
   end
end


if(printing > 0)
    % Report findings
    fprintf('start codons in gene:\n')
    fprintf('ATG: %d\n',countedStarts(1))
    fprintf('ATC: %d\n',countedStarts(2))
    fprintf('ATA: %d\n',countedStarts(3))
    fprintf('GTG: %d\n',countedStarts(4))
    fprintf('ATT: %d\n',countedStarts(5))
    fprintf('CTG: %d\n',countedStarts(6))
    fprintf('GTT: %d\n',countedStarts(7))
    fprintf('CTC: %d\n',countedStarts(8))
    fprintf('TTA: %d\n',countedStarts(9))
    fprintf('TTG: %d\n',countedStarts(10))

    fprintf('stop codons in gene:\n')
    fprintf('TAG: %d\n',countedStops(1))
    fprintf('TGA: %d\n',countedStops(2))
    fprintf('TAA: %d\n',countedStops(3))
end

end

function [codon] = checkStartCodon(string,codon,startcodons)
    for j=1:length(startcodons)
        if strcmp(string,startcodons(j,:))
           codon(j) = codon(j) + 1;
        end
    end
end

function [codon] = checkStopCodon(string,codon,stopcodons)
    for j=1:length(stopcodons)
        if strcmp(string,stopcodons(j,:))
           codon(j) = codon(j) + 1; 
        end
    end
end