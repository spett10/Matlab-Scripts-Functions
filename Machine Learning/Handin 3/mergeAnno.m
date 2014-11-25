function [newanno] = mergeAnno(anno1,anno2)
%MERGEANNO merge two annotation, one from left and one from right
% Heuristic: C is more important than R!
N = length(anno1(1,:));
K = length(anno2(1,:));

if N ~= K
    error('lenght of annotations must be equal');
end
    
newanno = '';

for i=1:N
    newanno(i) = chooseChar(anno1(i),anno2(i));
end

end

function [char] = chooseChar(char1,char2)
    char = 'N';
    if strcmp(char1,char2)
       char = char1; 
    elseif strcmp(char1,'C') || strcmp(char2,'C')
        char = 'C';
    elseif strcmp(char1,'R') || strcmp(char2,'R')
        char = 'R';
    end
end
