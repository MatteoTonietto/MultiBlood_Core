function info = MB_basesCp(par,info)

l0 = par(1);
t0 = par(2);
T  = par(3);

tCp = info.tCp;
Cp  = info.Cp;
wCp = info.wCp;

% Grid Cp
%--------------------------------------------------------------------------
lambda2 = l0*0.99;            
ncompl  = info.ncompl;
    
lambdagrid    = logspace(log10(info.lambda1),log10(lambda2),ncompl)';
lambdagrid(1) = 0;

% Bases
%--------------------------------------------------------------------------
Gp = zeros(length(tCp),ncompl);
aPole = SimplePoleDelayConvRect([l0,t0,T],tCp);
for i = 1 : ncompl
    Gp(:,i) = SimplePoleDelayConvRect([lambdagrid(i),t0,T],tCp) - aPole;
end

% Weights
%--------------------------------------------------------------------------
GWp = Gp .* repmat(wCp,1,size(Gp,2));

% Fit
%--------------------------------------------------------------------------
A = lsqnonneg(GWp,Cp.*wCp);

% Double lines
%--------------------------------------------------------------------------
[A_good, l_good] = DoubleLine(A,lambdagrid);
info.A_good = A_good;
info.l_good = l_good;