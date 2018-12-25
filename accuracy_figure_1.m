% produce accuracy figure described here
% https://paper.dropbox.com/doc/Figure-4-design--APE0_g8NTsvVZxTg2DUyd6WvAg-nlH9WGli5QW8x41ZJbGlJ#:h2=Accuracy-as-function-of-discou
clear
%tbUseProject('analysis_and_fits_dyn_clicks');
data_folder='~/programing/data/clicks/';
dbname=[data_folder,'validation2.h5'];

% bad trials for validation2.h5 dataset (if all trials are fine, set to
% empty vector)
bad_trials=[];%[93737,207048,229626,272270,555142,631387,666886,774387,811388,961053];

% range of trials to use from db
trial_range=[1,500];

% start timer
tic

% noise levels
kappa=log(20/5);
noise_vec=[.1,1,2];

% discounting parameters to probe
disc.lin=0:.5:10;
disc.nonlin=[0:.001:009,.01:.01:.09,.1:.1:1];

% get accuracy values


% what I call a combination is a pair (model_type,noise level)
num_combinations = 2*length(noise_vec); % first 3 for L; last 3 for NL
acc_store=cell(1,num_combinations);
for s=1:num_combinations
    if s<4
        disc_vec=disc.lin; 
        model_type='lin';
    else
        disc_vec=disc.nonlin;
        model_type='nonlin';
    end
    noise_idx=mod(s,3); 
    if noise_idx==0; noise_idx=length(noise_vec); end
    model_params.noise=noise_vec(noise_idx);
    curve=zeros(1,length(disc_vec));
    for disc_case=1:length(disc_vec)
        model_params.disc=disc_vec(disc_case);
        curve(disc_case)=accuracy(model_type, model_params, dbname,...
            trial_range, bad_trials, 'pureTrials', true);
    end
    acc_store{s}=curve;
end
toc
save([data_folder,'accuracy_figure_3.mat']);

