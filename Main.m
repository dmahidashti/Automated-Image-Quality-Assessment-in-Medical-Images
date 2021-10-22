
%% Read Data

% Brain MRI Images

% Reference Brain MRI
[img1, info1] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - BrainMRI2/brainMRI_1.mat', '.mat');
img1=img1.vol;
% Noisy Brain MRI => 2
[img2, info2] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - BrainMRI2/brainMRI_2.mat', '.mat');
img2=img2.vol;
% Noisy Brain MRI => 3
[img3, info3] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - BrainMRI2/brainMRI_3.mat', '.mat');
img3=img3.vol;
% Noisy Brain MRI => 4
[img4, info4] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - BrainMRI2/brainMRI_4.mat', '.mat');
img4=img4.vol;
% Noisy Brain MRI => 5
[img5, info5] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - BrainMRI2/brainMRI_5.mat', '.mat');
img5=img5.vol;
% Noisy Brain MRI => 6
[img6, info6] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - BrainMRI2/brainMRI_6.mat', '.mat');
img6=img6.vol;

% Lung CT Images

% Reference 0.5 Noise CT Image
[img_ct_5, info] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - LungCT/noise_0.5x_post.mhd','.mhd');
img_ct_5 = img_ct_5.data;
% Noisy CT Image => x1
[img_ct_1, info] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - LungCT/training_post.mhd','.mhd');
img_ct_1 = img_ct_1.data;
% Noisy CT Image => x10
[img_ct_10, info] = ImageRead('/Users/daniel/MATLAB-Drive/BME872/Project/Lab1 - LungCT/noise_10x_post.mhd','.mhd');
img_ct_10 = img_ct_10.data;

%% Processing Brain MRI Images
clc
% Select the slice
i = 60;

    % Select the reference image
    slice_ref = img1(:,:,i);
    % Filter for a reference image (Non Local Means)
    img_ref = imnlmfilt(slice_ref);
    % Select the noisy image
    img_noise = img2(:,:,i);
    % Send the image to the noisy-ness measurer (MSE => PSNR)
    N = imageQuality_noise(img_ref,img_noise);
    % Send the image to the contrast measurer
    C = imageQuality_contrast(img_ref,img_noise);
    % Send the image to the edge measurer
    E = imageQuality_edge(img_ref,img_noise);
    
% Find out the quality
imageQuality_overall(N,C,E);

%% Plotting for Brain MRI Data

% Plotting
figure;
subplot(2,3,1);
imshow(slice_ref,[]);
title("Reference Image - Volume 1");
subplot(2,3,2);
imshow(img_ref,[]);
title("Filtered Reference - Volume 1");
subplot(2,3,3);
imshow(img_noise,[]);
title("Noisy Image - Volume 2");
subplot(2,3,4);
histogram(slice_ref,'Normalization','pdf');
title("Normalized Intensity Histogram");
xlabel("Intensity Value");
ylabel("Frequency");
subplot(2,3,5);
histogram(img_ref,'Normalization','pdf');
title("Normalized Intensity Histogram");
xlabel("Intensity Value");
ylabel("Frequency");
subplot(2,3,6);
histogram(img_noise,'Normalization','pdf');
title("Normalized Intensity Histogram");
xlabel("Intensity Value");
ylabel("Frequency");

%% Processing CT Images
clc
% Select the slice
i = 143;

    % Select the reference image
    slice_ref = img_ct_5(:,:,i);
    % Filter for a reference image (Non Local Means)
    img_ref = imnlmfilt(slice_ref);
    % Select the noisy image
    img_noise = img_ct_1(:,:,i);
    % Send the image to the noisy-ness measurer (MSE => PSNR)
    N = imageQuality_noise(img_ref,img_noise);
    % Send the image to the contrast measurer
    C = imageQuality_contrast(img_ref,img_noise);
    % Send the image to the edge measurer
    E = imageQuality_edge(img_ref,img_noise);
    
% Find out the quality
imageQuality_overall(N,C,E);

%% Plotting for CT Scan Data

% Plotting
figure;
subplot(2,3,1);
imshow(slice_ref,[]);
title("Reference Image - x0.5");
subplot(2,3,2);
imshow(img_ref,[]);
title("Filtered Reference");
subplot(2,3,3);
imshow(img_noise,[]);
title("Noisy Image - x10");
subplot(2,3,4);
histogram(slice_ref,'Normalization','pdf');
title("Normalized Intensity Histogram");
xlabel("Intensity Value");
ylabel("Frequency");
subplot(2,3,5);
histogram(img_ref,'Normalization','pdf');
title("Normalized Intensity Histogram");
xlabel("Intensity Value");
ylabel("Frequency");
subplot(2,3,6);
histogram(img_noise,'Normalization','pdf');
title("Normalized Intensity Histogram");
xlabel("Intensity Value");
ylabel("Frequency");

%% Comparison Graphs and Tables
clc
% Brain MRI 1 as ref, slice 60
image = [2; 3; 4; 5; 6];
Noise_score = [35;30;26;24;22];
Contrast_score = [0.40431;0.29285;0.24581;0.21121;0.18574];
Edge_score = [0.79421;0.60502;0.48773;0.40399;0.34385];

% CT Image 0.5x as ref, slice 143
%  image = [1;2];
%  Noise_score = [25;18];
%  Contrast_score = [0.24018;0.097879];
%  Edge_score = [0.34695;0.14282];

% Tabling the data
T = table(image,Noise_score,Contrast_score,Edge_score);
disp(T);

% Plotting scores
figure;
subplot(1,2,1);
hold on
plot(image,Contrast_score);
plot(image,Edge_score);
hold off
title("Contrast and Edge Score Progression - Brain MRI");
xlabel("Noisy Image")
ylabel("Score Achieved")
set(gca,'xtick',2:6)
legend('CSTM Score','MESSIM Score');
grid on
subplot(1,2,2);
hold on
plot(image,Noise_score);
hold off
title("Noise Score Progression - Brain MRI");
xlabel("Noisy Image")
ylabel("Score Achieved")
set(gca,'xtick',2:6)
legend('PSNR Score');
grid on

%% Deriving the type of noise
clc
% Subtract the filtered reference from the noisy image to find the noisy
% only
img = img_noise - slice_ref;
%Plotting the noise and histogram
figure;
subplot(2,3,1)
imshow(img_noise,[]);
title("Noisy Image - Volume 6");
subplot(2,3,2)
imshow(img_ref,[]);
title("Reference Image");
subplot(2,3,3)
imshow(img,[]);
title("Noise Content of the Image - Volume 6");
subplot(2,3,4)
histogram(img_noise,'Normalization','pdf');
title("Noisy Image Histogram");
subplot(2,3,5)
histogram(img_ref,'Normalization','pdf');
title("Reference Image Histogram");
subplot(2,3,6)
histogram(img,'Normalization','pdf');
title("Noise Histogram");
