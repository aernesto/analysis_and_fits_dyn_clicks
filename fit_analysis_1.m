% analysis script
clear; clc;
%% specify database with choice data
dbname='~/programing/data/clicks/db1.h5';
% display parameters for current db
fprintf('disc and noise params below are for linear model\n')
p1=fetch_params(dbname,'lin')
fprintf('disc and noise params for nonlinear model are\n')
p2=fetch_params(dbname,'nonlin');
p2.disc
p2.noise

%% specify training and validation datasets
cutoff=.01; % percentage of trials to use for training
int_cutoff=floor(cutoff*p1.tot_db_trials);
fprintf('about to use %i trials for the fits\n',int_cutoff)
training_trials_range=[1,int_cutoff];
validation_trials_range=[int_cutoff+1,p1.tot_db_trials];

%% fit models (all four combinations)
types={'lin','nonlin'};

% specify parameters for the fits

% range of posterior support
lin_prior_range=[0,40];
nonlin_prior_range=[0,20];

% number of points to use for support of posterior
num_points_posterior_lin=800;
num_points_posterior_nonlin=800;

num_particles_lhd=800; % number of particles to use to estimate likelihood

point_estimates= containers.Map;

for i=1:2
    ref_type=types{i};
    for ii=1:2
        fitted_type=types{ii};
        [~,point_estimate]=fit_model(fitted_type,ref_type,...
            dbname,...
            lin_prior_range,...
            nonlin_prior_range,...
            training_trials_range,...
            num_points_posterior_lin,...
            num_points_posterior_nonlin,...
            num_particles_lhd);
        point_estimates([fitted_type,ref_type])=point_estimate;
    end
end

%% Compute accuracies

%% Compute predictive power values

%% display results

%% Auxiliary functions

% the following function might try to do too many things at the same time
function [posterior,estimate]=fit_model(fitted_type,ref_type,...
    dbname,...
    lin_prior_range,...
    nonlin_prior_range,...
    training_trials_range,...
    num_points_posterior_lin,...
    num_points_posterior_nonlin,...
    num_particles_lhd)
shuffle_db=false;
    if strcmp(fitted_type,'lin')
        [posterior,estimate]=fit_linear_model(ref_type, dbname,...
            lin_prior_range,training_trials_range,...
            num_points_posterior_lin,shuffle_db);
    elseif strcmp(fitted_type,'nonlin')
        [posterior, estimate]=fit_nonlinear_model(ref_type, dbname,...
            nonlin_prior_range,training_trials_range,...
            num_points_posterior_nonlin,num_particles_lhd,shuffle_db);
    end
end
