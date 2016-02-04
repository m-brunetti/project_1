function [ ] = motion_detect(images_path, motion_filter, smooth, spatial_filter)
%% Simple motion detection filter
%
%
%%

%if < 4 arguments are passed, set smooth and spatial_filter to zero
if (nargv<4)
    smooth=0;
    spatial_filter=0;
end

images=read_images(images_path);%or however we decide to read the images

n=(size(motion_filter) - 1)/2;

I=size(images,2);
J=size(images,3);

if (smooth==ture)
    %smooth image
    
end

for frame=n:size(images,1)-n
    
    motion_mask=zeros(I,J);%initialize mask to zeros
    
    %loop over each pixel
    for i=1:I
       for j=1:J
           %calculate derivative at each pixel
           pixel_deriv=0;
           for filt=-n:n;
               pixel_deriv=pixel_deriv+motion_filter(n+1+filt)*images(frame+filt,i,j);
           end
           %if derivative is above threshold, set that pixel to true in
           %mask
           if (pixel_deriv > threshold)
               motion_mask(i,j)=1;
           end
       end
    end
    
    %display mask and image
    
end




end