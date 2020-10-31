function [xh,yh,thetah,xbarPresent_post, CovPresent_post] = UnKalFilt_hkn3(covPast_post,xbarPast_post, u_t, z_t)

%% %%PARAMETER DEFINITION
n=3;
m=3;
dt=0.01;
z = [z_t(1); z_t(2); z_t(3)] ;  % 3x1
theta=z_t(3)

alpha=1; % 0<alpha<1
kappa=1; % kappa=>0
lambda= alpha^2*(kappa+n)-n;
beta=2;

H = [1 0 0;
       0 1 0;
        0 0 1];
Q_t = 1.0*eye(3);
R_t = 1.0*eye(3);

%% %%PREDICTION STEP
% 1. Generate Sigma points
%%2. Propagate each sigma-point through prediction
%XSigmaPresent_prior=eval( g(XSigmaPast_post)) % nx(2*n+1)--> 3x7
[XSigmaPresent_prior]= SigPointGen(n, lambda, xbarPast_post, covPast_post, theta, dt)

% 3. Compute Mean and Covariance matrix
% Weight for computing the Mean
Wsigma_mean(1) = lambda/(n+lambda)
% Weight for computing the Covariance
Wsigma_cov(1) = ( lambda/(n+lambda) ) +1- alpha^2 +beta

for i=1:(2*n)
Wsigma_mean(i+1) = 1/( 2*(n+lambda) ) % 1<k<2n  In total- [1x(2*n+1)] : 1x7

Wsigma_cov(i+1) = 1/( 2*(n+lambda) ) % 1<k<2n   In total- [1x(2*n+1)] : 1x7
end

[xbarPresent_prior, CovPresent_prior]= UnsTrans( XSigmaPresent_prior, Wsigma_mean, Wsigma_cov, R_t)
% % % Calculate mean of predicted state
% % xbarPresent_prior=0;
% % for i=1:(2*n+1)
% % xbarPresent_prior= xbarPresent_prior + Wsigma_mean(i) * XSigmaPresent_prior(:,i) % [nx(2*n+1)] :3x7 * ([1x(2*n+1)] : 1x7)' = [nx1] :3x1
% % end
% % % Calculate covariance of predicted state
% % CovPresent_prior=0;
% % for i=1:(2*n+1)
% % CovPresent_prior= CovPresent_prior + Wsigma_cov(i)* ( XSigmaPresent_prior(:,i) - xbarPresent_prior ) * ( XSigmaPresent_prior(:,i) - xbarPresent_prior )' + R_t % 1 * ( [nx1]: 3x1 - 3x1) * ( [nx1]:3x1 -3x1)' + [n,n]:3x3
% % end
%%%Thus we get 3x1 xbarPresent_prior and 3x3 CovPresent_prior
%% %% CORRECTION STEP
HSigmaPresent_prior=zeros(n,2*n+1)
HSigmaPresent_prior(:,1)= xbarPresent_prior

