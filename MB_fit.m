function [par,info,info_Cp] = MB_fit(info)

info = MB_def_config(info);
plotpause = 1;         

%% 1 yCpi
disp('1 yCpi')

info = MB_approxCp([],info);

[par_Cp,info_Cp,est_Cp] = MB_fitCp(info);

if plotpause
    figure(1)
    tv = [0 : 0.01 : est_Cp.time(end)]';
    plotEst(est_Cp,tv);
    pause
end

%% 2 yCmet
disp('2 yCmet')

info = MB_approxCmet(par_Cp,info_Cp);

[par_PPf,info_PPf,est_Cmet] = MB_fitCmet(info,par_Cp);

if plotpause
    figure(2)
    tv = [0:0.01:est_Cp.time(end)]';
    if info.vinct1
        hold on
        plot(tv, modelCmet(par_Ctot,info,tv), 'm')
        title(num2str(par_Ctot'))
        hold off
    else
        plotEst(est_Cmet,tv);
    end
    pause
end


%% 3 yCp
disp('3 yCp')

par = par_Ctot;

info_Cp = MB_approxCp(par,info);
if info_Cp.vincYp
    info_Cp.wCp(indp) = 20.*info_Cp.wCp(indp);
end

info_Cp = basesCp(par,info_Cp);

if plotpause
    tv = [0:0.01:est_Cp.time(end)]';
    
    figure(1)
    subplot(211)
    plot(info.tCtot,info.Ctot,'o')
    hold on
    %             plot(tv, modelCtot(par_Ctot,info,tv), 'r')
    plot(tv, modelCp(par_Ctot,info_Cp,tv)./modelPPf(par_Ctot,info,tv), 'r')
    plot(tv, modelCp(par_Ctot,info_Cp,tv),   'g')
    plot(tv, modelCmet(par_Ctot,info,tv), 'm')
    title(num2str(par_Ctot'))
    hold off
    
    subplot(212)
    plot(info.tPPf, info.PPf,'o')
    hold on
    plot(tv, modelPPf(par_Ctot,info,tv),'r')
    yPPf = interp1([0;info.tPPf],[1;info.PPf],info.tCtot,'linear','extrap');
    plot(info.tCtot,yPPf,'g')
    hold off
    pause
end
