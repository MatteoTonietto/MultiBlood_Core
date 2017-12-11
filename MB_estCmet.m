function [yCmet,info] = MB_estCmet(par,info,t)

info  = MB_basesCmet(par,info);
yCmet = modelCmet(par,info,t);