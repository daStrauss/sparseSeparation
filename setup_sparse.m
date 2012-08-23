function setup_sparse
disp('Oh hi. Thanks for using my sparse separation tools')
disp('I will add a few paths to matlab so you can use: ')
disp('WaveLab ')
disp('Spot toolbox ')
disp('My tools ' )
disp('Enjoy ')

if isunix
    ss = '/'
elseif ispc
    ss = '\'
else
    disp('What type of computer are you using?')
end

run([pwd ss 'Wavelab850' ss 'wavelab_setup.m'])
addpath([pwd ss 'spotbox-v1.0'])
addpath([pwd ss 'separation'])