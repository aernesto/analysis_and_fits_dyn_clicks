function prob=cross_validate(model,database,validation_trial_range)
% ARGS:
%   model       a struct with at least these 3 fields:
%                   type        a string, either 'lin' or 'nonlin'
%                   disc        scalar value for discounting parameter
%                   noise       stdev for noise applied on click heights
%   database    string. full path to database file (HDF5)
%   validation_trial_range 1-by-2 vector with integer indices (endpoints
%                          included)
% RETURNS: probability that the decision data was generated by the model,
%          i.e. P(decision data | model)
if strcmp(model.type,'lin')
    likelihood=@lhd_lin_sing_tr_gauss_clicks;
elseif strcmp(model.type,'nonlin')
    likelihood=@lhd_nonlin_sing_tr_gauss_clicks;
end



end