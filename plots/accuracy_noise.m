function accuracy_noise()
global sf fs lw

fig = figure();
fig.OuterPosition=[680 542 2000 528];
%panel A for linear model
ax1=subplot(1,3,1);


data_folder='~/programing/data/clicks/';
panAB_data = load([data_folder,'accuracy_figure_9.mat']);

p1=plot(ax1,panAB_data.disc.lin,panAB_data.acc_store{1},'LineWidth',lw);
yylim=[.5,1];
myyticks=[.5,.7,.9];
ax1.YLim = yylim;

hold on
p2=plot(panAB_data.disc.lin,panAB_data.acc_store{2},'LineWidth',lw);
p3=plot(panAB_data.disc.lin,panAB_data.acc_store{3},'LineWidth',lw);

% vertical lines for maxima
pp1=vline(ax1, panAB_data.disc.lin,panAB_data.acc_store{1}, p1);
pp2=vline(ax1, panAB_data.disc.lin,panAB_data.acc_store{2}, p2);
pp3=vline(ax1, panAB_data.disc.lin,panAB_data.acc_store{3}, p3);

hold off
ax1.YLabel.String = 'accuracy';
ax1.XLabel.String = '\gamma';
ax1.Title.String = 'L';
legend(ax1, ['\sigma=',num2str(panAB_data.noise_vec(1))],...
    ['\sigma=',num2str(panAB_data.noise_vec(2))],...
    ['\sigma=',num2str(panAB_data.noise_vec(3))],...
    'Location','northwest','FontSize',sf)
ax1.FontSize=fs;
ax1.Box = 'off';
ax1.XTick = 0:5:10;
ax1.YTick = myyticks;


% arrow
x_unnorm = [2 pp3.XData(1)];
y_unnorm = [0.7 0.75];

x_axis_width = diff(ax1.XLim);
x_axis2fig_ratio = ax1.Position(3);
x_offset = ax1.Position(1);
y_offset = ax1.Position(2);

x_norm = (x_unnorm / x_axis_width) * x_axis2fig_ratio + x_offset;
y_norm = y_unnorm - ax1.YLim(1) + y_offset;

annotation(fig,'textarrow',x_norm,y_norm,'String','max', 'FontSize',sf)



% panel B for nonlinear model
ax2=subplot(1,3,2);
p4=plot(ax2, panAB_data.disc.nonlin,panAB_data.acc_store{4},'LineWidth',lw);

ax2.YLim = yylim;

hold on

p5=plot(ax2, panAB_data.disc.nonlin,panAB_data.acc_store{5},'LineWidth',lw);
p6=plot(ax2, panAB_data.disc.nonlin,panAB_data.acc_store{6},'LineWidth',lw);

pp4=vline(ax2, panAB_data.disc.nonlin,panAB_data.acc_store{4}, p4);
pp5=vline(ax2, panAB_data.disc.nonlin,panAB_data.acc_store{5}, p5);
pp6=vline(ax2, panAB_data.disc.nonlin,panAB_data.acc_store{6}, p6);

hold off
ax2.XLabel.String = 'h';
ax2.Title.String = 'NL';
legend(ax2,['\sigma=',num2str(panAB_data.noise_vec(1))],...
    ['\sigma=',num2str(panAB_data.noise_vec(2))],...
    ['\sigma=',num2str(panAB_data.noise_vec(3))],...
    'Location','northwest','FontSize',sf)

% arrow
x_unnorm = [0.7 pp4.XData(1)];
y_unnorm = [0.7 0.75];

x_axis_width = diff(ax2.XLim);
x_axis2fig_ratio = ax2.Position(3);
x_offset = ax2.Position(1);
y_offset = ax2.Position(2);

x_norm = (x_unnorm / x_axis_width) * x_axis2fig_ratio + x_offset;
y_norm = y_unnorm - ax2.YLim(1) + y_offset;

annotation(fig,'textarrow',x_norm,y_norm,'String','max', 'FontSize',sf)

ax2.FontSize=fs;
ax2.Box = 'off';
ax2.XTick = 0:0.5:1.5;
ax2.YTick = myyticks;

% save figure
%savefig('accuracy_figure_9.fig')
end