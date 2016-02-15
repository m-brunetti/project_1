function imgs = loadImages(images_path)
%%Load images from folder
%Loads the images from folder specified by images_path
%%
filename1=images_path;
addpath(filename1);

allPics = strcat(filename1,'*.jpg');
srcFiles = dir(allPics);
imgs = uint8(zeros(length(srcFiles),240,320));

for i = 1 : length(srcFiles)
    filename3 = strcat(filename1,srcFiles(i).name);
    [tempI,map] = imread(filename3);
    temp2=rgb2gray(tempI);
    imgs(i,:,:)=temp2;
end
