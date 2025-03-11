function [G] = corrfunc(imgser)

% Adapted from:

% July 9, 2003
% David Kolin
 
% Calculates 2D correlation functions for each z slice of a given 3D matrix (imgser)
% Output as a 3D matrix with same dimensions as imgser
G = zeros(size(imgser)); % Preallocates matrix

for z=1:size(imgser,3)
    G(:,:,z) = ((fftshift(real(ifft2(fft2(double(imgser(:,:,z))).*conj(fft2(double(imgser(:,:,z))))))))/(mean(mean(imgser(:,:,z)))^2*size(imgser,1)*size(imgser,2))) - 1;

end
% 

