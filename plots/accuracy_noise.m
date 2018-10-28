%% load workspace
data_folder='~/programing/data/clicks/';
load([data_folder,'accuracy_figure_1.mat'])
%%
sf=17; fs=20; lw=3;
%panel A for linear model
ax1=subplot(1,2,1);
plot(disc.lin,acc_store{1},'LineWidth',lw)
hold on
plot(disc.lin,acc_store{2},'LineWidth',lw)
plot(disc.lin,acc_store{3},'LineWidth',lw)
hold off
ylabel('accuracy')
xlabel('\gamma')
title('L')
legend(['\sigma=',num2str(noise_vec(1))],...
    ['\sigma=\kappa=',num2str(noise_vec(2))],...
    ['\sigma=2\kappa=',num2str(noise_vec(3))],...
    'Location','south','FontSize',sf)
ax1.FontSize=fs;

% panel B for nonlinear model
ax2=subplot(1,2,2);
plot(disc.nonlin,acc_store{4},'LineWidth',lw)
hold on
plot(disc.nonlin,acc_store{5},'LineWidth',lw)
plot(disc.nonlin,acc_store{6},'LineWidth',lw)
hold off
xlabel('h')
title('NL')
legend(['\sigma=',num2str(noise_vec(1))],...
    ['\sigma=\kappa=',num2str(noise_vec(2))],...
    ['\sigma=2\kappa=',num2str(noise_vec(3))],...
    'Location','south','FontSize',sf)
ax2.FontSize=fs;