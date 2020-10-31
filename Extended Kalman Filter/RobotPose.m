function [xm, ym, theta] =RobotPose(t)
%
persistent Posxm Posym

if isempty(Posxm)
    Posxm=0;
    Posym=0;
end

d=1;
%% Generate values from a normal distribution with specified mean vector and covariance matrix.
mu = [0 0 0];
sigma = [0.01 0 0; 0 0.01 0; 0 0 10000];
R = chol(sigma);
z=mvnrnd(mu,sigma);
theta=z(1,3);
%%
xm=Posxm+d*cosd(theta);
ym=Posym+d*sind(theta);

Posxm=xm;        % true X position
Posym=ym;        % true Y position