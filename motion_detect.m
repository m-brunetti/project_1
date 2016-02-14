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
pixel_derivs=zeros(size(images,1)-n,I,J);

calcThresh=1:50;

images_double=im2double(images);

for frame=n+1:size(images,1)-n
    
    mult=images_double((frame-n):(frame+n),:,:);
    
    %calculate pixel derivatives for entire frame
    pixel_derivs(frame-n,:,:)=sum(spatial_filter_frame(:,:,:).*mult,1);
    
    if(frame==max(calcThresh(:)))
        thresh=findThresh(pixel_derivs(calcThresh,:,:));
    end
    
    motion_mask(frame-n,:,:)=abs(pixel_derivs(frame-n,:,:))>thresh;
    
    %display mask - sloppy, we want to do something else for the final
    %project
    figure(1);imagesc(squeeze(motion_mask(frame-n,:,:)));colorbar;caxis([0 1]);
    %figure(2);imshow(squeeze(images(frame-n,:,:)));
    
    pause(.05)
    a=frame

end




end