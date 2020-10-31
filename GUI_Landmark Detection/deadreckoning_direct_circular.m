clear axes;
hold off;
%  clc;
%  clear all;
%  alpha1 = 0.8; alpha2 = 0.5; alpha3 = 0.3; 
%  alpha4 = 0.6; alpha5 = 0.4; alpha6 = 0.7; 

 dt=0.1
% r=10
% step=8

% state variables at time t-1
x=r
y=0
theta=0
v=1
omega=1

for i=1:step_number
% state variables at time t
xprime=r*cos(theta+(2*pi/step_number))%(2*pi-i)
yprime=r*sin(theta+(2*pi/step_number))%(2*pi-i)
thetaprime=theta+(2*pi/step_number)
% control at time t


mu= 0.5 * ( (x-xprime)*cos(theta) + (y-yprime)*sin(theta) / ...
            (y-yprime)*cos(theta) + (x-xprime)*sin(theta) )
    
xstar= 0.5*(x+xprime) + mu*(y-yprime)
ystar= 0.5*(y+yprime) + mu*(xprime-x)
rstar= sqrt( (x-xstar)^2 + (y-ystar)^2 )

dtheta= atan2(yprime-ystar, xprime-xstar) - atan2(y-ystar, x-xstar)

vhat=(dtheta/dt)*rstar
omegahat=dtheta/dt
gammahat= (thetaprime-theta)/dt - omegahat

% noise variances
% sv       = alpha1* v^2 + alpha2* omega^2
% somega   = alpha3* v^2 + alpha4* omega^2
% sgamma   = alpha5 *v^2 + alpha6* omega^2
% 
sv       = alpha1* abs(v) + alpha2* abs(omega)
somega   = alpha3* abs(v) + alpha4* abs(omega)
sgamma   = alpha5 *abs(v) + alpha6* abs(omega)

p= mvnpdf(v-vhat,0,sv) * mvnpdf(omega-omegahat,0, somega) * mvnpdf(gammahat,0,sgamma)

x=xprime
y=yprime
theta=thetaprime
%v=vhat
%omega=omegahat

scatter(xprime,yprime,20,'filled')
hold on
end