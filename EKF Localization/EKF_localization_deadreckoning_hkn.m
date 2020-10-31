%% To work with GUI do comment this part
% clear axes;
% hold off;
% clc;
% clear all;
% noise=0.1;
% alpha1 = noise; alpha2 = noise; alpha3 = noise; 
% alpha4 = noise; alpha5 = noise; alpha6 = noise; 
% d_range=2;  % sensor range
% theta=pi/2;
 step_number=14;
 dx=2;   % It is step size along x
% dy=2 ;  % It is step size along y
dt=dx;

%%
% disturbance matrix
qt=[0.1;0.1;0.1];
xPast_post=[0;0;0];
SigmaPast_post = [.01, 0,    0; 
                     0,  .01,   0;
                     0,  0,    10000];    

%% Sensor points
step=step_number; 
state=[d, theta];       % (Range, max. scan degree)


for step = 1:14       
%        %% Trajectory
        if (step > 0 && step < 6)
%            xPast_post = [(step-1)*dx; 0; 0];  % [x,y,theta] They are the robot ideal motions       
            u = [dx; 2*pi;0];          % [v w]  Dead reckoning inputs
        elseif (step == 6)
%            xPast_post = [4*dx; (step - 6) * dy; pi/2];
            u = [0; pi/2;0];
        elseif (step > 6 && step < 11)
%            xPast_post = [4*dx; (step - 6) * dy; pi/2];
            %u = [dy; 0.00001;0];
            u = [dy; 2*pi;0];
        elseif (step == 11)
%            xPast_post = [4*dx; 4*dy; pi];
            u = [0; pi / 2;0];
        elseif (step > 11 && step < 15)
%            xPast_post = [4*dx - ((step - 11) * dx); 4*dy; pi];
%            %u = [dx; 0.00001;0];
            u = [dy; 2*pi;0];
        end     
       % Sensor Area 
       line([xPast_post(1) xPast_post(1)+state(1)*cos((xPast_post(3)+(state(2)/2)))], [xPast_post(2) xPast_post(2)+state(1)*sin((xPast_post(3)+(state(2)/2)))])
       line([xPast_post(1) xPast_post(1)+state(1)*cos((xPast_post(3)-(state(2)/2)))], [xPast_post(2) xPast_post(2)+state(1)*sin((xPast_post(3)-(state(2)/2)))])
       for i = (xPast_post(3)-(state(2)/2)):0.05:(xPast_post(3)+(state(2)/2))
           hold on
           scatter(xPast_post(1)+state(1)*cos(i), xPast_post(2)+state(1)*sin(i),.5)
       end
%% Desired prediction point (for ellipse)
       if (step > 0 && step < 5)
           mu_plot = [(step)*dx; 0; 0];  % [x,y,theta] They are the robot ideal motions       
       elseif (step == 5)
           mu_plot = [4*dx; (step - 5) * dy; pi/2];
       elseif (step > 5 && step < 10)
           mu_plot = [4*dx; (step - 5) * dy; pi/2];
       elseif (step == 10)
           mu_plot = [4*dx; 4*dy; pi];
       elseif (step > 10 && step < 15)
           mu_plot = [4*dx - ((step - 10) * dx); 4*dy; pi];
       end     
%% Initial value of states
% The x values are initial values
v=u(1);
w=u(2);
r=v/w;

% xPresent_prior= gFunc(xPast_post, sample_number, alphas) + GtFunc(xPast_post)*(X_t-1 - xPast_post) + CtFunc(xPast_post)*([v_hat;w_hat;gamma_hat]-[v;w;0])
% SigmaPresent_prior= transpose( GtFunc(xPast_post) )*SigmaPast_post*GtFunc(xPast_post) + transpose( CtFunc(xPast_post) )*Sigma_u*CtFunc(xPast_post)


% derivative of the g
Gt = [1,   0,   -r*cos(xPast_post(3,1))+r*cos(xPast_post(3,1)+w*dt); 
     0,   1,   -r*sin(xPast_post(3,1))+r*sin(xPast_post(3,1)+w*dt); 
     0,   0,   1];
    
