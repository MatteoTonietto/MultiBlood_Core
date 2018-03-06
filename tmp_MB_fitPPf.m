function [par_PPf,info_PPf] = MB_fitPPf(info)

info = MB_def_config(info);      

info = MB_approxCp([],info);
[par,info] = MB_fitCp(info);

info = MB_approxCmet(par,info);
[par,info] = MB_fitCmet(info,par);

% constraints
if info.vincYp
    [~, indp]      = max(info.Ctot);
    info.wCtot(indp) = 20.*info.wCtot(indp);
end
if info.vicTp
    est.options.adj_par = logical([1;1;0]);
end

% gradient search for l0,t0,T
est.FUN             = 'MB_estCtot';
est.fixed_par       = info;
est.data            = info.Ctot;
est.time            = info.tCtot;
est.weights         = info.wCtot;
est.p0              = par;
est.pup             = inf(size(par));
est.pdown           = zeros(size(par));
est.options.Display = 'iter';
est.options.plot    = true;

est = SingleSubjectModelFit(est);

par_PPf  = est.par;

if info.vicTp
    [~, indp]  = max(info.Ctot);
    Tp         = info.tCtot(indp);
    par_PPf(3) = Tp - par(2);
end

info = MB_approxCp(par_PPf,info);
info = MB_basesCp(par_PPf,info);
info = MB_approxCmet(par_PPf,info);
info_PPf = MB_basesCmet(par_PPf,info);

figure(2)
plot(info.tPPf,info.PPf,'o')
hold on
tv=[0:90]';
plot(tv,modelPPf(par_PPf,info_PPf,tv))
hold off
pause