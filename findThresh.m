function thresh = findThresh(images,num_stdevs)
[avg_noise, max_noise] = EST_NOISE(double(images));

thresh=num_stdevs*avg_noise;