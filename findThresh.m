function thresh = findThresh(images);
numImages = 10;
lengthImg = size(images,2);
widthImg = size(images,3);
[Ebar, sigAvg] = estNoise(numImages, images, lengthImg,widthImg)

thresh=2*sigAvg;