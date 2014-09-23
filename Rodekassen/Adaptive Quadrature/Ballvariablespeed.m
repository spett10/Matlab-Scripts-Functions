set(gca, 'XLim',[-2 2],'YLim',[-2 2],'Drawmode','fast','Visible','on');
cla
axis square
s=0:0.01:1; %we define s as what our plot must iterate over
plot(0.5+0.3*s+3.9*s.^2-4.7*s.^3, 1.5+0.3*s+0.9*s.^2-2.7*s.^3) %plot the path
ball=line('color','r','Marker','o','MarkerSize',10,'LineWidth',2,'erase','xor','xdata',[],'ydata',[]);
%define our ball as in the book
t=0:0.05:20; %we define values for our t, so we can compute x and y values
x=0.5+0.3*t+3.9*t.^2-4.7*t.^3; %computes x values
y=1.5+0.3*t+0.9*t.^2-2.7*t.^3; %computes y values
filename='activity5.gif'; %We need a file so we can write the different 
                          % graphics of plots of our pall to a file, 
                          % using imwrite 

for i = 0:20              %Our for loop to construct different plot for ball              
    set(ball, 'xdata',x(i+1), 'ydata',y(i+1));
    drawnow;
    pause(0.01);
    frame=getframe(1); %a snapshot of the current frame / axes
    im=frame2im(frame); %creates movie frame together with "getframe" above
    [imind,cm]=rgb2ind(im,256); %Converts RGB images to indexed images
    if i + 1 == 1; %our starting step
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else           %the other iterations
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end

