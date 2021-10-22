function [] = imageQuality_overall(N,C,E)
%IMAGEQUALITY_OVERALL Summary of this function goes here
%   Detailed explanation goes here
Score = 0;
disp([" "]);
% Checking noisyness
% if the noise is between 30 and 50, then it's not a noisy image

disp(["The image noise score is " + int2str(N)]);
if (30<=N) && (N<=50)
    disp(["The image does not have a large amount of noise, it's between 30dB and 50dB"]);
    Score = Score + 1;
else
    disp(["The image contains a large amount of noise"]);
    Score = Score - 1;
end

% Checking contrast
% if the CSTM is greater than 0.5, then enough contrast has been preserved
% to preserve the structrual map of the image, anything below is considered
% too low in contrast. The value must be between 0 and 1.

disp(["The image structural contrast score is " + num2str(C)]);
if (C>=0.5)
      disp(["The image has retained structural contrast depite the noise content, the score is greater than 0.5"]);
      Score = Score + 1;
else
    disp(["The image has lost structural contrast due to noise, the score is less than 0.5"]);
    Score = Score - 1;
end  

% Checking edge quality
% if the MESSIM is below 0.7, then either blurring or other types of noise
% (such as impulsive or poisson) have erroded too much of the edge content.
% This means that the image no longer has the structual content it used to
% have. ESSIM is also a measure of the luminescence, contrast and edge strcuture.
% With more weight being given to the centre pixel (thorugh local
% application of a gaussian filter (11x11) when sampling).

disp(["The image mean edge strctural similarity score is " + num2str(E)]);
if (E>=0.7)
      disp(["The image has retained edge quality depite the noise content, the score is greater than 0.7"]);
      Score = Score + 1;
else
    disp(["The image has lost edge quality due to noise, the score is less than 0.7"]);
    Score = Score - 1;
end  

% Judging the overall score
disp([" "]);
if Score < 0
    disp(["The image quality is very low"]);
elseif Score == 0
    disp(["The image quality is very low"]);
elseif Score == 1
    disp(["The image quality is low"]);
elseif Score == 2
    disp(["The image quality is average"]);
elseif Score == 3
    disp(["The image quality is high"]);
end

end

