clear axes;
hold off;
% clc;
% clear all;
% alpha1 = 0.01; alpha2 = 0; alpha3 = 0; 
% alpha4 = 0; alpha5 = 0; alpha6 = 0; 
% sample_number = 10;
% step_number = 8; % How many step we will have
% r = 1;

% necessary inputs
dt =2/step_number;

xy = [zeros(3,sample_number)] % this is the start point
% we have three points (x,y,theta) for every sample
xy_a = []%zeros(3,sample_number,step_number) %sampling poses
xy_s = []
xt = zeros(3,1)

for step = 1:step_number %s
%     
v = r*pi;
w = pi;
%r = v/w;
% apostrophe=kesme iþareti
% over-bar =üst çizgi

for sam_n = 1:sample_number %k
% As known we need to sensor inputs but we do not have real sensors so we
% must calculate our own datas for everystep as sensor (real values)
% This gives (x,y,theta) respectively for every step "s"
% with every sample "k"
% xy is our odometry result that we use for posterior step
xy_s(1,sam_n) = xy(1,sam_n) - r*sin((xy(3,sam_n)))+r*sin((xy(3,sam_n))+w*dt);
xy_s(2,sam_n) = xy(2,sam_n) + r*cos((xy(3,sam_n)))-r*cos((xy(3,sam_n))+w*dt);
xy_s(3,sam_n) = xy(3,sam_n) + w*dt;
% for now xy_s is for t and xy is for t-1
drot1  = atan2(xy_s(2,sam_n)-xy(2,sam_n),xy_s(1,sam_n)-xy(1,sam_n))-xy(3,sam_n);%Line2 of Algorithm
dtrans = sqrt((xy(1,sam_n)-xy_s(1,sam_n))^2+(xy(2,sam_n)-xy_s(2,sam_n))^2);
drot2  = xy_s(3,sam_n)-xy(3,sam_n)-drot1;

% noisy rot,trans values
c1=alpha1*abs(drot1)+alpha2*abs(dtrans);
c2=alpha3*abs(dtrans)+alpha4*(abs(drot1)+abs(drot2));
c3=alpha1*abs(drot2)+alpha2*abs(dtrans);

drot1_hat  = drot1  - sample_normal_distribution(c1);
dtrans_hat = dtrans - sample_normal_distribution(c2);
drot2_hat  = drot2  - sample_normal_distribution(c3);

% This gives (x,y,theta) respectively for every step "s"
% with every sample "k"
% computing error probabilities for the individual motion parameters
% xy_a=x'
xy_a(1,step,sam_n) = xy(1,sam_n) + dtrans_hat*cos(xy(3,sam_n)+drot1_hat);
xy_a(2,step,sam_n) = xy(2,sam_n) + dtrans_hat*sin(xy(3,sam_n)+drot1_hat);
xy_a(3,step,sam_n) = xy(3,sam_n) + drot1_hat+drot2_hat;

% We need to know new (x,y,theta) for every sample
xy(1,sam_n) = xy_a(1,step,sam_n);
xy(2,sam_n) = xy_a(2,step,sam_n);
xy(3,sam_n) = xy_a(3,step,sam_n); 

scatter(xy_a(1,step,sam_n),xy_a(2,step,sam_n),20,'filled')
%plot(xy_a(1,step,sam_n),xy_a(2,step,sam_n))
%plot(xy_a(1,step,sam_n),xy_a(2,step,sam_n),'.','Color',[0 0 0],'MarkerSize',3);
%axis([-5 5 -5 10])
hold on
end
end