MSRpresent =chol( (n+lambda)*CovPresent_prior )  % chol: To Calculate square root of error covariance
% Calculate mean of estimated output
for i=1:n
HSigmaPresent_prior(:,i+1)= xbarPresent_prior + ( MSRpresent(i,:)'  ) 
HSigmaPresent_prior(:,n+i+1)= xbarPresent_prior - ( MSRpresent(i,:)'  ) 
end

% [HSigmaPresent_prior]= SigPointGen(n, lambda, xbarPresent_prior, CovPresent_prior)
%Measurement Model
%h(x,y)=(y,y*sin( (x^2+y^2)/(1+x*y) )

% 5. Propogate Sigma points to obtain prediction of the observation
%Zet_t_k = eval( h(XSigmaPresent_prior))

Zet_t_k=zeros(m, 2*n+1);
for k=1:2*n+1
    Zet_t_k(:,k)=hx(HSigmaPresent_prior(:,k),theta) % Zet_t_k is the transformed sigma points
end

% 6. Compute estimated observation and covariance matrix

% % zbar_t=0;
% % for i=1:(2*n+1)
% % zbar_t= zbar_t + Wsigma_mean(i) * Zet_t_k(:,i) % [nx(2*n+1)] :3x7 * ([1x(2*n+1)] : 1x7)' = [nx1] :3x1 !!!!!
% % end
% % 
% % for i=1:(2*n+1)
% % % 7. Compute 
% % S_t= Wsigma_cov(i) * ( Zet_t_k(:,i) - z_t ) * ( Zet_t_k(:,i) - z_t )' + Q_t % [nxn]:3x3
% % end
% % 

[zbar_t, S_t]= UnsTrans( Zet_t_k, Wsigma_mean, Wsigma_cov, Q_t)

% 8. Compute
CrossCovar=zeros(n,m);
% PyyCrossCovar=zeros(n,m);
% PxyCrossCovar=zeros(n,m);
for i=1:2*n+1
%CrossCovar= CrossCovar+ Wsigma_cov(i) * ( XSigmaPresent_prior(:,i) - xbarPresent_prior ) * ( Zet_t_k(:,i) - zbar_t )'
CrossCovar= CrossCovar+ Wsigma_cov(i) * ( XSigmaPresent_prior(:,i) - xbarPresent_prior ) * ( XSigmaPresent_prior(:,i) - zbar_t)'
% PyyCrossCovar= PyyCrossCovar+ Wsigma_cov(i) * ( Zet_t_k(:,i) - zbar_t ) * ( Zet_t_k(:,i) - zbar_t)'
% PxyCrossCovar= PxyCrossCovar+ Wsigma_cov(i) * ( XSigmaPresent_prior(:,i) - xbarPresent_prior ) * ( Zet_t_k(:,i) - zbar_t)'
end


% 9. Compute Kalman gain
K_t= CrossCovar *inv(S_t) % [nxn]:3x3
% K = PxyCrossCovar/PyyCrossCovar

% 10. Correction of the mean
% xbarPresent_post = xbarPresent_prior + K_t * (z_t - zbar_t) % [nx1]:3x1
xbarPresent_post = xbarPresent_prior + K_t * (z_t - xbarPresent_prior)
% xbarPresent_post22 = xbarPresent_prior + K * (z_t - xbarPresent_prior)

% 11. Update the Covariance matrix
% CovPresent_post = CovPresent_prior - K_t * S_t * (K_t)'
CovPresent_post = CovPresent_prior - K_t * H * CovPresent_prior
% CovPresent_post22 = CovPresent_prior - K * H * CovPresent_prior

Pe=CovPresent_post
xe=xbarPresent_post
xh=xbarPresent_post(1); yh=xbarPresent_post(2); thetah=xbarPresent_post(3)
% xh2=xbarPresent_post22(1); yh2=xbarPresent_post22(2); thetah2=xbarPresent_post22(3)

end
%% ----------------

function [XSigmaPresent_prior]= SigPointGen(n, lambda, xbarPast_post, covPast_post, theta, dt)
% 1. Generate Sigma points
XSigmaPast_post=zeros(n,2*n+1)
XSigmaPast_post(:,1)= xbarPast_post
MSR =chol( (n+lambda)*covPast_post )  % chol: To Calculate square root of error covariance
    for i=1:n
    XSigmaPast_post(:,i+1)  = xbarPast_post + ( MSR(i,:)' )
    XSigmaPast_post(:,n+i+1)= xbarPast_post - ( MSR(i,:)' )
    end
%%2. Propagate each sigma-point through prediction
%XSigmaPresent_prior=eval( g(XSigmaPast_post)) % nx(2*n+1)--> 3x7
XSigmaPresent_prior=zeros(n, 2*n+1);
    for k=1:2*n+1
        XSigmaPresent_prior(:,k)=fx(XSigmaPast_post(:,k),theta,dt)  % XSigmaPresent_prior is the transformed sigma points
    end
end
    
function xp=fx(x,theta,dt)
Ak = [1 0  cosd(theta)/theta;
        0 1  sind(theta)/theta;
        0 0  1];
A=eye(3)+dt*Ak;
 xp=A*x;
end
%    
function  zpk=hx(x,theta)
zpk(1,1)=x(1)%sin(theta);
zpk(2,1)=x(2)%cos(theta);
zpk(3,1)=x(3);
end

function [xmean, CovMat]= UnsTrans( Sigmapoints, Wmean, Wcov, NoiseCov)
%[xbarPresent_prior, CovPresent_prior]= UnsTrans( XSigmaPresent_prior, Wsigma_mean, Wsigma_cov, R_t)

[n,~]=size(Sigmapoints)
% Calculate mean of predicted state
xmean=0;
for i=1:(2*n+1)
xmean= xmean + Wmean(i) * Sigmapoints(:,i) % [nx(2*n+1)] :3x7 * ([1x(2*n+1)] : 1x7)' = [nx1] :3x1
end
% Calculate covariance of predicted state
CovMat=0;
for i=1:(2*n+1)
CovMat= CovMat + Wcov(i)* ( Sigmapoints(:,i) - xmean ) * ( Sigmapoints(:,i) - xmean )' + NoiseCov % 1 * ( [nx1]: 3x1 - 3x1) * ( [nx1]:3x1 -3x1)' + [n,n]:3x3
end

end
