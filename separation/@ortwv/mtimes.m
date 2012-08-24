function res = mtimes(A,x)

%   Copyright 2012, David Strauss
%   See the file COPYING.txt for full copyright information.
if length(x) ~= A.N
    disp('Wrong size of x')
else
    if A.adjoint == 0 
        res = FWT_PO(x,0,A.qmf);
    else
        res = IWT_PO(x,0,A.qmf);
    end
end
