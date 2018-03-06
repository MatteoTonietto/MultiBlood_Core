function [par_PPf,info_PPf] = MB_fitPPf_nonlin(info)

info = MB_def_config(info);      

info = MB_approxCp([],info);
[par,info] = MB_fitCp(info);

info = MB_approxCmet(par,info);
[par_PPf,info_PPf] = MB_fitCmet_nonlin(info,par);


    