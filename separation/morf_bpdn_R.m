function [yls yW yD xls xnn mtx] = morf_bpdn_R(y, fam, cls, figs)
% [yls yW yD yS xp] = morf_bpdn_R(y, fam, cls, lam, figs)
% 
% a function that will do my flavor of wavelet basis pursuit
% denoising.
% y = vector to denoise
% fam = family of wavelets
% cls = wavelet order
% lam = reg. parameter
% figs = selector for figures
% 
% Update 1 - switching to the WaveLab Periodic wavelet transform
% package. This is a true orthogonal basis expansion and shows very
% very fast performance and accuracy.
% 
% Update 2 - added a restriction operator to get rid of the biggest
% size wavelets as it was found that they often give a mutual
% coherence that is tooo high

%   Copyright 2012, David Strauss
%   See the file COPYING.txt for full copyright information.


% wavelets work best with zero mean data
[n m] = size(y);
for ch = 1:m
    y(:,ch) = y(:,ch) - mean(y(:,ch));
end

n = length(y);
B = ortwv(n, fam, cls);

xbs = log2(n);
lop = 1:n;
kl = 1:2^(xbs-12);;
lop(kl) = [];

R = opRestriction(n,lop);
% B = meywv(n);

[n N] = size(B);
% W = opClass(N, n, B);
W = R*opClass(n, N, B);
D = opDFT(n);
% S = opDirac(n);
% W = make_lftop(n,512);

A = [W' D'];


[n N] = size(A);
x = zeros(N,m);
% lam = 0.0017;
% huh. the iterative thesholding ideas work nicer than l1_ls!
% [x,status] = l1_ls(Bt,B,n,N,y,0.02,1e-5, false);
% I wish I could use SPOT to concatonate!
% [xns cpl] = bpdn_iter_sth(Bt,y,lam,x);
% [xnn cpn] = nesterov_bpdn(A,y,lam,x,200);
[xnn cpn] = fista(y,A,3,450,x);
% figure(10009);
% plot(cpn)

% figure(10);
% subplot(221)
% plot(1:N, xnn)
% title(['wavelet coefficients - lam = ' num2str(lam)])
% legend('simple iter', 'nesterov')

% figure(2)
% subplot(222)
% plot(1:n, y, 1:n, Bt*xnn)
% legend('original', 'nesterov')

% ==== Polishing Stage ========== 
% minimize ( ||AMx - b|| )
% where A is the wavelet reconstruction, M is a sparsity
% restrictor.
% The solution is (M'*A'*A*M)\(M'*A'*b), which, given the implicit
% definitions will have to be solved using pcg.

% selection of zero coefficients
% figure(30); clf
% for ch  = 1:m
disp(['Relative cardinality of solution = ' num2str(card(xnn,1e-13)/length(y))])

doLSFinal = false;

if doLSFinal
    
    
    lek = abs(xnn(:,ch)) > 1e-10;
    % sum(lek)
    lek = ~lek;
    M = speye(N);
    M(:,lek) = [];

    h = @(x) (M'*(A'*(A*(M*x))));
    bb = M'*(A'*y(:,ch));
    [xp, flag, relres, iter, resvec] = pcg(h,bb, 1e-6, 100);
    disp(['flag = ' num2str(flag)])
    
   
    xls = M*xp;
    yls = A*xls;
    [z q] = size(W');

    yW = W'*xls(1:q,:);
    yD = D'*xls(q+(1:n),:);
else
    yls = A*xnn;
    xls = xnn;
    [z q] = size(W');
    
    yW = W'*xnn(1:q);
    yD = D'*xnn(q+(1:n));
end



if figs
    figure(10)
    subplot(221)
    plot(1:200, cpn)
    legend('nesterov')
    title('norms of iterates in nesterov loop')

    subplot(222)
    plot(1:n, y-yn, 1:n, y-yls)
    title('Residuals')
    legend('bpdn', 'polishing')

    
    subplot(223)
    [spec F T] = spectrogram(yls(:,1), blackman(200), 150, 512, 5e9);
    imagesc(T, F, (abs(spec)))
    set(gca,'YDir', 'normal')
    colorbar
    title('polished spectrogram')
    % 1:n, yn(:,1),
    subplot(224)
    plot(1:n, y(:,1),  1:n, yls(:,1))
    title('final outputs')
    legend('original', 'bpdn', 'polishing')    
end

mtx.A = A;
mtx.W = W';
mtx.F = D';