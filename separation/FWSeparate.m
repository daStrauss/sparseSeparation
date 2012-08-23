function [yW yF] = FWSeparate(x, varargin)
% FWSeparate is a function that does the basic separation between
% the fourier components and the wavelet components. This function
% is designed to be a high-level wrapper around many other
% internals. It assumes that you want Daubechies, order 10
% wavelets. If you don't, you can always change that.
%
% Want to know something funny? Wavelets only work in dyads,
% therefore, I'm only going to filter the first 1:2^n
% (n=floor(log2(length(x)))) points of
% x. I'll find them. 
% 
% Usage:
% [yW yF] = FWSeparate(x)
% Separate into the Fourier part (yF) and the wavelet part (yW) the
% timeseries of x. 
% 
% [yW yF] = FWSeparate(x, Family, Class)
% Separate into the Fourier part (yF) and the wavelet part (yW)
% using the wavelets with the given Family and Class. Here are some
% possibilities: 
% Family     |  Class
% Daubechies | any in [2:2:18]
% Symmlet    | 1,2,3,4,5
% Haar       | 1
% 

n = floor(log2(length(x)));
x = x(1:(2^n));

if nargin > 1
    fam = varargin{1}
    class = varargin{2}
else
    family = 'Daubechies';
    class = 10;
    
end

[yls yW yF xls xnn mtx] = morf_bpdn_R(ymm, 'Daubechies',10, 0);

