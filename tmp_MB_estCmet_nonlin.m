function [yCmet,info] = MB_estCmet_nonlin(par,info,t)

B  = par(5);
b1 = par(6); 
b2 = par(7);

info.B_good(1) = B;
info.B_good(2) = -B;
info.b_good    = [b1;b2];

yCmet = modelCmet(par,info,t);