function [crop,rect] = autocrop(series,tofit)

% Crops a region of an image series AUTOMATICALLY, and outputs a smaller 3D matrix

[ZeroChanRow, ZeroChanCol] = find(ismember(series(:,:,1),max(max(series(:,:,1))))); % find location of max



%if tofit is too big, reduce
if ((tofit*2) > size(series,1))
    tofit = (size(series,1)/2-1);
end
if ((tofit*2) > size(series,2))
    tofit = (size(series,2)/2-1);
end

rect = [ZeroChanCol-tofit ZeroChanRow-tofit 2*tofit-1 2*tofit-1];  

rect = ceil(rect);

crop = zeros(rect(4)+1,rect(3)+1,size(series,3)); % Pre-allocates matrix

for i=1:size(series,3)
    crop(:,:,i) = imcrop(series(:,:,i),rect);
end