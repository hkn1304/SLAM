clear all;
clc;

xPresent_post  =[0; 0; 0];
covPresent_post=[0.01   0     0 ;...
                  0    0.01   0; ...
                  0     0     10000]; 

xbarPast_post = xPresent_post;
covPast_post= covPresent_post;

u_t=[];

time=0:1:1000;
Nsamples=length(time);
Xmsaved=[];
Xhsaved=[];

for t = 1:Nsamples
   
  [xm, ym, theta] = f_GetPosUK(t);              % real value
  [xh, yh, thetah,xbarPresent_post,CovPresent_post] = UnKalFilt_hkn3(covPast_post,xbarPast_post, u_t, [xm; ym; theta]) % kalman result
  
  covPast_post= CovPresent_post
  xbarPast_post = xbarPresent_post
  Xmsaved(t,:) = [xm, ym, theta];
  Xhsaved(t,:) = [xh, yh, thetah];
  
end
% Elipsoid
Pxyt=CovPresent_post;
figure (5)
h=f_error_ellipse_drawing(Pxyt,xbarPresent_post)
% x-y
Pxy=[CovPresent_post(1,1) CovPresent_post(1,2);
     CovPresent_post(2,1) CovPresent_post(2,2)];
figure (6)
h=f_error_ellipse_drawing(Pxy,xbarPresent_post)
% x-t
Pxt=[CovPresent_post(1,1) CovPresent_post(1,3);
     CovPresent_post(3,1) CovPresent_post(3,3)];
figure (7)
h=f_error_ellipse_drawing(Pxt,xbarPresent_post)
% y-t
Pyt=[CovPresent_post(2,2) CovPresent_post(2,3);
     CovPresent_post(3,2) CovPresent_post(3,3)];
figure (8)
h=f_error_ellipse_drawing(Pyt,xbarPresent_post)
%
figure (1)
plot(time,Xmsaved(:,1),'r','linewidth',4)    % x value (real)
hold on
plot(time,Xhsaved(:,1),'b','linewidth',4)  % x value (estimation)
xlabel('time', 'FontSize', 24);
ylabel('x values', 'FontSize', 24);
legend('"x" position','"x" estimation')
set(gca,'FontSize',24,'fontWeight','bold')
grid
% 
figure (2)
plot(time,Xmsaved(:,2),'r','linewidth',4)    % y value (real)
hold on
plot(time,Xhsaved(:,2),'b','linewidth',4)  % y value (estimation)
xlabel('time', 'FontSize', 24);
ylabel('y values', 'FontSize', 24);
legend('"y" position','"y" estimation')
set(gca,'FontSize',24,'fontWeight','bold')
grid
%
figure (3)
plot(time,Xmsaved(:,3),'r.','linewidth',4)   % theta value (real)
hold on
plot(time,Xhsaved(:,3),'b.','linewidth',4)   % theta value (estimation)
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