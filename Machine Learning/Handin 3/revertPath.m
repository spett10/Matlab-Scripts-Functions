function [newpath] = revertPath(path)
%REVERTPATH reverts the path. 
N = length(path(1,:));

newpath = '';
for i=1:N
    newpath(i) = path(N-i+1);
end

end