% derivative of the u  
Ct = [-(sin(xPast_post(3))+sin(xPast_post(3)+u(2)*dt))/u(2),       (u(1)/(u(2)^2))*(sin(xPast_post(3))-sin(xPast_post(3)+u(2)*dt))+r*cos(xPast_post(3)+u(2)*dt)*dt; 
     (cos(xPast_post(3))-cos(xPast_post(3) + u(2)*dt)) /u(2),     (-u(1)/(u(2)^2))*(cos(xPast_post(3))-cos(xPast_post(3)+u(2)*dt))+r*sin(xPast_post(3)+u(2)*dt)*dt; 
     0,                                           dt];    

% covariance of the noise
SigmaU = [alpha1*u(1)^2+alpha2*u(2)^2,  0;                              
     0,                            alpha3*u(1)^2+alpha4*u(2)^2];
% predicted pose (g_ut)
xPresent_prior = xPast_post+ [-r*sin(xPast_post(3))+r*sin(xPast_post(3)+w*dt);  % mu_hat
                   r*cos(xPast_post(3))-r*cos(xPast_post(3)+w*dt); 
                   w*dt];
% Covariance prediction
SigmaPresent_prior = Gt*SigmaPast_post*Gt'+Ct*SigmaU*Ct'; % 3x3
Q = [qt(1)^2,   0,         0;       
     0,         qt(2)^2,   0;       
     0,         0,         qt(3)^2];


%% Correction
for i = 1:LS
    % mu is the tone values
    r_real(i)=sqrt((Lm(1,i) - xPresent_prior(1))^2 + (Lm(2,i) - xPresent_prior(2))^2)
    dfgf(step,i)=sqrt((Lm(1,i) - xPresent_prior(1))^2 + (Lm(2,i) - xPresent_prior(2))^2);
    r_x(i)= Lm(1,i) - xPresent_prior(1) 
    r_y(i)= Lm(2,i) - xPresent_prior(2) 
    phi_real(i)= atan2(r_y(i),r_x(i));
    dfg(step,i)=phi_real(i)*180/pi;
    %zt=ones(3,i)
%     zt(:)=[r_real(i);
%            phi_real(i);
%            i(i)];
           
           if(phi_real(i) < 0)
               phi_real(i) = phi_real(i) + 2*pi;
           end
   if (r_real(i)<=state(1)&&(phi_real(i)<=(xPresent_prior(3)+state(2)/2))&&phi_real(i)>=(xPresent_prior(3)-state(2)/2))

       % Distance between feature and robot
q = (Lm(1,i) - xPresent_prior(1))^2 + (Lm(2,i) - xPresent_prior(2))^2;   
        
    ro_x= Lm(1,i) - xPresent_prior(1);                       % mx-mu_x
    ro_y= Lm(2,i) - xPresent_prior(2);                       % my-mu_y
          
     zt(1)=r_real(i);
     zt(2)=phi_real(i)
     zt(3)=i;
zt_hat=[sqrt(q);
        atan2(ro_y,ro_x)-xPresent_prior(3);
        i]
H = [-ro_x/sqrt(q),   -ro_y/sqrt(q),   0; 
     ro_y/q,          -ro_x/q,         -1; 
     0,               0,               0];
% K gain
   St=H*SigmaPresent_prior*H'+Q;
   Kt=(SigmaPresent_prior*H')/St;
   error=zt'-zt_hat;
   xPresent_prior=xPresent_prior+Kt*error;
   SigmaPresent_prior = (eye(3)-Kt*H)*SigmaPresent_prior;
   end

end
xPast_post=xPresent_prior;
SigmaPresent_prior=SigmaPresent_prior;
Pxyz(:,:,step)=SigmaPresent_prior;
mu12(:,:,step)=xPresent_prior
%figure(2)
  Pxy=[Pxyz(1,1,step) Pxyz(1,2,step);
       Pxyz(2,1,step) Pxyz(2,2,step)];
 h=error_ellipse_drawing(Pxy,mu_plot);
%draw_ellipse([mu(1),mu(2)], P, 'green');
end