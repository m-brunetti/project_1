function [ ] = motion_detect(images, motion_filter, thresh, spatial_filter)
%% Simple motion detection filter
%
%
%%

%if spatial filter is a scalar
if (max(size(spatial_filter))==1)
    smooth=0;
end

n=(size(motion_filter) - 1)/2;

I=size(images,1);%PM 2->1 ref rows
J=size(images,2);%PM 2->1 ref cols

if (smooth==true) %PM ture to true
    %smooth image
    
    
end

%PM start insert
endOfArray=size(images,3)-size(spatial_filter,2)+1;
valsOfFrames = zeros(size(motion_filter,1),size(motion_filter,2));
%frames = zeros(
for frame=1:endOfArray  %PM 1->3 to reference # of images 
    
    motion_mask=zeros(I,J,endOfArray);%initialize mask to zeros
    
    %loop over each pixel
    for i=1:I
       for j=1:J
           frames = images(i,j,frame:(frame+size(motion_filter,2)-1));
           for k=1:size(motion_filter,2)
               valsOfFrames(k) = frames(1,1,k);
           end 
           pixD=dot(double(motion_filter), double(valsOfFrames));
           if pixD > thresh
               motion_mask(i,j,frame)=1;
           else
               motion_mask(i,j,frame)=0;
           end
       end
    end
end

%overLay mask and color moving points
coloredImages = images;
for frame=1:endOfArray  %PM 1->3 to reference # of images 
    
    %loop over each pixel
    for i=1:I
       for j=1:J
           if motion_mask(i,j,frame)==1
               coloredImages(i,j,frame+(size(motion_filter,2)-1)/2)= 0; %make balck if movement 
           end
       end
    end
end
implay(coloredImages);
%PM end insert
%{
for frame=n:size(images,3)-n  %PM 1->3 to reference # of images 
    
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
           if (pixel_deriv > thresh)
               motion_mask(i,j)=1;
           end
       end
    end
    
    %display mask and image
    
end
%}
