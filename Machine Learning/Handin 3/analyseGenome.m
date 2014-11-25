function [starts, stops] = analyseGenome(genomes)
%SANALYSEGENOMES calls the helper functions to analyse the genes!
%only usable on genes where we know X and Z (we know observables and 
%corresponding latent values)

%FIRST we call countingCodon on all 5 genomes to get total number of
%all start and stop tags. 

% Jeg var træt, så nedenstående blev simpelt og grimt.
[temp1, temp2] = countingCodon(genomes.genome1,genomes.anno1,0);
starts = temp1;
stops = temp2;
[temp1, temp2] = countingCodon(genomes.genome2,genomes.anno2,0);
starts = starts + temp1;
stops = stops + temp2;
[temp1, temp2] = countingCodon(genomes.genome3,genomes.anno3,0);
starts = starts + temp1;
stops = stops + temp2;
[temp1, temp2] = countingCodon(genomes.genome4,genomes.anno4,0);
starts = starts + temp1;
stops = stops + temp2;
[temp1, temp2] = countingCodon(genomes.genome5,genomes.anno5,0);
starts = starts + temp1;
stops = stops + temp2;

totalCodings = sum(starts);
totalStops = sum(stops);
    % Report findings
    fprintf('start codons in gene:\n')
    fprintf('ATG: %d \\ %d\n',starts(1),totalCodings)
    fprintf('ATC: %d \\ %d\n',starts(2),totalCodings)
    fprintf('ATA: %d \\ %d\n',starts(3),totalCodings)
    fprintf('GTG: %d \\ %d\n',starts(4),totalCodings)
    fprintf('ATT: %d \\ %d\n',starts(5),totalCodings)
    fprintf('CTG: %d \\ %d\n',starts(6),totalCodings)
    fprintf('GTT: %d \\ %d\n',starts(7),totalCodings)
    fprintf('CTC: %d \\ %d\n',starts(8),totalCodings)
    fprintf('TTA: %d \\ %d\n',starts(9),totalCodings)
    fprintf('TTG: %d \\ %d\n',starts(10),totalCodings)

    fprintf('stop codons in gene:\n')
    fprintf('TAG: %d \\ %d\n',stops(1),totalStops)
    fprintf('TGA: %d \\ %d\n',stops(2),totalStops)
    fprintf('TAA: %d \\ %d\n',stops(3),totalStops)

end


