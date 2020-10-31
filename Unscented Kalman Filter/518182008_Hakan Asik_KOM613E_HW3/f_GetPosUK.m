function [xm, ym, theta] =f_GetPosUK(t)
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
zp = repmat(mu,t,1) + randn(t,3)*R;
xn=zp(t,1);
yn=zp(t,2);
theta=zp(t,3)*pi/1800
%%
%theta=0.0000001;

xm=Posxm+d*cos(theta);
ym=Posym+d*sin(theta);

Posxm=xm;        % true position
Posym=ym;        % true position