function [path] = Viterbi(obs,A,B,pi)
%VITERBI observations, map to annotation, using A,sigma,pi
% A is transition matrix, B is emission, pi is start. 
K = length(B(:,1));
N = length(obs);
%states = zeros(N,1);
V = zeros(K,N);
% P = zeros(K,N); %to store path

%precompute first V
%for s=1:K
%V(s,1) = pi(s)*B(s,fromCharToInt(obs(1)));
%end
V(1,1) = log(pi(1))+log(B(1,fromCharToInt(obs(1))));
for q=2:K
   V(q,1) = log(0); 
end

for i=2:N %for each observation
   for s=1:K %consider each state
       X = zeros(K,1);
       for x=1:K
          X(x) = log(0);  %repr of 0 is -inf
       end
       %get prob of having been in each previous step
       % mult by the prob of transitioning to the current step.
       for x=1:K
          X(x) = V(x,i-1) + log(A(x,s));  %should A be turned this way?
          
       end
       [a, b] = max(X);
       V(s,i) = a+log(B(s,fromCharToInt(obs(i))));%this fucks it
       %P(s,i) = b;
   end
end

% Make the path with backtracking
% path = zeros(N,1);
% [a, b] = max(V(:,N));
% path(N) = P(b,N);
% for i=N-1:-1:1
%    [a, b] = max(V(:,i));
%    path(i) = P(b,i); 
% end

path = zeros(N,1);
[a, b] = max(V(K,N));
path(N) = b;
for i=N-1:-1:1
    temp = log(B(path(i+1),fromCharToInt(obs(i+1)))) + V(:,i) + log(A(:,path(i+1)));
    [a,b] = max(temp);
    path(i) = b;
end

% Translate form our states to a path of characters (ascii). 
for i=1:N
    path(i) = fromStateToChar(path(i));
end

% go from ascii to actual chars
path = char(path);
path = path';

end

function [char] = fromStateToChar(state)
    if state == 1 || state == 0
        char = 'N';
    elseif state ~= 1 && state < 44
       char = 'C';
    elseif state ~= 1 && state > 43
        char = 'R';
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