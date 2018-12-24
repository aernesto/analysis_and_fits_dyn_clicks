clear
modelPairs = {'L-L','NL-NL'};
noiseVals = [.1,1,2];
filenames={'joint_PP_LL_ntrials_999990_noise_0.1.mat',...
      'joint_PP_LL_ntrials_999990_noise_1.mat',...
      'joint_PP_LL_ntrials_999990_noise_2.mat',...
      'joint_PP_NLNL_ntrials_999990_noise_0.1.mat',...
      'joint_PP_NLNL_ntrials_999990_noise_1.mat',...
      'joint_PP_NLNL_ntrials_999990_noise_2.mat'};
data_folder='~/programing/data/clicks/';
for mp = 1:2
    model_pair = modelPairs{mp};
    for nv = 1:3
        noiseVal = noiseVals(nv);
        iii = (mp-1)*3+nv;
        fileName = filenames{iii};
        pcolor_PP(model_pair, data_folder, fileName, noiseVal, true)
    end
end