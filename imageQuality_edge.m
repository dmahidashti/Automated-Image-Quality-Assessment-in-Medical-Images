function mssim=imageQuality_edge(img_ref,img_noise)

%% Initialization
% Define offset constants (to prevent the denom going to 0)
C1 = (0.01.*255)^2;
C2 = (0.03.*255)^2;
C3 = (0.05.*255)^2;

% If the image is not double, then cast to double
x = isa(img_ref,'double');
if x==0
img_ref = im2double(img_ref);
end
%Check the noisy image type
x = isa(img_noise,'double');
% If the image is not double, then cast to double
if x==0
img_noise = im2double(img_noise);
end
%Extract the row, column and width of the image
row = size(img_ref, 1); % Effectively the x axis
column = size(img_ref, 2); % Effectively the y axis

% Derive the square of the images
img_ref_sq=img_ref.^2;
img_noise_sq=img_noise.^2;
% Create the combined (multiplied) image
img_comb=img_ref.*img_noise;

%% Deriving the mu and sigma

% Reference Image
% Mu
mu1=imgaussfilt(img_ref,1.5,'FilterSize',11);% Apply the gaussian filter with a SD of 1.5, filter size of 11x11
mu1_2=mu1.^2;
% Sigma
sigma1_2=imgaussfilt(img_ref_sq,1.5,'FilterSize',11);% Apply the gaussian filter with a SD of 1.5, filter size of 11x11
sigma1_2=sigma1_2-mu1_2;

% Noisy Image
% Mu
mu2=imgaussfilt(img_noise,1.5,'FilterSize',11);% Apply the gaussian filter with a SD of 1.5, filter size of 11x11
mu2_2=mu2.^2;
% Sigma
sigma2_2=imgaussfilt(img_noise_sq,1.5,'FilterSize',11);% Apply the gaussian filter with a SD of 1.5, filter size of 11x11
sigma2_2=sigma2_2-mu2_2;

% Combinations
mu1_mu2=mu1.*mu2;

sigma12=imgaussfilt(img_comb,1.5,'FilterSize',11);% Apply the gaussian filter with a SD of 1.5, filter size of 11x11
sigma12=sigma12-mu1_mu2;


%% Deriving MESSIM
num = ((2*mu1_mu2 + C1).*(2*sigma12 + C2));
denom =((mu1_2 + mu2_2 + C1).*(sigma1_2 + sigma2_2 + C2));
ssim_map =  num./denom;
% Finding the sqaure mean
mssim = mean2(ssim_map); 
% Deriving the final mean
mssim=mean(mssim(:));

% Displaying the MSSIM
disp(["The MSSIM of the given pair is: " + num2str(mssim)]);
