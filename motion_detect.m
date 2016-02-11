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

for frame=1:size(motion_filter)
    spatial_filter_frame(frame,:,:)=spatial_filter_frame(frame,:,:).*motion_filter(frame);
end

motion_mask=zeros(size(images,1)-n,I,J);

images_double=im2double(images);

for frame=n+1:size(images,1)-n+1
    
    mult=images_double((frame-n):(frame+n),:,:);
    
    %calculate pixel derivatives for entire frame
    pixel_derivs=sum(spatial_filter_frame(:,:,:).*mult,1);
    
    motion_mask(frame-n,:,:)=abs(pixel_derivs)>thresh;
    
    imagesc(squeeze(motion_mask(frame-n,:,:)));
    pause(.2)
    a=frame
%     %loop over each pixel
%     for i=1:I
%        for j=1:J
%            %calculate derivative at each pixel
%            pixel_deriv=0;
%            for filt=-n:n;
%                pixel_deriv=pixel_deriv+motion_filter(n+1+filt)*images(frame+filt,i,j);
%            end
%            %if derivative is above threshold, set that pixel to true in
%            %mask
%            if (pixel_deriv > thresh)
%                motion_mask(i,j)=1;
%            end
%        end
%     end
    
    %display mask and image
    
end




end