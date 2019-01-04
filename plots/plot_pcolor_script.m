clear
% run following line in console if project not yet activated by TbTb
% tbUseProject('analysis_and_fits_dyn_clicks');
modelPairs = {'L-L','NL-NL'};
noiseVals = [.1,2];
tot_noise = length(noiseVals);
filenames={'joint_PP_LL_ntrials_999990_noise_0.1.mat',...
      'joint_PP_LL_ntrials_999990_noise_2.mat',...
      'joint_PP_NLNL_ntrials_999990_noise_0.1.mat',...
      'joint_PP_NLNL_ntrials_999990_noise_2.mat'};
data_folder='~/programing/data/clicks/';
for mp = 1:2
    model_pair = modelPairs{mp};
    for nv = 1:length(noiseVals)
        noiseVal = noiseVals(nv);
        iii = (mp-1)*tot_noise+nv;
        fileName = filenames{iii};
        pcolor_PP(model_pair, data_folder, fileName, noiseVal, true)
    end
end