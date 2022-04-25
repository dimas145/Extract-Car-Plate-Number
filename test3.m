img_path = "img/car_3.png";
img = imread(img_path);
img = cat(3,histeq(img(:,:,1)), histeq(img(:,:,2)), histeq(img(:,:,3)));

imgray = rgb2gray(img);
imgray = imbilatfilt(imgray,11);
imgray = histeq(imgray);
imgbin = imbinarize(imgray);

stats = regionprops(imgbin,'Perimeter', 'Area', 'FilledArea', 'Solidity', 'Centroid', 'Circularity', 'BoundingBox');
b = [stats.Circularity];
b = b';
stats = stats(b < 1.4);

count = numel(stats);

figure, imshow(img);
figure, imshow(imgray);
figure, imshow(imgbin);

figure, imshow(img);
hold on
for i = 1:count
    rectangle('Position', stats(i).BoundingBox, 'LineWidth', 3, 'EdgeColor', 'g')
end

figure, imshow(imgray);
hold on
for i = 1:count
    rectangle('Position', stats(i).BoundingBox, 'LineWidth', 3, 'EdgeColor', 'g')
end

figure, imshow(imgbin);
hold on
for i = 1:count
    rectangle('Position', stats(i).BoundingBox, 'LineWidth', 3, 'EdgeColor', 'g')
end