template = create_template();

img_path = "img/car_3.png";
img = imread(img_path);
figure, imshow(img); title('Original Image');

imgray = rgb2gray(img);
figure, imshow(imgray); title('1 - Grayscale Conversion');

gray = imbilatfilt(imgray,10);
%gray = histeq(gray);
figure, imshow(imgray); title('2 - Bilateral Filter');

edged = edge(imgray, 'canny');
figure, imshow(edged); title('3 - Canny Edges');

cnts = bwboundaries(edged);
figure, imshow(img); title('4 - All Contours');
hold on;
for k = 1:length(cnts)
    boundary = cnts{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 3);
end

cnt_areas = zeros(length(cnts));
for k = 1:length(cnts)
    boundary = cnts{k};
    cnt_areas(k) = polyarea(boundary(:,2), boundary(:,1));
end
[cnts_areas_sorted, i] = sort(cnt_areas,'descend');
cnts = cnts(i);
cnts = cnts(1:30);

figure, imshow(img); title('5 - Top 30 Contours')
hold on;
for k = 1:length(cnts)
    boundary = cnts{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 3);
end

z = regionprops(edged,'BoundingBox', 'Area');
disp(size(z));

%{
Iprops = regionprops(im, 'BoundingBox', 'Area', 'Image');
count = numel(Iprops);
maxa = Iprops.Area;
boundingBox = Iprops.BoundingBox;
for i = 1:count
    if maxa < Iprops(i).Area
        maxa = Iprops(i).Area;
        boundingBox = Iprops(i).BoundingBox;
    end
    %figure, imshow(imcrop(im, Iprops(i).BoundingBox));
end

img_plate = imcrop(img, boundingBox);
subplot(2, 2, 4); imshow(img_plate); title('Extracted Plate Number');

img_bin_plate = imcrop(imgbin, boundingBox);
img_bin_plate = ~bwareaopen(~img_bin_plate, 500);
[h, w] = size(img_bin_plate);

Iprops = regionprops(img_bin_plate, 'BoundingBox', 'Area', 'Image');
count = numel(Iprops);
noPlate = '';
for i = 1:count
    ow = length(Iprops(i).Image(1,:));
    oh = length(Iprops(i).Image(:,1));
    if ow<(w/2) && oh>(h/3)
        letter=detect_letter(Iprops(i).Image, template);
        noPlate=strcat(noPlate, letter);
    end
end

disp('Plate Number = ');
disp(noPlate);
%}