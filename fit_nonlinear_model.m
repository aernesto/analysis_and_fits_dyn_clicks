function [posterior, point_estimate]=fit_nonlinear_model(ref_model, dbname,...
    disc_prior,ntrials,ndiscount,npart,shuffle_db)
% fits the stochastic linear model to data
% ARGUMENTS:
%   ref_model   -- string. either 'lin' or 'nonlin'
%   dbname      -- string. full path to .h5 db file
%   disc_prior  -- 1-by-2 vector describing the endpoints of the support
%                   for the prior over the discounting parameter
%   ntrials     -- number of trials to use for the fit 
%   ndiscount   -- number of discounting param values to use for likelihood
%   npart       -- number of particles to use to estimate likelihood
%   shuffle_db  -- boolean. If true, trials are randomly permuted
% WARNING: The shuffle_db=true flag doesn't currently work
% NOTES:
%   Calls: llh2density() & lhd_nonlin_sing_tr_gauss_clicks()

% sample space (vector of samples to use. 1 sample = 1 discounting rate)
hstart=disc_prior(1);hend=disc_prior(2);
hs=linspace(hstart, hend, ndiscount)';
dh=(hend-hstart)/(ndiscount-1);  % step between consecutive samples

% database info (where the clicks data and other parameter values reside)
filename = dbname;
file_info = h5info(filename);
group_name = file_info.Groups.Name;
info_dset_name=[group_name,'/trial_info'];

T = h5readatt(filename, info_dset_name,'T');        % Trial duration in sec
nsd = h5readatt(filename,[group_name,'/decision_',ref_model],'noise');
low_rate = h5readatt(filename, info_dset_name,'low_click_rate'); % click rates
high_rate = h5readatt(filename, info_dset_name,'high_click_rate');
k=log(high_rate/low_rate);                          % jump in evidence at clicks
all_trials = h5read(filename, [group_name,'/trials']); % clicks data

% extract reference decisions into row vector:
if strcmp(ref_model,'lin')
    ref_decisions = h5read(filename,...
        [group_name,'/decision_lin'], [1 1], [1 Inf]);
else
    ref_decisions = h5read(filename,...
        [group_name,'/decision_nonlin'], [1 1], [1 Inf]);
end

tot_trials_db = size(all_trials,2);                 % total number of trials in DB

all_trials = all_trials(1:2,:);

tic

if shuffle_db
    % shuffle trial order
    rng('shuffle')
    all_trials = all_trials(:,randperm(tot_trials_db));
end

llh = zeros(ndiscount,1);
parfor trn=1:ntrials
    [lst, rst]=all_trials{:,trn};
    total_clicks = length(lst)+length(rst);
    
    % read synthetic decision from db
    synthetic_decision = ref_decisions(trn);
    
    % for random numbers generations to come
    rng('shuffle')
    
    % flip a coin if decision was 0
    if synthetic_decision == 0
        synthetic_decision = sign(rand-0.05);
    end
    
    % generate upfront all the Gaussian r.v. needed
    Gaussian_bank = normrnd(k, nsd, [npart, total_clicks, ndiscount]);
    
    % compute log-lh of each sample, for the 2 model pairs
    lhv=lhd_nonlin_sing_tr_gauss_clicks(synthetic_decision, npart, lst,...
        rst, T, hs, 0, Gaussian_bank);
    lhv(lhv<eps) = eps;
    lhd=log(lhv);
    llh=llh+lhd;
end

% shift log-likelihood up to avoid numerical errors
[max_val,idx1]=max(llh);
point_estimate=hs(idx1);

llh=llh+abs(max_val);

posterior=llh2density(llh,dh);           % convert log-lh to density

% plots for debugging
subplot(2,1,1); plot(hs,llh)
subplot(2,1,2); plot(hs,posterior)

toc
end