if ~exist('sparseSeparation')
   run('pathToSS/sparseSeparation/setup_sparse')
end

ffr = load('myFavoriteData.mat');

clip = ffr.data(1:2^18);

[yW yF] = FWSeparate(clip);

ltg_plot(clip,yW,yF)