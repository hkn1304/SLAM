clear all
clc
% Dimensions
% n=3;
% m=2;
% 
% x_t= n x 1
% covPresent_post, covPresent_prior , R_t = n x n
% z_t= m x 1
% C= m x n
% Q_t= m x m
% u_t= c x 1
% B= n x c
% K_t= n x m

xPresent_post  =[0 0 0];
covPresent_post=[0.01   0     0 ;...
                  0    0.01   0; ...
                  0     0     10000]; 

xPast_post = xPresent_post;
covPast_post= covPresent_post;

u_Present=[];
for t = 1:10
   
  [xm, ym, theta] = RobotPose(t);              % real value
  [xPresent_post, covPresent_post] = ExKalFilt(xPast_post, covPast_post, u_Present , [xm , ym, theta]')
  xh = double(xPresent_post(1))
  yh = double(xPresent_post(2))
  thetah = double(xPresent_post(3))
  
  xPast_post = double(xPresent_post)';
  covPast_post= covPresent_post;
%   hold on
%   plot(xm, ym, 'r')
%   plot(xh, yh, 'b')
  
  %pause(1)
    Xmsaved(t,:) = [xm, ym, theta];
    Xhsaved(t,:) = [xh, yh, thetah];

end


figure (1)
plot(t,Xmsaved(:,1),'r','linewidth',4)    % x value (real)
hold on
plot(t,Xhsaved(:,1),'b','linewidth',4)  % x value (estimation)
xlabel('time', 'FontSize', 24);
ylabel('x values', 'FontSize', 24);
legend('"x" position','"x" estimation')
set(gca,'FontSize',24,'fontWeight','bold')
grid
% 
figure (2)
plot(t,Xmsaved(:,2),'r','linewidth',4)    % y value (real)
hold on
plot(t,Xhsaved(:,2),'b','linewidth',4)  % y value (estimation)
xlabel('time', 'FontSize', 24);
ylabel('y values', 'FontSize', 24);
legend('"y" position','"y" estimation')
set(gca,'FontSize',24,'fontWeight','bold')
grid
%
figure (3)
plot(t,Xmsaved(:,3),'r.','linewidth',4)   % theta value (real)
hold on
plot(t,Xhsaved(:,3),'b.','linewidth',4)   % theta value (estimation)
xlabel('time', 'FontSize', 24);
ylabel('theta values', 'FontSize', 24);
legend('"theta" position','"theta" estimation')
set(gca,'FontSize',24,'fontWeight','bold')
grid
%
figure (4)
plot(Xmsaved(:,1),Xmsaved(:,2),'r.','linewidth',4)    % real values in x,y direction
hold on
plot(Xhsaved(:,1),Xhsaved(:,2),'b.','linewidth',4)% estimation values in x,y direction
xlabel('x values', 'FontSize', 24);
ylabel('y values', 'FontSize', 24);
legend('real orbit','estimation orbit')
set(gca,'FontSize',24,'fontWeight','bold')
grid