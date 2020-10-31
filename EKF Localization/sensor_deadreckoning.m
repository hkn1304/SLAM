% clear axes;
% hold off;
% clc;
% clear all;
noise=0.01
alpha1 = noise; alpha2 = noise; alpha3 = noise; 
alpha4 = noise; alpha5 = noise; alpha6 = noise; 
% %sample_number=1
d=3
theta=pi/2
step_number=12
dx=2   % It is step size along x
dy=2   % It is step size along y
dt=1
% xy = [zeros(3,sample_number)] % this is the start point
% v=[]
% w=[]
% % we have three points (x,y,theta) for every sample
% e = [0.01; 0.1; 0.1];
%     x_e = [0; 0; 0];
    % disturbance matrix
    qt=[25;25;25]
%     R = [0.02, 0, 0; 0, 0.02, 0; 0, 0, 0.02];
    Q = [qt(1), 0, 0; 0, qt(2), 0; 0, 0, qt(3)];
    P = [0.65, 0, 0; 0, 0.65, 0; 0, 0, 0.65];    
%% Landmarks
s=[2*dx,  3*dx,   3*dx,  4.5*dx,  2*dx,   1*dx ;
     .5*dy, .5*dy,  2*dy,  4*dy,     3.5*dy, 3.5*dy;
     1         2          3        4           5           6 ]

LS=size(s)
rectangle('Position',[s(1,1), s(2,1), 0.2, 0.2],  'Curvature',[1,1], 'FaceColor','r') ;axis square;
grid
hold on
rectangle('Position',[s(1,2), s(2,2), 0.2, 0.2],   'Curvature',[1,1], 'FaceColor','r') ;axis square;
rectangle('Position',[s(1,3), s(2,3), 0.2, 0.2],    'Curvature',[1,1], 'FaceColor','r') ;axis square;
rectangle('Position',[s(1,4), s(2,4), 0.2, 0.2],    'Curvature',[1,1], 'FaceColor','r') ;axis square;
rectangle('Position',[s(1,5), s(2,5), 0.2, 0.2], 'Curvature',[1,1], 'FaceColor','r') ;axis square;
rectangle('Position',[s(1,6), s(2,6), 0.2, 0.2], 'Curvature',[1,1], 'FaceColor','r') ;axis square;
%% Sensor points
step=step_number % There are 12 steps but we define turning situations so we use 14 step as input.
state=[d, theta];       % (Range, max. scan degree)
%state=[2,pi/2]
for step = 1:14       
       %% Trajectory
       if (step > 0 && step < 6)
           mu = [(step-1)*dx; 0; 0];  % [x,y,theta] They are the robot ideal motions
           u = [dx; 2*pi];           % [v w]  Dead reckoning inputs
       elseif (step == 6)
           mu = [4*dx; (step - 6) * dx; pi/2];
           u = [0; pi / 2];
       elseif (step > 6 && step < 11)
           mu = [4*dx; (step - 6) * dy; pi/2];
           u = [dy; 2 * pi];
       elseif (step == 11)
           mu = [4*dx; 4*dy; pi];
           u = [0; pi / 2];
       elseif (step > 11 && step < 15)
           mu = [4*dx - ((step - 11) * dx); 4*dy; pi];
           u = [dx; 2 * pi];
       end     
       % Sensor Area 
       line([mu(1) mu(1)+state(1)*cos((mu(3) + (state(2) / 2))) ], [mu(2) mu(2)+state(1)*sin((mu(3) + (state(2) / 2)))])
       line([mu(1) mu(1)+state(1)*cos((mu(3) - (state(2) / 2))) ], [mu(2) mu(2)+state(1)*sin((mu(3) - (state(2) / 2)))])
       for i = (mu(3) - (state(2) / 2)):0.05:(mu(3) + (state(2) / 2))
           hold on
           scatter(mu(1)+state(1)*cos(i), mu(2)+state(1)*sin(i),.5)
       end

