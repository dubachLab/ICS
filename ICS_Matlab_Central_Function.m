%% ICS for the green segmented area
% constants
x_1=[-9:1:10];
y_1=[-9:1:10];
x_1=x_1*pixel;
y_1=y_1*pixel;

% run ICS where i represents the ROI from an image to be analyzed
%Mean filling the areas not associated with segmentation
marker_crop_1{i}=marker_crop{i};

invert_1{i}=~marker_segment_crop{i}; % signal to 0 and zeros to ones

marker_crop_1{i}(invert_1{i})=mean2(marker_crop{i}(marker_segment_crop{i})); % zeros to mean with signal inside

%Calculating correction factor for mean fill + padding
totalsegarea_1{i}=sum(sum(marker_segment_crop{i})); %number of pixels in ROI
totalarea_1{i}=size(marker_crop_1{i},1)*size(marker_crop_1{i},2); %number of pixels in bounding box
ratio_area_1{i}=totalsegarea_1{i}/totalarea_1{i}; %ratio of pixels with ROI in bounding box
corr_factor_1{i}=(1/ratio_area_1{i})*9; %9 for image padding in next section

%Mean padding
A1_1{i}=size(marker_crop_1{i},1); B1_1{i}=size(marker_crop_1{i},2);
padimgser1_1{i}=padarray(marker_crop_1{i},[A1_1{i} B1_1{i}], mean2(marker_crop{i}(marker_segment_crop{i})));

%Calculating green correlation function and applying correction
[G11_1{i}]=corrfunc(padimgser1_1{i}); % FUNCTION corrfunc
negativecorr1_1=G11_1{i}<0;
G11_1{i}(negativecorr1_1)=0;
G11_1{i}=G11_1{i}.*corr_factor_1{i};

%Crop and fit green correlation function
try G11crop_1{i} = autocrop(G11_1{i},10); %FUNCTION autocrop - crops to 20x20 around peak
    [fitresult11_1{i}, gof11_1{i}] = create2Dfit(x_1, y_1, G11crop_1{i}); % FUNCTION create2Dfit
    coeff11_1{i}=coeffvalues(fitresult11_1{i});
    g11_1{i}=coeff11_1{i}(1);
    lag11_1{i}=coeff11_1{i}(2);
    w011_1{i}=coeff11_1{i}(3);

catch
    g11_1{i}=NaN;
    lag11_1{i}=NaN;
    w011_1{i}=NaN;
end

%Creating variables
NoP_g1{i}=1/g11_1{i};
mean_g1{i}=mean2(marker_crop{i}(marker_segment_crop{i}));
w011_1{i}=w011_1{i};

