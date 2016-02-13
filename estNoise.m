function [Ebar, sigAvg] = estNoise(numImages, img, lengthImg,widthImg)

Ebar = zeros(lengthImg,widthImg);
for i=1:numImages
    for j=1:lengthImg
        for k=1:widthImg
            Ebar(j,k) = Ebar(j,k) + img(j,k,i);
        end
    end
end

Ebar = Ebar./numImages;

SDsum=0;
SD_IJ = zeros(lengthImg,widthImg);
for i=1:numImages
    for j=1:lengthImg
        for k=1:widthImg
            SD_IJ(j,k) = SD_IJ(j,k)+(Ebar(j,k)-img(j,k,i))^2;
        end
    end
end
for j=1:lengthImg
        for k=1:widthImg
            SD_IJ(j,k) = (SD_IJ(j,k)./(numImages-1)).^(1/2);
            SDsum = SDsum + SD_IJ(j,k);
        end
end
sigAvg = SDsum/(lengthImg*widthImg);
