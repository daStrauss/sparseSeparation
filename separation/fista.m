function [xs rzd p] = fista(b, A, c, lam, nit, xo)
% function [xs rzd] = fista(b, A, c, lam, nit,xo);
% solve by fast ista
% inputs: 
% b: rhs , what we want to match in ||b-Ax||
% A: the matrix A, can be a set of spot operators
% c: lipschitz constant for A
% lam: threshold parameter
% nit: number of iterations
% xo: known solution (if it exists)
% output: xs - final solution
% rzd : residual for each iteration
% 
% implements the Fast iterative shrinking and thresholding method.
le_go = tic;
[n N] = size(A);
xs = zeros(N,1); xp = zeros(N,1); 
p = zeros(N,1);
tn = 1;
    
for iter = 1:nit
    % loom = 2.5*median(abs(xs))/0.6745
    % loom = lam; % *(iter^-0.5);
   
    % save for later
    xp = xs;
    % soft threshold p->xs
    zsx = A'*(b-A*p);
    loom = 2.5*median(abs(zsx))/0.6745;
    hala(iter) = loom;
    xs = stv(p + (1/c)*(zsx),loom/c); 
    %save for later
    to = tn;
    %update t
    tn = (1+sqrt(1+4*to^2))/2;
    %update p
    p = xs + ((to-1)/tn)*(xs - xp);
    rzd(iter) = norm(xo-xs)^2/N;
    mse(iter) = norm(A*xs-b);
    % normally at 1e-7;
    
    if (iter > 5) && (abs(rzd(iter) - rzd(iter-1)) < 2e-3)
        disp(['I done early! - ' num2str(iter) ' iterations'])
        break
    end
    
    
end

disp(['Fista evaluation time = ' num2str(toc(le_go))])
disp(['Fista iterations ' num2str(iter)])
disp(['Final rzd ' num2str(rzd(iter)-rzd(iter-1))])

figure(8765);
line(1:length(hala), hala)

figure(8373);
line(1:length(rzd), mse)