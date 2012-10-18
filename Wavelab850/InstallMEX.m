function InstallMEX

global WAVELABPATH

MEX_OK = 1;

% Check if all the MEX files are installed
for file={'CPAnalysis' 'WPAnalysis' 'FWT_PO' 'FWT2_PO' 'IWT_PO' ...
      'IWT2_PO' 'UpDyadHi' 'UpDyadLo' 'DownDyadHi' 'DownDyadLo' 'dct_iv' ...
      'FCPSynthesis' 'FWPSynthesis' ...
      'dct_ii' 'dst_ii' 'dct_iii' 'dst_iii' ...
      'FWT_PBS' 'IWT_PBS' ...
      'FWT_TI' 'IWT_TI' ...
      'FMIPT' 'IMIPT' ...
      'FAIPT' 'IAIPT' 'LMIRefineSeq' 'MedRefineSeq'}
  
  file = char(file);
  if exist(file)~=3,
    MEX_OK = 0;
    break;
  end
end

% If not, install...
if ~MEX_OK,
  disp('WaveLab detects that some or all of your MEX files are not installed,')
  R=input('do you want to install them now? [[Yes]/No] \n','s');
if strcmp(R,'') + strcmp(R,'Yes') | strcmp(R,'yes') | strcmp(R,'y') | strcmp(R,'Y') | strcmp(R,'YES'), 
  disp('INSTALLING MEX FILES, MAY TAKE A WHILE ...')
  disp(' ')
  disp('WaveLab assumes that your mex compiler is properly installed.')
  disp('In particular, you should be able to call mex.m within matlab')
  disp('to compile a mex file.')
  disp('Consult your system administrator if not.')
  disp(' ')      
  FIRST_COMPILE = 0;
  
  eval(sprintf('cd ''%sMEXSource''', WAVELABPATH));
  
  for file={'CPAnalysis' 'WPAnalysis' 'FWT_PO' 'FWT2_PO' 'IWT_PO' ...
	'IWT2_PO' 'UpDyadHi' 'UpDyadLo' 'DownDyadHi' 'DownDyadLo' 'dct_iv' ...
	'FCPSynthesis' 'FWPSynthesis' ...
	'dct_ii' 'dst_ii' 'dct_iii' 'dst_iii' ...
	'FWT_PBS' 'IWT_PBS' ...
	'FWT_TI' 'IWT_TI' ...
	'FMIPT' 'IMIPT' ...
	'FAIPT' 'IAIPT' 'LMIRefineSeq' 'MedRefineSeq'}
  
    file = char(file);
    disp(sprintf('%s.c',file));
    eval(sprintf('mex %s.c',file));
  end

  Friend = computer;
  isPC = 0; isMAC = 0;
  if strcmp(Friend(1:2),'PC')
    isPC = 1;
  elseif strcmp(Friend,'MAC2')
    isMAC = 1;
  end
  
  if isunix,
    !mv CPAnalysis.mex* ../Packets/One-D
    !mv WPAnalysis.mex* ../Packets/One-D
    !mv FWT_PO.mex* ../Orthogonal
    !mv FWT2_PO.mex* ../Orthogonal
    !mv IWT_PO.mex* ../Orthogonal
    !mv IWT2_PO.mex* ../Orthogonal
    !mv UpDyadHi.mex* ../Orthogonal
    !mv UpDyadLo.mex* ../Orthogonal
    !mv DownDyadHi.mex* ../Orthogonal
    !mv DownDyadLo.mex* ../Orthogonal
    !mv dct_iv.mex* ../Packets/One-D
    !mv FCPSynthesis.mex* ../Pursuit
    !mv FWPSynthesis.mex* ../Pursuit
    !mv dct_ii.mex* ../Meyer
    !mv dst_ii.mex* ../Meyer
    !mv dct_iii.mex* ../Meyer
    !mv dst_iii.mex* ../Meyer
    !mv FWT_PBS.mex* ../Biorthogonal
    !mv IWT_PBS.mex* ../Biorthogonal
    !mv FWT_TI.mex* ../Invariant
    !mv IWT_TI.mex* ../Invariant
    !mv FMIPT.mex* ../Median 
    !mv IMIPT.mex* ../Median
    !mv FAIPT.mex* ../Papers/MIPT
    !mv IAIPT.mex* ../Papers/MIPT
    !mv LMIRefineSeq.mex* ../Papers/MIPT
    !mv MedRefineSeq.mex* ../Papers/MIPT
  elseif isPC,
    !move CPAnalysis.mex* ../Packets/One-D
    !move WPAnalysis.mex* ../Packets/One-D
    !move FWT_PO.mex* ../Orthogonal
    !move FWT2_PO.mex* ../Orthogonal
    !move IWT_PO.mex* ../Orthogonal
    !move IWT2_PO.mex* ../Orthogonal
    !move UpDyadHi.mex* ../Orthogonal
    !move UpDyadLo.mex* ../Orthogonal
    !move DownDyadHi.mex* ../Orthogonal
    !move DownDyadLo.mex* ../Orthogonal
    !move dct_iv.mex* ../Packets/One-D
    !move FCPSynthesis.mex* ../Pursuit
    !move FWPSynthesis.mex* ../Pursuit
    !move dct_ii.mex* ../Meyer
    !move dst_ii.mex* ../Meyer
    !move dct_iii.mex* ../Meyer
    !move dst_iii.mex* ../Meyer
    !move FWT_PBS.mex* ../Biorthogonal
    !move IWT_PBS.mex* ../Biorthogonal
    !move FWT_TI.mex* ../Invariant
    !move IWT_TI.mex* ../Invariant
    !move FMIPT.mex* ../Median 
    !move IMIPT.mex* ../Median
    !move FAIPT.mex* ../Papers/MIPT
    !move IAIPT.mex* ../Papers/MIPT
    !move LMIRefineSeq.mex* ../Papers/MIPT
    !move MedRefineSeq.mex* ../Papers/MIPT
  end
end
end

eval(sprintf('cd ''%s''', WAVELABPATH));

clear MEX_OK isPC R
 
 
%
%  Part of Wavelab Version 850
%  Built Tue Jan  3 13:20:38 EST 2006
%  This is Copyrighted Material
%  For Copying permissions see COPYING.m
%  Comments? e-mail wavelab@stat.stanford.edu 
