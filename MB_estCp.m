function [yCp,info] = MB_estCp(par,info,t)

if info.vicTp
    [~, indp] = max(info.Cp);
    Tp        = info.tCp(indp);
    par(3)    = Tp - par(2);
end
info = MB_basesCp(par,info);
yCp  = modelCp(par,info,t);

