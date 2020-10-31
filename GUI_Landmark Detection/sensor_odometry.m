%% To work with GUI do comment this part
% clear axes;
% hold off;
% clc;
% clear all;
% alpha1 = 0.02; alpha2 = 0.02; alpha3 = 0.02; 
% alpha4 = 0.02; alpha5 = 0; alpha6 = 0; 
% sample_number=100
% dx=2   % It is step size along x
% dy=2   % It is step size along y
% d=2
%theta=pi/2

%%
xy = [zeros(3,sample_number)] % this is the start point
xy_a=[]
% % we have three points (x,y,theta) for every sample
% % %% Landmarks
% % Lm=[2*dx,    .5*dy;
% %     3*dx,    .5*dy;
% %     3*dx,     2*dy;
% %     4.5*dx,   4*dy;
% %     2*dx,   3.5*dy;
% %     1*dx,   3.5*dy]
% % LS=size(Lm)
% % rectangle('Position',[Lm(1,1), Lm(1,2), 0.2, 0.2],  'Curvature',[1,1], 'FaceColor','r') ;axis square;
% % grid
% % hold on
% % rectangle('Position',[Lm(2,1), Lm(2,2), 0.2, 0.2],   'Curvature',[1,1], 'FaceColor','r') ;axis square;
% % rectangle('Position',[Lm(3,1), Lm(3,2), 0.2, 0.2],    'Curvature',[1,1], 'FaceColor','r') ;axis square;
% % rectangle('Position',[Lm(4,1), Lm(4,2), 0.2, 0.2],    'Curvature',[1,1], 'FaceColor','r') ;axis square;
% % rectangle('Position',[Lm(5,1), Lm(5,2), 0.2, 0.2], 'Curvature',[1,1], 'FaceColor','r') ;axis square;
% % rectangle('Position',[Lm(6,1), Lm(6,2), 0.2, 0.2], 'Curvature',[1,1], 'FaceColor','r') ;axis square;
%% Sensor points
step=14 % There are 12 steps but we define turning situations so we use 14 step as input.
state=[d, theta];   % (Range, max. scan degree)
for a = 1:step       
       if (a > 0 && a < 6)
           snsr = [(a-1)*dx; 0; 0];
       elseif (a == 6)
           snsr = [4*dx; (a - 6) * dx; pi/2];
       elseif (a > 6 && a < 11)
           snsr = [4*dx; (a - 6) * dy; pi/2];
       elseif (a == 11)
           snsr = [4*dx; 4*dy; pi];
       elseif (a > 11 && a < 15)
           snsr = [4*dx - ((a - 11) * dx); 4*dy; pi];
       end     
       % Sensor Area 
       axes(handles.axes1);
       line([snsr(1) snsr(1)+state(1)*cos((snsr(3) + (state(2) / 2))) ], [snsr(2) snsr(2)+state(1)*sin((snsr(3) + (state(2) / 2)))])
       line([snsr(1) snsr(1)+state(1)*cos((snsr(3) - (state(2) / 2))) ], [snsr(2) snsr(2)+state(1)*sin((snsr(3) - (state(2) / 2)))])
       for i = (snsr(3) - (state(2) / 2)):resolution:(snsr(3) + (state(2) / 2))
           hold on
           axes(handles.axes1);
           scatter(snsr(1)+state(1)*cos(i), snsr(2)+state(1)*sin(i),.5)
       end
end

