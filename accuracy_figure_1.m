% produce accuracy figure described here
% https://paper.dropbox.com/doc/Figure-4-design--APE0_g8NTsvVZxTg2DUyd6WvAg-nlH9WGli5QW8x41ZJbGlJ#:h2=Accuracy-as-function-of-discou
clear
rng('shuffle') % change seed if reproducibility desired

%tbUseProject('analysis_and_fits_dyn_clicks');

% where to get the trials data from (only the click streams and envt)
data_folder='~/programing/data/clicks/';
dbname=[data_folder,'validation2.h5'];

% file name into which data for figure should be saved
dataToSave = [data_folder,'accuracy_figure_8.mat'];

% bad trials for validation2.h5 dataset (if all trials are fine, set to
% empty vector)
bad_trials=[93737];%[93737,207048,229626,272270,555142,631387,666886,774387,811388,961053];

% range of trials to use from db
trial_range=[1,100000];

% start timer
tic

% noise levels
kappa=log(20/5);
noise_vec=[.1,1,2];
numNoise = length(noise_vec);

% discounting parameters to probe
disc.lin=[0:.5:10]';
disc.nonlin=[0:.001:.009,.01:.01:.09,.1:.1:1.5]';

% get all trials and correct answers from database
% fetch trials (throw error if trial_range out of bounds) 
trials=fetch_trials(dbname,trial_range,false);

% fetch correct responses (row vec)
correct_choices=fetch_correct_responses(dbname,trial_range);

% fetch necessary parameters
% note: as long as 'pureTrials' is true, the model_type argument has no
% importance, as only the clicks and environment are fetched.
db_params=fetch_params(dbname, 'lin', 'pureTrials', true); 

% remove problematic trials if needed
if bad_trials
    trials(:,bad_trials)=[];
    correct_choices(:,bad_trials)=[];
end
num_trials = size(trials,2);

% what I call a combination is a pair (model_type,noise level)
num_combinations = 2*numNoise; % first 3 for L; last 3 for NL
acc_store=cell(1,num_combinations);
for s=1:num_combinations
    if s<4
        disc_vec=disc.lin; 
        model_type='lin';
    else
        disc_vec=disc.nonlin;
        model_type='nonlin';
    end
    noise_idx=mod(s,numNoise); 
    if noise_idx==0; noise_idx=numNoise; end
    model_params.noise=noise_vec(noise_idx);
    
    num_disc = length(disc_vec);
    
    % initialize a matrix containing all the models' responses
    allResponses = zeros(num_disc, num_trials);
    
    % compute model's responses for all discounting parameters in parallel
    
    if strcmp(model_type,'lin')
        for tr = 1:num_trials
            [left_train,right_train]=trials{1:2,tr};
            allResponses(:,tr)=decide_lin_noise(left_train, right_train,...
                disc_vec, db_params.kappa, model_params.noise, 0);
        end
    elseif strcmp(model_type,'nonlin')
        for tr=1:num_trials
            [left_train,right_train]=trials{1:2,tr};
            num_clicks=length(left_train)+length(right_train);
            noise_matrix=normrnd(db_params.kappa,model_params.noise,...
                [num_clicks,1]);
            allResponses(:,tr)=decide_nonlin_noise(db_params.T,left_train,...
                right_train, disc_vec, 0, noise_matrix);
        end
    end
    
    % make decision on undecided trials at random
    undecided = find(~allResponses); % locating zeros
    allResponses(undecided) = randsample([-1,1],length(undecided),true);
    
    % compute accuracy for all discounting parameters, for the current
    % model and current noise value
    % acc below is a column vector with one accuracy value per discounting
    % parameter value
    acc=sum(allResponses==correct_choices,2)/num_trials;

    acc_store{s}=acc';  % store as row vec for further processing
end
toc
save(dataToSave);

