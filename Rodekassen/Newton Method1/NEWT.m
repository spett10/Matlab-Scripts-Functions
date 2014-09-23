% Computer problem 2.7.1 a
% x0 startgæt, k antal iterationer
% kald fx. NEWT([1;1],2)


function x=NEWT(x0,k)
x=x0;
    for i=1:k
        b=F(x);
        s=DF(x)\b;
        x=x-s;
    end;
end
    
function y=F(x)
    y=zeros(2,1); % 0-punkter i 2x1 matrix
    y(1)=x(1)^2+x(2)^2-1;
    y(2)=(x(1)-1)^2+x(2)^2-1;

end

function dy=DF(x)
    dy=zeros(2,2);
    dy(1,1)=2*x(1);
    dy(1,2)=2*x(2);
    dy(2,1)=2*(x(1)-1);
    dy(2,2)=2*x(2);
end

        
    