for sam_n=1:1:sample_number
    
    for step=1:4  
    x=dx,y=0,theta=0
        for i = 1:LS(1)
           % Distance between feature and robot
           r_s(step,i) = sqrt((Lm(i,1) - xy(1,sam_n))^2 + (Lm(i,2) - xy(2,sam_n))^2);
           degree_s(step,i) = atan2(Lm(i,2) - xy(2,sam_n), Lm(i,1) - xy(1,sam_n));
           if (r_s(step,i)<=state(1)&&(degree_s(step,i)<=(state(2)/2))&&degree_s(step,i)>=(-state(2)/2))
           % 
           snsrland(1,i,step)=r_s(step,i)  
           snsrland(2,i,step)=degree_s(step,i)
           end
        end
        
    drot1  = atan2(y,x)-xy(3,sam_n); % d_theta gives theta value for every step
    dtrans = sqrt(y^2+x^2);          % hipotenüs value
    drot2  = theta-drot1;            % d_theta for second 
    % rot,trans,rot
    drot1_hat   = drot1 - sample_normal_distribution(alpha1*abs(drot1)+alpha2*dtrans) ;
    dtrans_hat = dtrans - sample_normal_distribution(alpha3*dtrans+alpha4*(abs(drot1)+abs(drot2)));
    drot2_hat  = drot2 - sample_normal_distribution(alpha1*abs(drot2)+alpha2*dtrans);
    % x,y,theta
    xy_a(1,step,sam_n) = xy(1,sam_n) + dtrans_hat*cos(xy(3,sam_n)+drot1_hat);
    xy_a(2,step,sam_n) = xy(2,sam_n) + dtrans_hat*sin(xy(3,sam_n)+drot1_hat);
    xy_a(3,step,sam_n) = xy(3,sam_n) + drot1_hat+drot2_hat;
    % x,y,theta
    xy(1,sam_n) = xy_a(1,step,sam_n);
    xy(2,sam_n) = xy_a(2,step,sam_n);
    xy(3,sam_n) = xy_a(3,step,sam_n); 
    axes(handles.axes1)
    scatter(xy_a(1,step,sam_n),xy_a(2,step,sam_n),20,'filled')
    hold on
    end
    
    x=0,y=0,theta=pi/2
    
    drot1  = atan2(y,x)-xy(3,sam_n); % d_theta gives theta value for every step
    dtrans = sqrt(y^2+x^2);       % hipotenüs value
    drot2  = theta-drot1;      % translation in y direction

    drot1_hat   = drot1 - sample_normal_distribution(alpha1*abs(drot1)+alpha2*dtrans) ;
    dtrans_hat = dtrans - sample_normal_distribution(alpha3*dtrans+alpha4*(abs(drot1)+abs(drot2)));
    drot2_hat  = drot2 - sample_normal_distribution(alpha1*abs(drot2)+alpha2*dtrans);

    xy_a(1,step,sam_n) = xy(1,sam_n) + dtrans_hat*cos(xy(3,sam_n)+drot1_hat);
    xy_a(2,step,sam_n) = xy(2,sam_n) + dtrans_hat*sin(xy(3,sam_n)+drot1_hat);
    xy_a(3,step,sam_n) = xy(3,sam_n) + drot1_hat+drot2_hat;
    
    xy(1,sam_n) = xy_a(1,step,sam_n);
    xy(2,sam_n) = xy_a(2,step,sam_n);
    xy(3,sam_n) = xy_a(3,step,sam_n); 
    
   for step=1:4  
    x=0,y=dy,theta=0
    
    drot1  = atan2(y,x)-xy(3,sam_n); % d_theta gives theta value for every step
    dtrans = sqrt(y^2+x^2);       % hipotenüs value
    drot2  = theta-drot1;      % translation in y direction

    drot1_hat   = drot1 - sample_normal_distribution(alpha1*abs(drot1)+alpha2*dtrans) ;
    dtrans_hat = dtrans - sample_normal_distribution(alpha3*dtrans+alpha4*(abs(drot1)+abs(drot2)));
    drot2_hat  = drot2 - sample_normal_distribution(alpha1*abs(drot2)+alpha2*dtrans);

    xy_a(1,step,sam_n) = xy(1,sam_n) + dtrans_hat*cos(xy(3,sam_n)+drot1_hat);
    xy_a(2,step,sam_n) = xy(2,sam_n) + dtrans_hat*sin(xy(3,sam_n)+drot1_hat);
    xy_a(3,step,sam_n) = xy(3,sam_n) + drot1_hat+drot2_hat;
    
    xy(1,sam_n) = xy_a(1,step,sam_n);
    xy(2,sam_n) = xy_a(2,step,sam_n);
    xy(3,sam_n) = xy_a(3,step,sam_n); 
    axes(handles.axes1)
    scatter(xy_a(1,step,sam_n),xy_a(2,step,sam_n),20,'filled')
    hold on
   end
    x=0,y=0,theta=pi/2
    
    drot1  = atan2(y,x)-xy(3,sam_n); % d_theta gives theta value for every step
    dtrans = sqrt(y^2+x^2);       % hipotenüs value
    drot2  = theta-drot1;      % translation in y direction

    drot1_hat   = drot1 - sample_normal_distribution(alpha1*abs(drot1)+alpha2*dtrans) ;
    dtrans_hat = dtrans - sample_normal_distribution(alpha3*dtrans+alpha4*(abs(drot1)+abs(drot2)));
    drot2_hat  = drot2 - sample_normal_distribution(alpha1*abs(drot2)+alpha2*dtrans);

    xy_a(1,step,sam_n) = xy(1,sam_n) + dtrans_hat*cos(xy(3,sam_n)+drot1_hat);
    xy_a(2,step,sam_n) = xy(2,sam_n) + dtrans_hat*sin(xy(3,sam_n)+drot1_hat);
    xy_a(3,step,sam_n) = xy(3,sam_n) + drot1_hat+drot2_hat;
    
    xy(1,sam_n) = xy_a(1,step,sam_n);
    xy(2,sam_n) = xy_a(2,step,sam_n);
    xy(3,sam_n) = xy_a(3,step,sam_n); 

    for step=1:4  
    x=-dx,y=0,theta=0
    
    drot1  = atan2(y,x)-xy(3,sam_n); % d_theta gives theta value for every step
    dtrans = sqrt(y^2+x^2);                 % hipotenüs value
    drot2  = theta-drot1;                     % translation in y direction

    drot1_hat   = drot1 - sample_normal_distribution(alpha1*abs(drot1)+alpha2*dtrans) ;
    dtrans_hat = dtrans - sample_normal_distribution(alpha3*dtrans+alpha4*(abs(drot1)+abs(drot2)));
    drot2_hat  = drot2 - sample_normal_distribution(alpha1*abs(drot2)+alpha2*dtrans);

    xy_a(1,step,sam_n) = xy(1,sam_n) + dtrans_hat*cos(xy(3,sam_n)+drot1_hat);
    xy_a(2,step,sam_n) = xy(2,sam_n) + dtrans_hat*sin(xy(3,sam_n)+drot1_hat);
    xy_a(3,step,sam_n) = xy(3,sam_n) + drot1_hat+drot2_hat;
    
    xy(1,sam_n) = xy_a(1,step,sam_n);
    xy(2,sam_n) = xy_a(2,step,sam_n);
    xy(3,sam_n) = xy_a(3,step,sam_n);
    axes(handles.axes1)
    scatter(xy_a(1,step,sam_n),xy_a(2,step,sam_n),20,'filled')
    hold on
    end    
end