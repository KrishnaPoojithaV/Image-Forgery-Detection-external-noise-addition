# Image-Forgery-Detection-external-noise-addition
In this project, a tampered medical image given as input is split into three components – red, blue and green. These images are then fed to a filter  called the weiner filter which  removes noise from the image and gives a noise free image I1. 
Noise is added to the original image and weiner filter is applied to the noise added image to obtain noise free image I2 to demonstrate the above scenario. Subtracting I2 from I1 gives a noise pattern. This noise pattern determines the percentage match between the noise free images I1 and I2.  

Mathematical Functions used in the module:

imnoise(color,'noise',fraction);
wiener2(noise_image,[5 5]);
imsubtract(image_1,image_2);
ait_picmatch(image_1,image_2);

If the percentage match between the image to be detected and its noise-free image is above 90%, we consider it to be intact- no forgery has been done, since it includes negligible amount of noise. Else, the image is considered to be forged.
