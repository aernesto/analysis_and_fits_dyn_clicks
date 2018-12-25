function pcolor_PP(model_pair, data_folder, data_file_name, noiseVal, saveFlag)
% produce heatmaps for predictive power
% ARGS:
%   model_pair: 'L-L' or 'NL-NL'
%   data_folder: e.g. '~/programing/data/clicks/'
%   data_file_name: e.g.
%       'joint_PP_LL_ntrials_999990_noise_0.1.mat
%       'joint_PP_LL_ntrials_999990_noise_1.mat'
%       'joint_PP_LL_ntrials_999990_noise_2.mat'
%       'joint_PP_NLNL_ntrials_999990_noise_0.1.mat'
%       'joint_PP_NLNL_ntrials_999990_noise_1.mat'
%       'joint_PP_NLNL_ntrials_999990_noise_2.mat'
%   noiseVal: e.g. 0.1 or 1 or 2  % used for plot label
%   saveFlag: true or false % if true, saves figures to files

fs=20; % font size
lw=3; % linewidth

SS = load([data_folder,data_file_name]);

[X,Y]=meshgrid(SS.thetas_1,SS.thetas_2);
num_x=length(SS.thetas_1);

[A,B]=max(SS.PP);
th1max=zeros(size(B));
for i=1:length(B)
    th1max(i)=SS.thetas_1(B(i));
end

% set the upper-left part of the domain to 1 so that it gets plotted in
% white in the colormap
%for i=1:num_g
%    for j=1:i-1
%        PP(i,j)=1;
%    end
%end

% set cutoff values for colormap
%nonZeros = find(PP);
absMax = 1;% max(max(PP));
absMin = .5; %min(min(PP(nonZeros)));

% ------------- run once with colorbar -------------------%
fig1 = figure(1); 
ax1=gca; 
pc=pcolor(ax1,X,Y,SS.PP);

% remove grid overlayed on plot
set(pc,'EdgeColor','None')

% set the interval of values outside of which the colormap is constant
caxis([absMin,absMax])

% add colorbar
hhh = colorbar('XTick',[.5,1]);
ylabel(hhh,'PP')
ax1.FontSize = fs;

% set the colormap for the heatmap
cmap = colormap('copper');
%cmap(end,:) = [1,1,1];
colormap(cmap)

% ------- run a second time without colorbar -------------%

fig2 = figure(2); 
ax1=gca;
pc=pcolor(ax1,X,Y,SS.PP);

% remove grid overlayed on plot
set(pc,'EdgeColor','None')

% set the interval of values outside of which the colormap is constant
caxis([absMin,absMax])

% add colorbar
% hhh = colorbar('XTick',[.5,1]);
% ylabel(hhh,'PP')

% set the colormap for the heatmap
cmap = colormap('copper');
%cmap(end,:) = [1,1,1];
colormap(cmap)

hold on

% plot ridge
plot(ax1,SS.thetas_1,th1max,'LineWidth',lw,'Color','red')
%plot(ax1,th1max,thetas_1,'LineWidth',lw,'Color','red')

% plot diagonal
plot(SS.thetas_1,SS.thetas_1,'--r','LineWidth',lw-1)
hold off

% set y-axis on the right
set(ax1,'YAxisLocation','right')
title([model_pair,' noise=',num2str(noiseVal)])
if strcmp(model_pair,'L-L')
    xlabel('\gamma_1')
    ax1.XAxis.TickValues=0:5:10;
    ylabel('\gamma_2')
    ax1.YAxis.TickValues = 0:5:10;
elseif strcmp(model_pair,'NL-NL')
    xlabel('h_1')
    ax1.XAxis.TickValues=[0,2.5];
    ylabel('h_2')
    ax1.YAxis.TickValues = [0,2.5];
end
ax1.FontSize=fs;

% --------------------------------------------%


% for i=1:num_x
%     for j=1:i-1
%         PP(i,j)=PP(j,i);
%     end
% end

% 
% [A,B]=max(PP);
% th1max=zeros(size(B));
% for i=1:length(B)
%     th1max(i)=thetas_1(B(i));
% end

% produce inset
fig3 = figure(3);
plot(SS.thetas_1,A, '-r', 'LineWidth',lw)
hold on 
plot(SS.thetas_1, diag(SS.PP), '--r', 'LineWidth', lw)
hold off
ylabel('PP')
ylim([absMin, absMax])
yticks([.5,.8,.9,1])
if strcmp(model_pair,'L-L')
    xlim([0,10])
    xticks([0,10])
elseif strcmp(model_pair,'NL-NL')
    xlim([0,2.5])
    xticks([0,2.5])
end

legend('max','diag','Location','southeast')
ax=gca; ax.FontSize=fs;

% ------ save to file
if saveFlag
    figNum = '1';
    fileNameForSave = ['fig',figNum,model_pair,num2str(noiseVal),'.png'];
    saveas(fig1, fileNameForSave)
    figNum = '2';
    fileNameForSave = ['fig',figNum,model_pair,num2str(noiseVal),'.png'];
    saveas(fig2, fileNameForSave)
    figNum = '3';
    fileNameForSave = ['fig',figNum,model_pair,num2str(noiseVal),'.png'];
    saveas(fig3, fileNameForSave)
end