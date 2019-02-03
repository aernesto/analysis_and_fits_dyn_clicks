% plots whiskers to illustrate spread of point estimates for the discounting parameters
% point estimates are either the modes of the posteriors
% or the value that maximizes percent match

clear

lw=3;
ms=8;
fs=20;

true_h=1; NL_YLim = [0,5];
true_g= 6.7457; L_YLim = [0,20];
dataFolder='/home/adrian/programing/data/clicks/fits/';
block_size={100,500};

% for posterior modes
smallNonlinData=load([dataFolder,'mse_nonlin_fig4_iteration2_',num2str(block_size{1}),'trials.mat']);
smallLinData=load([dataFolder,'mse_lin_fig4_iteration2_',num2str(block_size{1}),'trials.mat']);
largeNonlinData=load([dataFolder,'mse_nonlin_fig4_iteration2_',num2str(block_size{2}),'trials.mat']);
largeLinData=load([dataFolder,'mse_lin_fig4_iteration2_',num2str(block_size{2}),'trials.mat']);
modes_lin = [smallLinData.modes_linlin; largeLinData.modes_linlin;...
    smallLinData.modes_linnonlin; largeLinData.modes_linnonlin]';
modes_nonlin = [smallNonlinData.modes_nonlinnonlin;largeNonlinData.modes_nonlinnonlin;...
    smallNonlinData.modes_nonlinlin; largeNonlinData.modes_nonlinlin]';
% for values that maximize percent match
%raw_table=readtable('db_fits.csv');
% recall col names: fit_id,db_name,trial_start,trial_stop,num_trials,script_name,commit,fit_model,ref_model,disc,fit_method
%     rows_linlin = strcmp(raw_table.ref_model,'lin') & ...
%     		  strcmp(raw_table.fit_model,'lin') & ...
% 		  strcmp(raw_table.fit_method,'max_pp') & ...
% 		  raw_table.num_trials==block_size ;
%     rows_linnonlin = strcmp(raw_table.ref_model,'nonlin') & ...
%     		  strcmp(raw_table.fit_model,'lin') & ...
% 		  strcmp(raw_table.fit_method,'max_pp') & ...
% 		  raw_table.num_trials==block_size ;
%     rows_nonlinlin = strcmp(raw_table.ref_model,'lin') & ...
%     		  strcmp(raw_table.fit_model,'nonlin') & ...
% 		  strcmp(raw_table.fit_method,'max_pp') & ...
% 		  raw_table.num_trials==block_size ;
%     rows_nonlinnonlin = strcmp(raw_table.ref_model,'nonlin') & ...
%     		  strcmp(raw_table.fit_model,'nonlin') & ...
% 		  strcmp(raw_table.fit_method,'max_pp') & ...
% 		  raw_table.num_trials==block_size ;
%     modes=[raw_table.disc(rows_linlin),...
%      	   raw_table.disc(rows_linnonlin),...
% 	   raw_table.disc(rows_nonlinnonlin),...
% 	   raw_table.disc(rows_nonlinlin)];

%%%%%%%%%%%%% M_FIT = L %%%%%%%%%%%%%%%%
figure(1)
boxplot(modes_lin)
set(findobj(gca,'type','line'),'linew',lw)
set(gca,'linew',lw/2)
dimL = [.25 .6 .25 .25];
dimR = [.65 .6 .25 .25];
hold on
ax=gca;
plot([ax.XLim(1), ax.XLim(2)],[true_g,true_g],'LineWidth',lw/1.5)
plot([2.5,2.5],L_YLim,'LineWidth',lw/1.5,'Color','black')
annotation('textbox',dimL,...
    'String','m_{ref}=L',...
    'EdgeColor',[1,1,1],...
    'FontSize',fs);
annotation('textbox',dimR,...
    'String','m_{ref}=NL',...
    'EdgeColor',[1,1,1],...
    'FontSize',fs);
hold off

%ax.XTickLabels=['L-L','L-NL','NL-NL','NL-L'];
ylim(L_YLim)
ax.FontSize=fs; ax.Box='off';
title('m_{fit} = L')
ylabel('Fits of \gamma')
yticks([0,10,20])
xlabel('Number of trials')
xticks([1,2,3,4]);
xticklabels({'100','500','100','500'});


saveas(gcf, 'Fig_4C_1.pdf')

%%%%%%%%%%%%% M_FIT = NL %%%%%%%%%%%%%%%%
figure(2)

boxplot(modes_nonlin)
set(findobj(gca,'type','line'),'linew',lw)
set(gca,'linew',lw/2)

hold on
ax=gca;
plot([ax.XLim(1),ax.XLim(2)],[true_h,true_h],'LineWidth',lw/1.5)
plot([2.5,2.5],NL_YLim,'LineWidth',lw/1.5,'Color','black')
annotation('textbox',dimL,...
    'String','m_{ref}=NL',...
    'EdgeColor',[1,1,1],...
    'FontSize',fs);
annotation('textbox',dimR,...
    'String','m_{ref}=L',...
    'EdgeColor',[1,1,1],...
    'FontSize',fs);
hold off
ylabel('Fits of h')
xlabel('Number of trials')
xticks([1,2,3,4]);
yticks([0,1,5])
xticklabels({'100','500','100','500'});
ylim(NL_YLim)
ax.FontSize=fs; ax.Box='off';
title('m_{fit} = NL')
saveas(gcf,'Fig_4C_2.pdf')

