function  res = ctranspose(A)

A.adjoint = xor(A.adjoint,1);
res = A;


%   Copyright 2012, David Strauss
%   See the file COPYING.txt for full copyright information.