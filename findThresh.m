function thresh = findThresh(images);
numImages = 10;
lengthImg = size(images,2);
widthImg = size(images,3);
[Ebar, sigAvg] = estNoise(numImages, images, lengthImg,widthImg)

<<<<<<< HEAD
thresh=2*sigAvg;
=======
thresh=2*sigAvg;
>>>>>>> 3095582a2b3338e7d7ea0f0d71035c9476bef8bb
