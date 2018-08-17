function DefaultInput  = GetDefaultInputInitialize
%  Called by few of the *Initialize* methods to create default input
%
% See also: 
%   DynamicProcessInitialize, FlexIO
%
% Created:
% Lev Muchnik    06/03/2012
%
DefaultInput = {};
DefaultInput    =   FIOAddParameter(DefaultInput,'RandomSeed',[]);
DefaultInput    =   FIOAddParameter(DefaultInput,'ShuffleNodes',true);
DefaultInput    =   FIOAddParameter(DefaultInput,'UserData',[]);

end % GetDefaultInputInitialize
