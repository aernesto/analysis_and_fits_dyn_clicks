% this is the final script to produce figure 4
% it merges 'accuracy_noise.m' and 'error_param_space.m'

clear
global sf fs lw
sf=17 * .8; 
fs=20; 
lw=3;




%==============----- PANELS A & B ------====================&
accuracy_noise()

%==============----- PANEL C ------====================&
ax3=subplot(1,3,3);


% reproduce error plots in parameter space with MATLAB instead of R

% import data
%abs = readtable('/home/adrian/programing/data/clicks/abs_error_data.csv');
rel = readtable('/home/adrian/programing/data/clicks/rel_error_data.csv');

% sort rows by trial_nb
%abs = sortrows(abs, {'trial_nb'});
rel = sortrows(rel, {'trial_nb'});

% produce plots
%sf=17 * .8; fs=20; lw=3; 
xlims = [95, 505];

%fig = figure();
%fig.OuterPosition=[680 542 966 528];

%ylim=[.5,1];
myyticks=[.1,1,10];
combinations = {'NL-NL','NL-L','L-NL','L-L'};
color_names = {'kelley green','faded orange','electric pink','ultramarine blue'};


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

ax3.XLim = xlims;

xlabel('trial nb')
ylabel('rel. error')
legend(combinations,...
    'Location','northeast','FontSize',sf)


ax3.FontSize=fs;
ax3.Box = 'off';
%xticks(0:0.5:1.5)
%yticks(myyticks)


colormap(ax3, spring)

%adjust horizontal offset of 3rd axis
xoff = .23*.1;
ax3.OuterPosition = ax3.OuterPosition + [xoff,0,0,0];
% and yet more fine tuning
old = ax3.OuterPosition;
ax3.OuterPosition = old + [0.001,0.045,0.009,-0.0564];

% save figure
