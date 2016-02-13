function thresh = findThresh(images)
[avg_noise, max_noise] = EST_NOISE(double(images));

thresh=4*avg_noise;