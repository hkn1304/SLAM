function [xPresent_post, covPresent_post] = ExKalFilt2(xPast_post, covPast_post, u_Present, z_Present)
% gFunc: Dynamic model-state transition matrix 
% hFunc: Observation model- measurement function
% R_t  : Dynamical model Gaussian noise covariance
% Q_t  : Observation model Gaussian noise covariance


% Dimensions
% n=3;
% m=3;
% 
% x_t= n x 1
% covPresent_post, covPresent_prior , R_t = n x n
% z_t= m x 1
% C= m x n
% Q_t= m x m
% u_t= c x 1
% B= n x c
% K_t= n x m

muR_t=zeros(3,3);
sigmaR_t=[0.01   0     0 ;...
           0    0.01   0; ...
           0     0     10000]; 
R_t = normrnd(muR_t,sigmaR_t)

muQ_t=zeros(3,3);
sigmaQ_t=[0.01 0 0 ;0 0 0; 0 0 0];
Q_t = normrnd(muQ_t,sigmaQ_t)

% Dynamical Model
syms x y theta
d=1;
 
 syms xPast_post1 xPast_post2 xPast_post3
gFunc= [xPast_post1+d* cosd(xPast_post3);...% g1= X'
        xPast_post2+d* sind(xPast_post3);... % g2= Y'
            xPast_post3]  % - 3x1

%Calculate G_t; Jacobian matrix of gFunc
Gg=jacobian(gFunc,[xPast_post1,xPast_post2,xPast_post3])
G_t= double(subs(Gg,[xPast_post1,xPast_post2,xPast_post3],{xPast_post(1), xPast_post(2), xPast_post(3)}))

%% Prediction Step
%   Step I: Compute State prediction
xPresent_prior=transpose(double(subs(gFunc,[xPast_post1,xPast_post2,xPast_post3],{xPast_post(1), xPast_post(2), xPast_post(3)}))) % 3x1
%   Step II: Compute Covariance prediction
covPresent_prior= G_t * covPast_post * (G_t)' + R_t ; % - 3x3 * 3x3  * 3x3 + 3x3 = 3x3

% Observation Model
  H = [ 1 0 0;
        0 1 0;
        0 0 1];

x_t=xPresent_prior(1) ; y_t=xPresent_prior(2) ; theta=xPresent_prior(3)  ; x_s=xPast_post(1) ; y_s=xPast_post(2) ;
hFuncVal= [sqrt((x_t-x_s)^2+(y_t-y_s)^2)*cosd(theta),sqrt((x_t-x_s)^2+(y_t-y_s)^2)*sind(theta) ,atand((y_s-y_t)/(x_s-x_t)-theta)] % Observation model - 3x1

H_tVal= [x_t/sqrt(x_t^2+y_t^2)     y_t/sqrt(x_t^2+y_t^2)   -sind(theta); ...
         x_t/sqrt(x_t^2+y_t^2)     y_t/sqrt(x_t^2+y_t^2)   cosd(theta);...
        -y_t/(x_t^2+y_t^2)        x_t/(x_t^2+y_t^2)     0] % mxn - 3x3

%% Correction Step
%   Step III: Compute Kalman gain (K_t)
K_t= covPresent_prior * (H_tVal)' * inv(H_tVal * covPresent_prior * (H_tVal)' + Q_t) % 3x3 * 3x3 * inv( 2x3 * 3x3 * 3x3 + 3x3) = 3x3
%   Step IV:  Compute State Estimate
xPresent_post= double(xPresent_prior') + K_t * (z_Present - H * xPresent_prior')
%   Step V:   Compute Covariance Estimate
covPresent_post= (eye(3) - K_t * H_tVal) * covPresent_prior % ( 3x3 - 3x3 * 3x3) * 3x3 = 3x3 

end