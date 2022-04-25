img_path = "img/car_2.png";
img = imread(img_path);
%img = cat(3,histeq(img(:,:,1)), histeq(img(:,:,2)), histeq(img(:,:,3)));
img = padarray(img,[20,20],0);

imgray = rgb2gray(img);
imgray = imbilatfilt(imgray,11);
imgbin = imbinarize(imgray);
%imgbin = padarray(imgbin,[20 20],0);
%imgbin = edge(imgbin,'canny');
%imgbin = imclose(imgbin,strel('disk',3));

% Use regionprops to measure MSER properties
mserStats = regionprops(imgbin, 'BoundingBox', 'Eccentricity', ...
    'Solidity', 'Extent', 'Euler', 'Image', 'Circularity', 'Area');

% Compute the aspect ratio using bounding box data.
bbox = vertcat(mserStats.BoundingBox);
w = bbox(:,3);
h = bbox(:,4);
aspectRatio = w./h;
area = numel(imgbin);
bbox_area = bbox(:,3).*bbox(:,4);

% Threshold the data to determine which regions to remove. These thresholds
% may need to be tuned for other images.
filterIdx = aspectRatio' < 1; 
filterIdx = filterIdx | bbox_area' > 0.3 * area | bbox_area' < 0.01 * area;  
filterIdx = filterIdx | [mserStats.Eccentricity] > .995 ;
%filterIdx = filterIdx | [mserStats.Solidity] < .3;
%filterIdx = filterIdx | [mserStats.Extent] < 0.2 | [mserStats.Extent] > 0.9;
%filterIdx = filterIdx | [mserStats.EulerNumber] < -4;
filterIdx = filterIdx | [mserStats.Circularity] > 1.4;

% Remove regions
mserStats(filterIdx) = [];
%mserRegions(filterIdx) = [];

% Show remaining regions
figure
imshow(imgbin)
hold on
count = numel(mserStats);
for i = 1:count
    rectangle('Position', mserStats(i).BoundingBox, 'LineWidth', 3, 'EdgeColor', 'g')
end
%plot(mserRegions, 'showPixelList', true,'showEllipses',false)
title('After Removing Non-Text Regions Based On Geometric Properties')
hold off

% Get bounding boxes for all the regions
bboxes = vertcat(mserStats.BoundingBox);

% Convert from the [x y width height] bounding box format to the [xmin ymin
% xmax ymax] format for convenience.
xmin = bboxes(:,1);
ymin = bboxes(:,2);
xmax = xmin + bboxes(:,3) - 1;
ymax = ymin + bboxes(:,4) - 1;

% Expand the bounding boxes by a small amount.
expansionAmount = 0.02;
xmin = (1-expansionAmount) * xmin;
ymin = (1-expansionAmount) * ymin;
xmax = (1+expansionAmount) * xmax;
ymax = (1+expansionAmount) * ymax;

% Clip the bounding boxes to be within the image bounds
xmin = max(xmin, 1);
ymin = max(ymin, 1);
xmax = min(xmax, size(imgray,2));
ymax = min(ymax, size(imgray,1));

% Show the expanded bounding boxes
expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];
IExpandedBBoxes = insertShape(img,'Rectangle',expandedBBoxes,'LineWidth',3);

figure
imshow(IExpandedBBoxes)
title('Expanded Bounding Boxes Text')

% Compute the overlap ratio
overlapRatio = bboxOverlapRatio(expandedBBoxes, expandedBBoxes);

% Set the overlap ratio between a bounding box and itself to zero to
% simplify the graph representation.
n = size(overlapRatio,1); 
overlapRatio(1:n+1:n^2) = 0;

% Create the graph
g = graph(overlapRatio);

% Find the connected text regions within the graph
componentIndices = conncomp(g);

% Merge the boxes based on the minimum and maximum dimensions.
xmin = accumarray(componentIndices', xmin, [], @min);
ymin = accumarray(componentIndices', ymin, [], @min);
xmax = accumarray(componentIndices', xmax, [], @max);
ymax = accumarray(componentIndices', ymax, [], @max);

% Compose the merged bounding boxes using the [x y width height] format.
textBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];

% Remove bounding boxes that only contain one text region
numRegionsInGroup = histcounts(componentIndices);
textBBoxes(numRegionsInGroup == 1, :) = [];

% Show the final text detection result.
ITextRegion = insertShape(img, 'Rectangle', textBBoxes,'LineWidth',3);

figure
imshow(ITextRegion)
title('Detected Text')