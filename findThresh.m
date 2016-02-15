function thresh = findThresh(pixel_derivs,num_stdevs)
%% Find threshold for motion detection using noise in pixel_derivs
% estimate the noise using EST_NOISE and set threshold to number of
% standard deviations given by num_stdevs
%%
[avg_noise, max_noise] = EST_NOISE(double(pixel_derivs));
thresh=num_stdevs*avg_noise;
end