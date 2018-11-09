% fits models to data using max_pp algorithm
% dumps results in db_fits.csv
% outputs one csv file per model fit.
clear
tbUseProject('analysis_and_fits_dyn_clicks');
tic
commit='7427db0'; % commit number to insert in database of fits
fit_id=1; % iteration of the fit with these settings
models_to_fit={'lin','nonlin'};
assumed_noise=1; % noise value assumed for the fit models
ref_models={'lin','nonlin'};
prior_ranges={[0,40],[0,10]}; % ranges for lin and nonlin models respectively
precision=2; % number of decimals we would like to keep
num1=diff(prior_ranges{1})*10^precision;
num2=diff(prior_ranges{2})*10^precision;
fit_num_samples={num1,num2};

db_name='/home/adrian/programing/data/clicks/db2.h5';
db_params=fetch_params(db_name,'lin'); % second parameter is irrelevant here
num_trials_in_db=db_params.tot_db_trials;
num_trials=500;% want 100 and 500
trial_range=[1,num_trials]; % since trials will get shuffled, the range endpoints don't really matter
num_fits=500;% want 500
fits_data_file='/home/adrian/Documents/MATLAB/projects/analysis_and_fits_dyn_clicks/db_fits.csv';

[~,name,~] = fileparts(mfilename); % parse current file name
script_name=[name,'.m'];
[~,name,ext] = fileparts(db_name); % parse database file name
db_name_short = [name,ext];

for ii=1:length(ref_models)
    ref_model=ref_models{ii};
    for jj=1:length(models_to_fit)
        fit_model=models_to_fit{jj};
        if strcmp(fit_model,'lin')
            prior_range=prior_ranges{1};
            num_samples=fit_num_samples{1};
        else
            prior_range=prior_ranges{2};
            num_samples=fit_num_samples{2};
        end
        
        % loop over fitting procedures
        for kk=1:num_fits
            
            [estimates,~]=find_max_pp(prior_range, num_samples,...
    db_name,trial_range,fit_model,ref_model,assumed_noise,true);

            % write to file
            to_write={...
                fit_id,...
                db_name_short,...
                -1,...
                -1,...
                num_trials,...
                script_name,...
                commit,...
                fit_model,...
                ref_model,...
                mean(estimates),...
                'max_pp'};
            
            dump2db_fits(fits_data_file,to_write)
            
        end
    end
end

toc
