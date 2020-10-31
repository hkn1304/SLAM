%% sample_normal_distribution
function x=sample_normal_distribution(c)
a=0
for k=1:12
    a=a+normrnd(-1,1)
end
x=(c/6)*a