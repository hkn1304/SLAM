clear axes;
hold off;
% clc;
% clear all;
% alpha1 = 0.01; alpha2 = 0.01; alpha3 = 0; 
% alpha4 = 0; alpha5 = 0; alpha6 = 0; 
% sample_number=10

xy = [zeros(3,sample_number)] % this is the start point
% we have three points (x,y,theta) for every sample
xy_a = []%zeros(3,sample_number,step_number) %sampling poses
xy_s = []
xt = zeros(3,1)
for sam_n=1:1:sample_number
    
    for step=1:4  
    x=1,y=0,theta=0
    
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
    x=0,y=1,theta=0
    
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
    x=-1,y=0,theta=0
    
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
    scatter(xy_a(1,step,sam_n),xy_a(2,step,sam_n),20,'filled')
    hold on
    end    
end