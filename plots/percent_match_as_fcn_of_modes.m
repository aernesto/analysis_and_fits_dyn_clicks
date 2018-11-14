% scatter plot of percent match as fcn of point estimates of discounting 
% parameter values, for each model pair

clear
base_folder=['/home/adrian/Documents/MATLAB/projects/',...
    'analysis_and_fits_dyn_clicks/'];
point_estimates_db_name=[base_folder,'db_fits.csv'];
percent_match_db_name=[base_folder,'db_PP.csv'];
num_estimates=500; 
num_pairs=4;

for block_size=[100,500]
    bs_str=num2str(block_size);
    
    point_estimates=table2matrix_fetch(point_estimates_db_name,...
        block_size,'disc',[num_estimates,num_pairs]);
    
    percent_match=table2matrix_fetch(percent_match_db_name,...
        block_size,'percent_match',[num_estimates,num_pairs]);
    
    lw=4;
    ms=8;
    fs=20;
    
    % compute correlation coefs
    LL_corr = corrcoef(percent_match(:,1),point_estimates(:,1));
    LL_corr = LL_corr(2,1);
    
    LNL_corr = corrcoef(percent_match(:,2),point_estimates(:,2));
    LNL_corr = LNL_corr(2,1);
    
    NLNL_corr = corrcoef(percent_match(:,3),point_estimates(:,3));
    NLNL_corr = NLNL_corr(2,1);
    
    NLL_corr = corrcoef(percent_match(:,4),point_estimates(:,4));
    NLL_corr = NLL_corr(2,1);
    
    
    plot(point_estimates,percent_match,'o','MarkerSize',8)
    legend({['L-L R=',num2str(LL_corr)],...
        ['L-NL R=',num2str(LNL_corr)],...
        ['NL-NL R=',num2str(NLNL_corr)],...
        ['NL-L R=',num2str(NLL_corr)]},'Location','southoutside')
%    ylim([0.78,.95])
%    xlim([0,20])
    ax=gca;
    ax.FontSize=fs;
    
    figname=['scatter_max_PP_',bs_str];
    savefig([figname,'.fig'])
    saveas(gcf, [figname,'.pdf'])
end