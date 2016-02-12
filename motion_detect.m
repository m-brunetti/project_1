function [ ] = motion_detect(images, motion_filter, thresh, spatial_filter)
%% Simple motion detection filter
%
%
%%

%if spatial filter is a scalar
if (max(size(spatial_filter))==1)
    smooth=0;
end

n=(max(size(motion_filter)) - 1)/2;

I=size(images,2);
J=size(images,3);

if (smooth==1)
    %smooth image
    
    
end

spatial_filter_frame=ones(max(size(motion_filter)),I,J);

for frame=1:max(size(motion_filter))
    spatial_filter_frame(frame,:,:)=spatial_filter_frame(frame,:,:).*motion_filter(frame);
end

motion_mask=zeros(size(images,1)-n,I,J);

images_double=im2double(images);

for frame=n+1:size(images,1)-n
    
    mult=images_double((frame-n):(frame+n),:,:);
    
    %calculate pixel derivatives for entire frame
    pixel_derivs=sum(spatial_filter_frame(:,:,:).*mult,1);
    
    motion_mask(frame-n,:,:)=abs(pixel_derivs)>thresh;
    
    %display mask - sloppy, we want to do something else for the final
    %project
    imagesc(squeeze(motion_mask(frame-n,:,:)));colorbar;
    
    pause(.05)
    a=frame

end




end