function [par_Cp,info_Cp,par_PPf,info_PPf,est_Cp,est_Cmet] = MB_fit(info)

info = MB_def_config(info);

plotpause = 0;         

%% 1 yCpi
disp('1 yCpi')

info = MB_approxCp([],info);

[par_Cp0,info_Cp0,est_Cp0] = MB_fitCp(info);

if plotpause
    figure(1)
    tv = [0 : 0.01 : est_Cp0.time(end)]';
    plotEst(est_Cp0,tv);
    pause
end

%% 2 yCmet
disp('2 yCmet')

info = MB_approxCmet(par_Cp0,info_Cp0);

[par_PPf,info_PPf,est_Cmet] = MB_fitCmet(info,par_Cp0);

if plotpause
    figure(2)
    tv = [0:0.01:est_Cp0.time(end)]';
    if info.vinct1
        hold on
        plot(tv, modelCmet(par_PPf,info_PPf,tv), 'm')
        title(num2str(par_PPf'))
        hold off
    else
        plotEst(est_Cmet,tv);
    end
    pause
end


%% 3 yCp
disp('3 yCp')

info = MB_approxCp(par_PPf,info_PPf);

[par_Cp,info_Cp,est_Cp] = MB_fitCp(info,par_Cp0);


if plotpause
    tv = [0:0.01:est_Cp.time(end)]';
    
    figure(1)
    subplot(211)
    plot(info.tCtot,info.Ctot,'o')
    hold on
    plot(tv, modelCp(par_Cp,info_Cp,tv)./modelPPf(par_PPf,info_PPf,tv), 'r')
    plot(tv, modelCp(par_Cp,info_Cp,tv),   'g')
    plot(tv, modelCmet(par_PPf,info_PPf,tv), 'm')
    title(num2str(par_Cp'))
    hold off
    
    subplot(212)
    plot(info.tPPf, info.PPf,'o')
    hold on
    plot(tv, modelPPf(par_PPf,info_PPf,tv),'r')
    yPPf = interp1([0;info.tPPf],[1;info.PPf],info.tCtot,'linear','extrap');
    plot(info.tCtot,yPPf,'g')
    hold off
end
