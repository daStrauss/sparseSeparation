function  res = ortwv(n, fam, ord)
% res = wavlt(n, typ, lev)
% 
% does 1d wavelet periodic boundary wavelet transform. I think this
% ought to work for what I want? Parameters:
% n = length of rhs vector
% fam = wavelet family
% ord = family order
% think of this as a matrix A (n,N) that implements the wavelet decomposition

if ~exist('FWT_PO')
    run('/shared/users/dstrauss/soft/Wavelab850/WavePath.m')
end

if round(log2(n)) == log2(n)
    res.adjoint = 0;
    res.N = n;
    res.fam = fam;
    res.ord = ord;
    res.qmf = MakeONFilter(fam, ord);
    res.n = n;
else
    disp('Wrong size n!')
end


res = class(res,'ortwv');

