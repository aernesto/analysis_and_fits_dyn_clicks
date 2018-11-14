% plots whiskers to illustrate spread of point estimates for the discounting parameters
% point estimates are either the modes of the posteriors 
% or the value that maximizes percent match

clear

lw=3;
ms=8;
fs=20;

true_h=1;
true_g= 6.7457;

for block_size=100%,500]
    % for posterior modes
    %load(['../data/mse_nonlin_fig4_iteration2_',num2str(block_size),'trials.mat'])
    %load(['../data/mse_lin_fig4_iteration2_',num2str(block_size),'trials.mat'])
    % for values that maximize percent match
    raw_table=readtable('db_fits.csv');
    % recall col names: fit_id,db_name,trial_start,trial_stop,num_trials,script_name,commit,fit_model,ref_model,disc,fit_method
    rows_linlin = strcmp(raw_table.ref_model,'lin') & ...
    		  strcmp(raw_table.fit_model,'lin') & ...
		  strcmp(raw_table.fit_method,'max_pp') & ...
		  raw_table.num_trials==block_size ;
    rows_linnonlin = strcmp(raw_table.ref_model,'nonlin') & ...
    		  strcmp(raw_table.fit_model,'lin') & ...
		  strcmp(raw_table.fit_method,'max_pp') & ...
		  raw_table.num_trials==block_size ;
    rows_nonlinlin = strcmp(raw_table.ref_model,'lin') & ...
    		  strcmp(raw_table.fit_model,'nonlin') & ...
		  strcmp(raw_table.fit_method,'max_pp') & ...
		  raw_table.num_trials==block_size ;
    rows_nonlinnonlin = strcmp(raw_table.ref_model,'nonlin') & ...
    		  strcmp(raw_table.fit_model,'nonlin') & ...
		  strcmp(raw_table.fit_method,'max_pp') & ...
		  raw_table.num_trials==block_size ;
    modes=[raw_table.disc(rows_linlin),...
     	   raw_table.disc(rows_linnonlin),...
	   raw_table.disc(rows_nonlinnonlin),...
	   raw_table.disc(rows_nonlinlin)];
    
    boxplot(modes)
    set(findobj(gca,'type','line'),'linew',lw)
    set(gca,'linew',lw/2)
    
    hold on
    ax=gca;
    plot([ax.XLim(1), ax.XLim(2)],[true_g,true_g],'LineWidth',lw/1.5)
    plot([ax.XLim(1),ax.XLim(2)],[true_h,true_h],'LineWidth',lw/1.5)
    hold off
    
    %ax.XTickLabels=['L-L','L-NL','NL-NL','NL-L'];
    ylim([0,19])
    ax.FontSize=fs;
    saveas(gcf, ['whiskers_max_PP_point_estimates_',num2str(block_size),'.pdf'])
end
