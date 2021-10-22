function [PSNR] = imageQuality_noise(img_ref,img_noise)
%IMAGEQUALITY_NOISE Summary of this function goes here
%   Detailed explanation goes here

%Check the reference image type
x = isa(img_ref,'double');
% If the image is not double, then cast to double
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

% Convert images to 8 bit, for analysis and scaling 
img_ref = int8(img_ref);
img_noise = int8(img_noise);
% Find the image error square
img_error_sq = (double(img_ref) - double(img_noise)).^ 2;
% Derive the Mean Square Error
mse = sum(img_error_sq(:)) / (row * column);
% Calculate PSNR (Peak Signal to Noise Ratio)
PSNR = 10 * log10( 255^2 / mse);

% Displaying the PSNR
disp(["The Peak SNR of the given pair is: " + int2str(PSNR)]);

end

