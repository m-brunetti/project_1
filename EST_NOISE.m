%Michael Brunetti
%EECE5639
%EST_NOISE
%%

function [avg_noise, max_noise] = EST_NOISE(imgs,print)

if nargin<2
    print=0;
end

img_means=(1/size(imgs,1)).*sum(imgs,1);

img_means_sum=zeros(size(imgs,1),size(imgs,2),size(imgs,3));
for i=1:size(imgs,1);img_means_sum(i,:,:)=img_means;end;

%stdev at each pixel value
img_stdev=( (1/(size(imgs,1)-1) .* sum( (img_means_sum-imgs).^2,1)).^(1/2) );

avg_noise=mean(img_stdev(:));
max_noise=max(img_stdev(:));

if (print==1)
    fprintf('average noise = %0.3f\n',avg_noise);
    fprintf('max acq. noise = %0.3f\n',max_noise);
end

end