function info = MB_def_config(info)

if nargin < 1
    info = struct();
end

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
vicTp      = 0;         % Tp is fixed to Tp - t0
vincYp     = 1;         % higher weight on Yp (weight * 20)
PPf0       = 0;         % PPf can start from a value different than 1
extraMet   = 0;         % extra regressors for Cmet
vinct1     = 0;         % t1 is fixed to 0

CmetEst   = 'SBL';        % 'NNLS'   or 'SBL'
CmetModel = 'Simple';     % 'Simple' or 'SimpleFeng'

%% Options MB_basesCp
%--------------------------------------------------------------------------
lambda1 = 0.0001;
ncompl  = 500;

%% Options MB_basesCmet
%--------------------------------------------------------------------------
beta1  = 10^-6;
beta2  = 0.2;
ncompb = 200;

%% Options MB_p0Cp
%--------------------------------------------------------------------------
alpha01 = 1;
alpha02 = 50;
ncompa0 = 20;

%% Fill
%--------------------------------------------------------------------------
try info.appCmet;       catch, info.appCmet   = appCmet;    end
try info.vicTp;         catch, info.vicTp     = vicTp;      end
try info.vincYp;        catch, info.vincYp    = vincYp;     end
try info.PPf0;          catch, info.PPf0      = PPf0;       end
try info.extraMet;      catch, info.extraMet  = extraMet;   end
try info.vinct1;        catch, info.vinct1    = vinct1;     end
try info.CmetEst;       catch, info.CmetEst   = CmetEst;    end
try info.CmetModel;     catch, info.CmetModel = CmetModel;  end
try info.beta1;         catch, info.beta1     = beta1;      end
try info.beta2;         catch, info.beta2     = beta2;      end
try info.ncompb;        catch, info.ncompb    = ncompb;     end
try info.lambda1;       catch, info.lambda1   = lambda1;    end
try info.ncompl;        catch, info.ncompl    = ncompl;     end
try info.alpha01;       catch, info.alpha01   = alpha01;    end
try info.alpha02;       catch, info.alpha02   = alpha02;    end
try info.ncompa0;       catch, info.ncompa0   = ncompa0;    end
