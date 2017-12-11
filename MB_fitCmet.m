function [par_PPf,info_PPf,est_Cmet] = MB_fitCmet(info,p0)

info = MB_def_config(info);

% initial parameters
if length(p0) < 4
    p0 = [p0;0];
end

% gradient search for initial value of t1, (b0)
if info.vinct1
    par_PPf  = p0;
    est_Cmet = [];
else
    est.p0              = p0;
    est.options.adj_par = logical([0;0;0;1]);
     
    est.FUN       = 'MB_estCmet';
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
    par_PPf  = est_Cmet.par;
end

info_PPf = MB_basesCmet(par_PPf,info);
