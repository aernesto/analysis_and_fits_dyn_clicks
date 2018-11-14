% produces whisker plots for predictive power
clear
%a=load('../data/choice_match_100_4.mat');
%b=load('../data/choice_match_500_4.mat');
c=readtable('db_PP.csv');
files={c};%{a,b,c};
lw=4;
ms=8;
fs=20;
nf=length(files);
TN=500;
for f=1:nf
    % the 'match' variable is a 500-by-4 matrix where columns correspond to
    % model pairs as follows: 1 = LL; 2 = L-NL; 3 = NL-NL; 4 = NL-L
    file=files{f};
    if istable(file)
        row1=strcmp(file.ref_model,'lin') & strcmp(file.fit_model,'lin')...
            & file.num_trials == TN;
        col1=file.percent_match(row1);
        row2=strcmp(file.ref_model,'nonlin') & strcmp(file.fit_model,'lin')...
            & file.num_trials == TN;
        col2=file.percent_match(row2);
        row3=strcmp(file.ref_model,'nonlin') & strcmp(file.fit_model,'nonlin')...
            & file.num_trials == TN;
        col3=file.percent_match(row3);
        row4=strcmp(file.ref_model,'lin') & strcmp(file.fit_model,'nonlin')...
            & file.num_trials == TN;
        col4=file.percent_match(row4);
        match=[col1,col2,col3,col4];
    else
        match=file.match;
    end
    boxplot(match)
    set(findobj(gca,'type','line'),'linew',lw)
    set(gca,'linew',lw/2)
    hold on
    ax=gca;
    % following 2 lines obtained according to a semi-analytic computation of PP
    % see this: https://paper.dropbox.com/doc/Stochastic-model-fitting--AQaIWItutGd8COdK0FeOLVwTAg-URuXW5PKABizdbMJB4Bkb#:h2=Report
    plot([ax.XLim(1), ax.XLim(2)],[.8787,.8787],'LineWidth',lw/2)
    plot([ax.XLim(1),ax.XLim(2)],[.86277248,0.86277248],'LineWidth',lw/2)
    hold off
    %ax.XTickLabels=['L-L','L-NL','NL-NL','NL-L'];
    %ylim([.79,.92])
    ax.FontSize=fs;
    saveas(gcf, ['whiskers_max_PP_percent_match',num2str(TN),'.pdf'])
end