function [lo] = card(x, varargin)
% [lo] = card(x, [thresh])
% to return the cardinality of the vector using a certain threshold
% default threshold is 1e-12;

%   Copyright 2012, David Strauss
%   See the file COPYING.txt for full copyright information.

if nargin > 1
    th = varargin{1};
else
    th = 1e-12;
end

lo = sum(abs(x) > th);
