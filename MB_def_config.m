function info = MB_def_config()


%% Approximation used for Cmet
%--------------------------------------------------------------------------
% They can be used in conjunction:
%
% Cmet = Ctot*(1-PPf)           % 1
% Cmet = Ctot - yCp             % 2
% Cmet = (1/PPf - 1)*yCp        % 3

appCmet = [0;0;3];

%% Other options
%--------------------------------------------------------------------------
vicTp      = 0;         % Tp is fixed
vincYp     = 1;         % higher weight on Yp (weight * 20)
PPf0       = 0;         % PPf can start from a value different than 1
extraMet   = 0;         % extra regressors for Cmet
vinct1     = 0;         % t1 is fixed to 0

CmetEst   = 'SBL';        % 'NNLS'   or 'SBL'
CmetModel = 'Simple';     % 'Simple' or 'SimpleFeng'

%% Pack
%--------------------------------------------------------------------------
info.appCmet   = appCmet;
info.vicTp     = vicTp;
info.vincYp    = vincYp;
info.PPf0      = PPf0;
info.extraMet  = extraMet;
info.vinct1    = vinct1;

info.CmetEst   = CmetEst;
info.CmetModel = CmetModel;