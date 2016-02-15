function [ ] = motion_detect(images, motion_filter, num_stdevs, spatial_filter_type, ssigma)
%% Simple motion detection filter
%
%
%%

images_double=im2double(images);

N_images=size(images,1);
I=size(images,2);
J=size(images,3);


%spatial filtering
switch spatial_filter_type
    case 'Box3'
        for i=1:N_images
            images_double(i,:,:)=imboxfilt(squeeze(images_double(i,:,:)),3);
        end
    case 'Box5'
        for i=1:N_images
            images_double(i,:,:)=imboxfilt(squeeze(images_double(i,:,:)),5);
        end
    case 'Gauss'
        for i=1:N_images
            images_double(i,:,:)=imgaussfilt(squeeze(images_double(i,:,:)),ssigma);
        end
end

n=(max(size(motion_filter)) - 1)/2;

temp_filter_frame=ones(max(size(motion_filter)),I,J);

for frame=1:max(size(motion_filter))
    temp_filter_frame(frame,:,:)=temp_filter_frame(frame,:,:).*motion_filter(frame);
end

motion_mask=zeros(N_images-n,I,J);
pixel_derivs=zeros(N_images-n,I,J);

calcThresh=1:20;
thresh=999999;

for frame=n+1:N_images-n
    
    current_frame=images_double((frame-n):(frame+n),:,:);
    
    %calculate pixel derivatives for entire frame
    pixel_derivs(frame-n,:,:)=sum(temp_filter_frame.*current_frame,1);
    
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