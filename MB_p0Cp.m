function [p0,pup,pdown] = MB_p0Cp(info)

%% Grid search settings for alpha0
%--------------------------------------------------------------------------
alpha0_max = info.alpha01;
alpha0_min = info.alpha02;
N_elements = info.ncompa0;

%% initial parameters t0, T
%--------------------------------------------------------------------------
[~, indp] = max(info.Cp);
Tp        = info.tCp(indp);
t0        = t0Estimation(info.tCp,info.Cp);
T         = Tp - t0;

%% Grid search for initial value of l0
%--------------------------------------------------------------------------
l0grid  = fliplr(logspace(log10(alpha0_max),log10(alpha0_min),N_elements));

par0_Cp = [l0grid;repmat(t0,1,length(l0grid));repmat(T,1,length(l0grid))];

if info.vincYp
    info.wCp(indp) = 20.*info.wCp(indp);
end

est.FUN       = 'MB_estCp';
est.fixed_par = info;
est.data      = info.Cp;
est.time      = info.tCp;
est.weights   = info.wCp;
est.p0        = par0_Cp;
est.pup       = inf(size(est.p0));
est.pdown     = zeros(size(est.p0));

est.options.plot        = 0;
est.options.Jac         = 'off';
est.options.Display     = 'off';
est.options.MaxFunEvals = 1;

est_Cp = SingleSubjectModelFit(est);

%% Results
%--------------------------------------------------------------------------
p0 = est_Cp.par;

if nargout > 1
    pup    = inf(size(p0));
    pup(1) = p0(1)*1.2;
    pdown  = zeros(size(p0));
end
