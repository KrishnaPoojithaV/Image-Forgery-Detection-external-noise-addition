clc;
close all;
clear all;
img = imread('lung.jpeg'); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel

%salt and pepper-noise added to each component of color image
J1 = imnoise(red,'salt & pepper',0.01);
subplot(3,4,1);imshow(J1(240:400,1:240));
J2 = imnoise(green,'salt & pepper',0.01);
subplot(3,4,5);imshow(J2(240:400,1:240));
J3 = imnoise(blue,'salt & pepper',0.01);
subplot(3,4,9);imshow(J3(240:400,1:240));

%remove noise using median filter
K1 = medfilt2(red);
subplot(3,4,2);imshow(K1(240:400,1:240));
K2 = medfilt2(green);
subplot(3,4,6);imshow(K2(240:400,1:240));
K3 = medfilt2(blue);
subplot(3,4,10);imshow(K3(240:400,1:240));

%subtract noise-free image obtained from filtering from noise added image
%to get a noise pattern
S1 = imsubtract(J1,K1);
subplot(3,4,3);imshow(S1);
S2 = imsubtract(J2,K2);
subplot(3,4,7);imshow(S2);
S3 = imsubtract(J3,K3);
subplot(3,4,11);imshow(S3);

%pattern obtained by subtracting noise free image obtained by filterng from
%the original image
Sa = imsubtract(red,K1);
subplot(3,4,4);imshow(Sa);
Sb = imsubtract(green,K2);
subplot(3,4,8);imshow(Sb);
Sc = imsubtract(blue,K3);
subplot(3,4,12);imshow(Sc);

% The function takes above two noise patterns as argument and using edge detection
% checks whether they are same or not.

l=ait_picmatch(S1,Sa);
m=ait_picmatch(S2,Sb);
n=ait_picmatch(S3,Sc);
disp('percentage match of red component of noise patterns');
disp(l);
disp('percentage match of green component of noise patterns');
disp(m);
disp('percentage match of blue component of noise patterns');
disp(n);
percent=(l+m+n)/3;
disp('average of pecentage match of the three noise patterns');
disp(percent);

if(percent>=90) %since 90% obtained for very little noise while trnsmission which can be negligible
    disp(' Hence the pictures have been matched, SAME PICTURES ');
else
    disp(' Hence the pictures have not been matched, DIFFERENT PICTURES ');
end

function result=ait_picmatch(pic1,pic2)
[x,y,z] = size(pic1);
if(z==1)
    ;
else
    pic1 = rgb2gray(pic1);
end
[x,y,z] = size(pic2);
if(z==1)
    ;
else
    pic2 = rgb2gray(pic2);
end
%applying edge detection on first noise pattern 
%so that we obtain white and black points and edges of the objects present
%in the pattern.
edge_det_pic1 = edge(pic1,'prewitt');

%applying edge detection on second noise pattern
%so that we obtain white and black points and edges of the objects present
%in the pattern.
edge_det_pic2 = edge(pic2,'prewitt');

%initialization of different variables used
matched_data = 0;
white_points = 0;
black_points = 0;

%for loop used for detecting black and white points in the picture.
for a = 1:1:x
    for b = 1:1:y
        if(edge_det_pic1(a,b)==1)
            white_points = white_points+1;
        else
            black_points = black_points+1;
        end
    end
end
%for loop comparing the white (edge points) in the two pictures
for i = 1:1:x
    for j = 1:1:y
        if(edge_det_pic1(i,j)==1)&(edge_det_pic2(i,j)==1)
            matched_data = matched_data+1;
            else
                ;
        end
    end
end
    
%calculating percentage matching.
total_data = white_points;
total_matched_percentage_noise_pattern = (matched_data/total_data)*100;
result=total_matched_percentage_noise_pattern; %returning the result percentage match between the noise patterns
end