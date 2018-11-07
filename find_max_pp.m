function [p,pp]=find_max_pp(prior_range, num_samples,...
    db_name,trial_range,target_type,ref_type,noise,shuffle_db)
% DESCRIPTION:
% finds the value of the discounting parameter that maximizes 
% percent match over a given database of trials and choice 
% values; and also the percent match value. When several values
% maximize percent match, all of them are returned.
% ARGS:
%	prior_range     1-by-2 vector describing interval of discounting
%               	parameter values to try
%   num_samples     number of discounting parameter values to try
%   db_name         full path to database of trials that contains choice
%                   data
%   trial_range     first and last trial in database delimitting the range
%                   of trials to use to compute the percent match
%   target_type     one of 'lin' and 'nonlin' representing fitted model
%   ref_type        one of 'lin' and 'nonlin' representing reference model
%   noise           stdev of the noise applied to clicks heights in the
%                   fitted model
%   shuffle_db      boolean. If true, trials are shuffled in db
% RETURNS:
%   p               scalar or vector of discounting parameter values that
%                   maximize the percent match
%   pp              maximal percent match value reached

disc_values=linspace(prior_range(1),prior_range(2),num_samples);
target_model_params.noise=noise;
target_model_params.disc=disc_values'; % must be col vector
percent_match_values=predictive_power(target_type,...
        target_model_params,ref_type, db_name, trial_range,shuffle_db);

% for debugging purposes plot(disc_values,percent_match_values)
pp=max(percent_match_values);
p=disc_values(abs(percent_match_values-pp)<=5*eps);
end
