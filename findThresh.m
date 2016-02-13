function thresh = findThresh(images);
numImages = 10;
lengthImg = size(images,1);
widthImg = size(images,2);
[Ebar, sigAvg] = estNoise(numImages, images, lengthImg,widthImg);

thresh=sigAvg;