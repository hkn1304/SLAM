clear axes;
hold off;
% clc;
% clear all;
% alpha1 = 0.01; alpha2 = 0.01; alpha3 = 0.01; 
% alpha4 = 0.01; alpha5 = 0.01; alpha6 = 0.01; 
% sample_number = 10;
% step_number = 8; % How many step we will have
% r = 1;

% necessary inputs
dt =2/step_number;

xy = [zeros(3,sample_number)] % this is the start point
% we have three points (x,y,theta) for every sample
xy_s = []%zeros(3,sample_number,step_number) %sampling poses
xt = zeros(3,1)

for step = 1:step_number
%     
v = r*pi;
w = pi;
% We will produce sample values 
sam1=alpha1*abs(v)+alpha2*abs(w); 
sam2=alpha3*abs(v)+alpha4*abs(w);
sam3=alpha5*abs(v)+alpha6*abs(w);

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

% We need to new (x,y,theta) for every sample
xy(1,sam_n) = xy_s(1,step,sam_n);
xy(2,sam_n) = xy_s(2,step,sam_n);
xy(3,sam_n) = xy_s(3,step,sam_n); 

scatter(xy_s(1,step,sam_n),xy_s(2,step,sam_n),20,'filled')
hold on
end
end
