% State estimation with Dead reckoning for Rectangular trajectory


clear axes;
hold off;
% clc;
% clear all;
% alpha1 = 0.01; alpha2 = 0.01; alpha3 = 0.01; 
% alpha4 = 0.01; alpha5 = 0.01; alpha6 = 0.01; 
% sample_number = 10;
% step_number = 8; % How many step we will have
% r = 1;
alphas=[alpha1 alpha2 alpha3 alpha4 alpha5 alpha6]
% necessary inputs
dt =2/step_number;

xy = [zeros(3,sample_number)] % this is the start point % Burada xPast_post!!
% we have three points (x,y,theta) for every sample
xy_s = []%zeros(3,sample_number,step_number) %sampling poses
%xt = zeros(3,1)

for step = 1:step_number

% xPresent_prior= gFunc(xPast_post, sample_number, alphas) + GtFunc
xPresent_prior= gFunc(xy, sample_number, alphas) + GtFunc(xy)*(X_t-1 - xy) + CtFunc(xy)*([v_hat;w_hat;gamma_hat]-[v;w;0])
SigmaPresent_prior= transpose( GtFunc(xy) )*SigmaPast_post*GtFunc(xy) + transpose( CtFunc(xy) )*Sigma_u*CtFunc(xy)

%% Landmarks
    for i=1:LS
    k=k(i) %correspondence of i in the map
    
    
    % Innovation covariance
    St= HFunc(Mx,My,xPresent_prior) * SigmaPresent_prior * transpose( HFunc(Mx,My,xPresent_prior) ) + 
    % Kalman Gain
    K(i)=   SigmaPresent_prior*transpose( HFunc(Mx,My,xPresent_prior) )* inv(St)
    end


end

function y= gFunc(x, sample_number, alphas)


%     
v = r*pi;
w = pi;
% % % We will produce sample values 
% % sam1=alpha1*abs(v)+alpha2*abs(w); 
% % sam2=alpha3*abs(v)+alpha4*abs(w);
% % sam3=alpha5*abs(v)+alpha6*abs(w);

% We will produce sample values 
sam1=alphas(1)*abs(v)+alphas(2)*abs(w); 
sam2=alphas(3)*abs(v)+alphas(4)*abs(w);
sam3=alphas(5)*abs(v)+alphas(6)*abs(w);

%ADDED
Sigma_u=[alphas(1)*v^2+alphas(2)*w^2            0                       0;...
                    0                alphas(3)*v^2+alphas(4)*w^2        0;...
                    0                           0                   alphas(5)*v^2+alphas(6)*w^2];

    for sam_n = 1:sample_number
    %NOISY VELOCITIES
    v_hat = v+ sample_normal_distribution(sam1);
    w_hat = w+ sample_normal_distribution(sam2);
    gamma_hat =sample_normal_distribution(sam3);
    r_hat = v_hat/w_hat;

    %This gives (x,y,theta) respectively for every step "s"
    % with every sample "k"
    xy_s(1,step,sam_n) = xy(1,sam_n) - r_hat*sin((xy(3,sam_n)))+r_hat*sin((xy(3,sam_n))+w_hat*dt);
    xy_s(2,step,sam_n) = xy(2,sam_n) + r_hat*cos((xy(3,sam_n)))-r_hat*cos((xy(3,sam_n))+w_hat*dt);
    xy_s(3,step,sam_n) = xy(3,sam_n) + w_hat*dt+gamma_hat*dt;

    % We need new (x,y,theta) for every sample
    xy(1,sam_n) = xy_s(1,step,sam_n);
    xy(2,sam_n) = xy_s(2,step,sam_n);
    xy(3,sam_n) = xy_s(3,step,sam_n); 

    scatter(xy_s(1,step,sam_n),xy_s(2,step,sam_n),20,'filled')
    hold on
    end
end

function y = GtFunc(xy)
%Circular
y=[ 1 0 r_hat*cos((xy(3,sam_n)))+r_hat*cos((xy(3,sam_n))+w_hat*dt);   ...
    0 1 -r_hat*sin((xy(3,sam_n)))+r_hat*sin((xy(3,sam_n))+w_hat*dt); ...
    0 0                             1]' ;

%Rectangular
y=[1 0  -v_hat*sin(xy(3,sam_n));...
   0 1   v_hat*dt*cos(xy(3,sam_n));...
   0 0         1]';

end

function y = CtFunc(xy)
%Circular
y=[ (-sin(xy(3,sam_n))+sin((xy(3,sam_n))+w_hat*dt))/w_hat  (cos(xy(3,sam_n))-cos((xy(3,sam_n))+w_hat*dt))/w_hat 0;   ...
    v_hat/(w_hat)^2*(sin(xy(3,sam_n))+sin((xy(3,sam_n))+w_hat*dt)+w_hat*dt*cos((xy(3,sam_n))+w_hat*dt))  v_hat/(w_hat)^2*(-cos(xy(3,sam_n))-cos((xy(3,sam_n))+w_hat*dt)+w_hat*dt*sin((xy(3,sam_n))+w_hat*dt)) 1 ; ...
    0 0                             dt] ;

%Rectangular
y=[cos(xy(3,sam_n)) dt*sin(xy(3,sam_n)) 0 ;...
        0                   0           0 ;...
        0                   0           0];
end

function [d,phi] = hFunc(Mx,My,xPresent_prior)
d(i)= sqrt( ( Mx-xPresent_prior(1) )^2 + ( My-xPresent_prior(2) )^2 )
phi(i) = atan2( Mx-xPresent_prior(1) , My-xPresent_prior(2) ) - xPresent_prior(3)
end

function H = HFunc(Mx,My,xPresent_prior)
dstar= sqrt( ( Mx-xPresent_prior(1) )^2 + ( My-xPresent_prior(2) )^2 )
H=[ -(Mx-xPresent_prior(1))/dstar    -(My-xPresent_prior(2))/dstar         0 ;...
     (My-xPresent_prior(2))/dstar^2    -(Mx-xPresent_prior(1))/dstar^2    -1;...
                    0                               0                      0 ];
end
