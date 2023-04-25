function p = gaussian_dist(x, mu,sigma)
    %GAUSSIAN_DIST Summary of this function goes here
    p = exp(-1/2*(x-mu).'*(sigma\(x-mu)))/sqrt((2*pi)^length(x)*det(sigma));
end