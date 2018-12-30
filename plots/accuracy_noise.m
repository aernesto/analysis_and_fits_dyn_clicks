%% load workspace
clear all
data_folder='~/programing/data/clicks/';
load([data_folder,'accuracy_figure_8.mat'])
%%
sf=17 * .8; fs=20; lw=3;

fig = figure();
fig.OuterPosition=[680 542 966 528];
%panel A for linear model
ax1=subplot(1,2,1);
p1=plot(disc.lin,acc_store{1},'LineWidth',lw);
ylim=[.5,1];
myyticks=[.5,.7,.9];
ax1.YLim = ylim;

hold on
p2=plot(disc.lin,acc_store{2},'LineWidth',lw);
p3=plot(disc.lin,acc_store{3},'LineWidth',lw);

% vertical lines for maxima
pp1=vline(disc.lin,acc_store{1}, p1);
pp2=vline(disc.lin,acc_store{2}, p2);
pp3=vline(disc.lin,acc_store{3}, p3);

hold off
ylabel('accuracy')
xlabel('\gamma')
title('L')
legend(['\sigma=',num2str(noise_vec(1))],...
    ['\sigma=',num2str(noise_vec(2))],...
    ['\sigma=',num2str(noise_vec(3))],...
    'Location','northwest','FontSize',sf)
ax1.FontSize=fs;
ax1.Box = 'off';
xticks(0:5:10)
yticks(myyticks)


% arrow
x_unnorm = [2 pp3.XData(1)];
y_unnorm = [0.7 0.75];

x_axis_width = diff(ax1.XLim);
x_axis2fig_ratio = ax1.Position(3);
x_offset = ax1.Position(1);
y_offset = ax1.Position(2);

x_norm = (x_unnorm / x_axis_width) * x_axis2fig_ratio + x_offset;
y_norm = y_unnorm - ax1.YLim(1) + y_offset;

annotation('textarrow',x_norm,y_norm,'String','max', 'FontSize',sf)



% panel B for nonlinear model
ax2=subplot(1,2,2);
p4=plot(disc.nonlin,acc_store{4},'LineWidth',lw);

ax2.YLim = ylim;

hold on

p5=plot(disc.nonlin,acc_store{5},'LineWidth',lw);
p6=plot(disc.nonlin,acc_store{6},'LineWidth',lw);

pp4=vline(disc.nonlin,acc_store{4}, p4);
pp5=vline(disc.nonlin,acc_store{5}, p5);
pp6=vline(disc.nonlin,acc_store{6}, p6);

hold off
xlabel('h')
title('NL')
legend(['\sigma=',num2str(noise_vec(1))],...
    ['\sigma=',num2str(noise_vec(2))],...
    ['\sigma=',num2str(noise_vec(3))],...
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

annotation('textarrow',x_norm,y_norm,'String','max', 'FontSize',sf)

ax2.FontSize=fs;
ax2.Box = 'off';
xticks(0:0.5:1.5)
yticks(myyticks)