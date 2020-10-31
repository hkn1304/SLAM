clear axes;
hold off;
x=r
y=0
theta=0
w=pi
dt=0.1
xy = [zeros(3,1)] % this is the start point

for i=1:step_number
% state variables at time t
xprime=r*cos(xy(3)+((i-1)*2*pi/step_number))%(2*pi-i)
yprime=r*sin(xy(3)+((i-1)*2*pi/step_number))%(2*pi-i)
thetaprime=xy(3)+((i-1)*2*pi/step_number)

xbar=xy(1)
ybar=xy(2)
thetabar=xy(3)
% As known we need to sensor inputs but we do not have real sensors so we
% must calculate our own datas for everystep as sensor (real values)
% This gives (x,y,theta) respectively for every step "s"
% with every sample "k"
% xy is our odometry result that we use for posterior step
xbarprime = xbar - r*sin(thetabar)+r*sin(thetabar+w*dt);
ybarprime = ybar + r*cos(thetabar)-r*cos(thetabar+w*dt);
thetabarprime = thetabar + w*dt;
% for now xy_s is for t and xy is for t-1
drot1  = atan2(ybarprime-ybar,xbarprime-xbar)-thetabar;%Line2 of Algorithm
dtrans = sqrt((xbar-xbarprime)^2+(ybar-ybarprime)^2);
drot2  = thetabarprime-thetabar-drot1;
% 
% delta_trans= sqrt((xbar_prime-xbar)^2+(ybar_prime-ybar)^2)
% delta_rot1= atan2(ybar_prime-ybar,xbar_prime-xbar)-thetabar
% delta_rot2=thetabar_prime-thetabar-delta_rot1

delta_hat_trans= sqrt((xprime-x)^2+(yprime-y)^2)
delta_hat_rot1= atan2(yprime-y,xprime-x)-thetabar
delta_hat_rot2=thetaprime-theta-delta_hat_rot1



p1   = alpha1* abs(delta_hat_rot1) + alpha2* abs(delta_hat_trans)
p2   = alpha3* delta_hat_trans + alpha4* (abs(delta_hat_rot1)+abs(delta_hat_rot2))
p3   = alpha1 *abs(delta_hat_rot2) + alpha2* abs(delta_hat_trans)

p= mvnpdf(drot1-delta_hat_rot1,0,p1) * mvnpdf(dtrans-delta_hat_trans,0, p2) * mvnpdf(drot2-delta_hat_rot2,0,p3)


%Probability = p1*p2*p3
xy(1)=xprime
xy(2)=yprime
xy(3)=thetaprime
%v=vhat
%omega=omegahat

scatter(xy(1),xy(2),20,'filled')
hold on
end

% 
% function pdf = distr_tria(mu,sigma)
% pd=makedist('Triangular')
% 
% 
% 
% end
% 
% function pdf = distr_norm(mu,sigma)
% pdf=mvnrnd(mu, sigma)
% 
% end