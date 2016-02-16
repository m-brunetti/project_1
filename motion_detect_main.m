function [ ] = motion_detect_main(images_path, num_stdevs, motion_filter_name, tsigma, spatial_filter_type, ssigma)
%% Main function for running motion detection
%Interprets input arguments, defines filter kernel, calls loadImages, and
%runs motion_detect

%% Input Variables
%num_stdevs: the factor of standard deviations that the threshold will be
%greater than the standard deviation of the noise
%motion_filter_name: two choices, simple or 1D_DOG
%tsigma: determines filter size of Gaussian derivative, 1D_DOG
%spatial_filter_type: options are Box3, Box5, and Gauss
%ssigma: only applies if using Gauss for spatial_filter_type, determines sd
%of Gaussian averaging filter, and thus the size of the filter
%%

if (nargin<4)%make sure if DOG filter is used there is a value for tsigma
    if (strcmp(motion_filter_name,'1D_DOG'))
        disp('value for tsigma required for 1D Deriviative of Gaussian');
        return
    end
end

if (nargin<5)%no spatial smoothing if <5 args are passed
    spatial_filter_type=0;
    ssigma=0;
elseif (nargin<6)%check to see if Gaussian filter, if not set ssigma to zero
    if (strcmp(spatial_filter_type,'Gauss'))
        disp('value for ssigma required for 2D Gaussian filter');
        return
    else
        ssigma=0;
    end
end

disp(['Motion filter name - ',motion_filter_name]);

switch motion_filter_name
    case 'simple'                       %simple 1D motion filter
        motion_filter=0.5.*[-1 0 1];
    case '1D_DOG'                       %1D Derivative of Gaussian
        
        %set filter size based on tsigma, round to nearest odd integer
        filter_size=tsigma.^2*2*pi;
        filter_size=2*round(filter_size/2+1)-1;
        
        %create Gaussian kernel
        filt=-(filter_size-1)/2:(filter_size-1)/2;
        gaussian_kernel=sqrt(1/(2*pi*tsigma^2)).*exp(-filt.^2 ./ (2*tsigma^2));
        
        %calcualte Derivative of Gaussian and set as motion_filter
        deriv_of_gauss=zeros(1,filter_size-2);
        for i=2:(size(gaussian_kernel,2)-1)
            deriv_of_gauss(i-1)=sum((0.5.*[-1 0 1]).*gaussian_kernel(i-1:i+1));
        end
        
        motion_filter=deriv_of_gauss;
        
        fprintf('tsigma = %0.3f\n\n',tsigma);
    otherwise                           %if filter name not recognized
        disp('Unrecognized motion filter name. The choices are:')
        fprintf('\tsimple - a 3x1 simple 1D filter\n')
        fprintf('\t1D_DOG - a 1D derivative of gaussian filter with user-defined tsigma\n')
        return
end

%display the motion filter
disp(motion_filter);

images=loadImages(images_path);%load the images

%run motion detection
motion_detect(images, motion_filter, num_stdevs, spatial_filter_type, ssigma);
end
