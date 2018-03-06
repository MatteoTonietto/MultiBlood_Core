function [yCtot,info] = MB_estCtot(par,info,t)

if info.vicTp
    [~, indp] = max(info.Ctot);
    Tp        = info.tCtot(indp);
    par(3)    = Tp - par(2);
end

info = MB_approxCp(par,info);
info = MB_basesCp(par,info);
info = MB_approxCmet(par,info);
info = MB_basesCmet(par,info);

yCtot = modelCtot(par,info,t);

