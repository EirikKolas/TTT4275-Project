function p = gaussian_mix_dist(x,C,mu,sigma)
%GAUSSIAN_MIX_DIST Summary of this function goes here
%   Detailed explanation goes here
    p = 0;
    for k = 1:length(C)
        p = p + C(k)*gaussian_dist(x, mu(:,k), diag(sigma(:,:,k)));
    end
end