%% Initial value of states
% The x values are initial values

v=u(1,1);
w=u(2,1);
r=v/w;
  
% mu_ = [mu(1)-r*sin(mu(3))+r*sin(mu(3)+w*dt);  % mu_pre
%              mu(2)+r*cos(mu(3))-r*cos(mu(3)+w*dt); 
%              mu(3)+w*dt];
% derivative of the g
G = [1,   0,   -r*cos(mu(3,1))+r*cos(mu(3,1)+w*dt); 
        0,   1,   -r*sin(mu(3,1))+r*sin(mu(3,1)+w*dt); 
        0,   0,   1];
    % derivative of the u
V = [((-1)*sin(mu(3))+sin(mu(3)+(u(2)*dt)))/u(2), (sin(mu(3))-sin(mu(3)+(u(2)*dt)))/u(2)^2*u(1)+cos(mu(3)+(u(2)*dt))/u(2)*dt, 0; 
     (cos(mu(3)) - cos(mu(3) + (u(2)*dt))) /u(2), (-1)*(cos(mu(3)) - cos(mu(3) + (u(2)*dt))) / u(2)^2 * u(1) + sin(mu(3) + (u(2)*dt)) / u(2) * dt, 0; 
     0, dt, 0];    
% covariance of the noise
M = [alpha1*u(1)^2+alpha2*u(2)^2, 0,                              0; 
        0,                               alpha3*u(1)^2+alpha4*u(2)^2, 0; 
        0,                               0,                           alpha5*u(1)^2+alpha6*u(2)^2];
     
% Covariance prediction
Pp = G*P*G'+V*M*V'; % 3x3  
%% Correction
    for i = 1:LS(1)
    % Distance between feature and robot
    r_s = sqrt((s(i,1) - mu(1))^2 + (s(i,2) - mu(2))^2);
    degree_s = atan2(s(i,2) - mu(2), s(i,1) - mu(1));
    zt=[r_s;
    degree_s;
       i];
        if (r_s<=state(1)&&(degree_s<=(mu(3)+state(2)/2))&&degree_s>=(mu(3)-state(2)/2))
        % H matrix
        ro=[s(i,1)-mu_(1);
            s(i,2)-mu_(2)];
            q = ro'*ro;
        %sqrtq = sqrt((mu(1) - s(i,1))^2 + (mu(2) - s(i,2))^2);
        zt_hat=[sqrt(q);
            atan2(ro(2),ro(1))-mu_(3);
              i]
        H = (1/q)*[sqrt(q)*ro(1), -sqrt(q)*ro(2), 0; 
            ro(2),         ro(1),          -1; 
            0,             0,              0];
        % K gain
        K = Pp*H'/(H*Pp*H'+Q);
        error=zt-zt_hat
        mu=mu_+K*error
        else
        %zt_hat=zt
        H =[ 1 0 0;
             0 1 0;
             0 0 1];
        %Q = 1.0*eye(3);
        %R = 1.0*eye(3);
        [xm, ym, theta] = GetPosEK(step);
        z = [xm; ym; theta] ;  % 3x1
        K = Pp*H'/(H*Pp*H'+Q);
       % mu = mu_ + K*[z-H*mu]
       mu = mu_ + K*[2;2;2]
        end
    %error=zt-zt_hat
           %temp = (K * [e(1) 0 0; 0 e(2) 0; 0 0 e(3)]);
                 % covariance and mean of the correction
%                  mu(1) = temp(1,1) + mu_(1);
%                  mu(2) = temp(2,2) + mu_(2);
%                  mu(3) = temp(3,3) + mu_(3);
    %mu=mu_+K*error
    
    P = (eye(3) - K * H) * Pp;
    
    end
    figure(1)
    Pxy=[P(1,1) P(1,2);
    P(2,1) P(2,2)];
h=error_ellipse_drawing(Pxy,mu);

end