% reproduce error plots in parameter space with MATLAB instead of R
clear

% import data
abs = readtable('/home/adrian/programing/data/clicks/abs_error_data.csv');
rel = readtable('/home/adrian/programing/data/clicks/rel_error_data.csv');

% sort rows by trial_nb
abs = sortrows(abs, {'trial_nb'});
rel = sortrows(rel, {'trial_nb'});

% produce plots
sf=17 * .8; fs=20; lw=3; xlims = [95, 505];

fig = figure();
fig.OuterPosition=[680 542 966 528];

%panel C for absolute error
ax1=subplot(1,2,1);

combinations = {'NL-NL','NL-L','L-NL','L-L'};
color_names = {'kelley green','faded orange','electric pink','ultramarine blue'};

curr_table = abs;
for c = 1:length(combinations)
    rows_bool = (strcmp(curr_table.model_pair, combinations{c}));
    semilogy(curr_table.trial_nb(rows_bool),...
        curr_table.error(rows_bool),'LineWidth',lw, ...
        'Color', rgb(color_names{c}));
    if c == 1
        hold on
    elseif c == 4
        hold off
    end
end

%ylim=[.5,1];
myyticks=[.1,1,10];
%ax1.YLim = ylim;
ax1.XLim = xlims;

ylabel('abs. error')
xlabel('trial nb')
% title('L')
% legend(combinations, 'Location','northeast','FontSize',sf)
ax1.FontSize=fs;
ax1.Box = 'off';
% xticks(0:5:10)
yticks(myyticks)


% panel D for relative error
ax2=subplot(1,2,2);

curr_table = rel;
for c = 1:length(combinations)
    rows_bool = (strcmp(curr_table.model_pair, combinations{c}));
    semilogy(curr_table.trial_nb(rows_bool),...
        curr_table.error(rows_bool),'LineWidth',lw,...
        'Color', rgb(color_names{c}));
    if c == 1
        hold on
    elseif c == 4
        hold off
    end
end


%ax2.YLim = ylim;

ax2.XLim = xlims;

xlabel('trial nb')
ylabel('rel. error')
legend(combinations,...
    'Location','northeast','FontSize',sf)


ax2.FontSize=fs;
ax2.Box = 'off';
%xticks(0:0.5:1.5)
%yticks(myyticks)


% change color schemes
colormap(ax1, spring)
colormap(ax2, spring)

% save figure
savefig('errors.fig')