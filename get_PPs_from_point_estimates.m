% computes PP values corresponding to a cloud of point estimates
clear
tic
db_fits='db_fits.csv';

% database to use to compute percent match
db_name='/home/adrian/programing/data/clicks/db2.h5'; 

% set parameters that specify the point estimates to fetch
p.ref_model='nonlin';
p.fit_model='nonlin';
p.fit_id=1;             
p.fit_method='max_pp';  
p.num_trials=100;       
p.db_name='db2.h5';

% get point estimates from db_fits.csv
T=readtable(db_fits);
rows=strcmp(T.ref_model,p.ref_model)    & ...
     strcmp(T.fit_model,p.fit_model)    & ...
     T.fit_id == p.fit_id               & ...
     strcmp(T.fit_method,p.fit_method)  & ...
     T.num_trials == p.num_trials       & ...
     strcmp(T.db_name,p.db_name);
 
 point_estimates=T.disc(rows);
 
 % set parameters to write in the db_PP.csv database
 pp=p;
 if pp.num_trials == 100
     pp.trial_start=1;
 elseif pp.num_trials == 500
     pp.trial_start=101;
 end
 pp.trial_stop=pp.trial_start+pp.num_trials-1;
 pp.db_name='db2.h5';
 pp.commit='7427db0';
 
 [~,name,~] = fileparts(mfilename); % parse current file name
 pp.script_name=[name,'.m'];
 
 [~,name,ext] = fileparts(db_name); % parse database file name
 pp.db_name = [name,ext];
 
 pp.noise=1;
 shuffle=false;
 
 fits_data_file=['/home/adrian/Documents/MATLAB/projects/',...
                 'analysis_and_fits_dyn_clicks/db_PP.csv'];

 
 for i=1:length(point_estimates)
     target_model_params.disc=point_estimates(i);
     target_model_params.noise=pp.noise;
     
     percent_match=predictive_power(pp.fit_model, target_model_params,...
     pp.ref_model, db_name, [pp.trial_start,pp.trial_stop], shuffle);
 
     % write to file
     to_write={...
         pp.fit_id,...
         pp.db_name,...
         pp.trial_start,...
         pp.trial_stop,...
         pp.num_trials,...
         pp.script_name,...
         pp.commit,...
         pp.fit_model,...
         pp.ref_model,...
         percent_match,...
         pp.fit_method};
            
     dump2db_PP(fits_data_file,to_write)
 end
 toc