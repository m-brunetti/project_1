function [ ] = motion_detect(images, motion_filter, num_stdevs, spatial_filter)
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
    for i=1:size(images,1)
       images(i,:,:)=imboxfilt(squeeze(images(i,:,:)),sizeSmoothFilt);
    end
end

spatial_filter_frame=ones(max(size(motion_filter)),I,J);

for frame=1:max(size(motion_filter))
    spatial_filter_frame(frame,:,:)=spatial_filter_frame(frame,:,:).*motion_filter(frame);
end

motion_mask=zeros(size(images,1)-n,I,J);
pixel_derivs=zeros(size(images,1)-n,I,J);

calcThresh=1:20;
thresh=999999;

for frame=n+1:size(images,1)-n
    
    current_frame=im2double(images((frame-n):(frame+n),:,:));
    
    %calculate pixel derivatives for entire frame
    pixel_derivs(frame-n,:,:)=sum(spatial_filter_frame.*current_frame,1);
    
    if(frame==max(calcThresh(:)))
        thresh=findThresh(pixel_derivs(calcThresh,:,:),num_stdevs);
    end
    
    motion_mask(frame-n,:,:)=abs(pixel_derivs(frame-n,:,:))>thresh;
    motion_red=uint8(cat(3,squeeze(motion_mask(frame-n,:,:))*255,zeros(I,J),zeros(I,J)));
    
    motion=imfuse(motion_red,squeeze(images(frame,:,:)),'blend');
    
    imshow(motion)
%     imshow(squeeze(images(frame,:,:)));
%     
%     motion=imfuse(squeeze(images(frame-n,:,:)),motion_red);
    %imshow(motion);
    %display mask - sloppy, we want to do something else for the final
    %project
    %figure(1);imagesc(squeeze(motion_mask(frame-n,:,:)));colorbar;caxis([0 1]);
    %figure(2);imshow(squeeze(images(frame-n,:,:)));
    
    
    pause(.01)
%    a=frame

end




end