function res = mtimes(A,x)
if length(x) ~= A.N
    disp('Wrong size of x')
else
    if A.adjoint == 0 
        res = FWT_PO(x,0,A.qmf);
    else
        res = IWT_PO(x,0,A.qmf);
    end
end
