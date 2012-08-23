function [u] = stv(A, lam)
% [u] = soft_thresh_vec(A, lam)
% implements soft thresholding of the form:
% eta(A, lam) = A.*(1- lambda/|A|)+
[m n] = size(A);
nr = max(1-lam./abs(A),0);
%nr = repmat(max(1-lam./sqrt(sum(A.*conj(A),2)),0),1,n);
u = A.*nr;

