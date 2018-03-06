function [par_Cp,info_Cp,est_Cp] = MB_fitCp(info,p0)

info = MB_def_config(info);

% initial parameters
if nargin < 2
    [p0,pup,pdown] = MB_p0Cp(info);
else
    pup   = inf(size(p0));
    pdown = zeros(size(p0)); 
end

% constraints
if info.vincYp
    [~, indp]      = max(info.Cp);
    info.wCp(indp) = 20.*info.wCp(indp);
end
if info.vicTp
    est.options.adj_par = logical([1;1;0]);
end

% gradient search for l0,t0,T
est.FUN             = 'MB_estCp';
est.fixed_par       = info;
est.data            = info.Cp;
est.time            = info.tCp;
est.weights         = info.wCp;
est.p0              = p0;
est.pup             = pup;
est.pdown           = pdown;
est.options.Display = 'iter';
% est.options.plot = 1;

est_Cp = SingleSubjectModelFit(est);

par_Cp  = est_Cp.par;
info_Cp = MB_basesCp(par_Cp,info);

if info.vicTp
    [~, indp] = max(info.Cp);
    Tp        = info.tCp(indp);
    par_Cp(3) = Tp - par_Cp(2);
end