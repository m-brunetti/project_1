function img = loadImages();
filename='C:\Users\Payden McBee\Documents\NEU\NEUclasses\CompVision\Office\Office';
addpath(filename);

srcFiles = dir('C:\Users\Payden McBee\Documents\NEU\NEUclasses\CompVision\Office\Office\*.jpg'); 
imgs = zeros(240,320,length(srcFiles));

filename = strcat('C:\Users\Payden McBee\Documents\NEU\NEUclasses\CompVision\Office\Office\',srcFiles(1).name);
img = imread(filename);
[length, width]=size(img);

for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\Payden McBee\Documents\NEU\NEUclasses\CompVision\Office\Office\',srcFiles(i).name);
    img = imread(filename);
    %figure, imshow(I);
end

img = rgb2gray(img);
imshow(img);