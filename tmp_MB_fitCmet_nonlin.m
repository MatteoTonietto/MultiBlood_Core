function [par_PPf,info,est_Cmet] = MB_fitCmet_nonlin(info,p0)

info = MB_def_config(info);

% initial parameters
if length(p0) < 4
    p0 = [p0;0;0.1;0.01;0.01];
end

est.p0              = p0;
est.options.adj_par = logical([0;0;0;1;1;1;1]);
if info.vinct1
    est.options.adj_par(4) = false;
end

est.FUN       = 'MB_estCmet_nonlin';
est.fixed_par = info;
est.data      = info.Cmet;
est.time      = info.tCmet;
est.weights   = info.wCmet;
est.pup       = inf(size(est.p0));
est.pdown     = zeros(size(est.p0));

est.options.plot    = 0;
est.options.Jac     = 'off';
est.options.Display = 'iter';

est_Cmet = SingleSubjectModelFit(est);
par_PPf  = est_Cmet.par(1:4);

info.B_good(1) = est_Cmet.par(5);
info.B_good(2) = -est_Cmet.par(5);
info.b_good    = [est_Cmet.par(6);est_Cmet.par(7)];

