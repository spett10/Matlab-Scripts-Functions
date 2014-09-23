%We want to solve the specific newton problem in Sauer 2.7.4
%This is not a general solution, but just for the specific problem

%Meaning, we calculate the jacobian and so forth specifically 
%not generally

%to call, example: newton5([1;1;1],2), where x0 is initial guess, k number of
%iterations

    function x=newton5(x0,k)
        x=x0;
           for i=1:k
               b=F(x);
               s=DF(x)\b; %rather than calculating the inverse for solving
                          %DF(x)s=F(x) with s=inv(DF(x))*F(x) we instead
                          %use the matrix division operator s=DF(x)\b, as
                          %advices by matlab in function-browser
               
               x=x-s;    %Since we are using the form of x_k+1 = x_k - s 
                         % for DF(x_k)s=F(x_k), this is how we find x_k+1
           end;
    end

    function y=F(x)   %We define our system of equations, so they can 
                      %be calculated for a given x_k
        y=zeros(3,1); %0 in a 3,1 matrix for our system of eq.
        y(1)=2.*x(1).^2-4.*x(1)+x(2).^2+3.*x(3).^2+6.*x(3)+2;
        y(2)=x(1).^2+x(2).^2-2.*x(2)+2.*x(3).^2-5;
        y(3)=3.*x(1).^2-12.*x(1)+x(2).^2+3.*x(3).^2+8;
    end

    function dy=DF(x) %Here we have the jacobian matrix, derived by hand 
                      %and inserted for iteration of x_k's 
        dy=zeros(3,3);
        dy(1,1)=4.*x(1)-4;
        dy(2,1)=2.*x(1);
        dy(3,1)=6.*x(1)-12;
        dy(1,2)=2.*x(2);
        dy(2,2)=2.*x(2)-2;
        dy(3,2)=2.*x(2);
        dy(1,3)=6.*x(3)+6;
        dy(2,3)=4.*x(3);
        dy(3,3)=6.*x(3);
    end 


%Our results do not converge for any guesses to the solutions :( 
