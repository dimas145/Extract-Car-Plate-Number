img_path = "img/car_2.png";
img = imread(img_path);
%img = cat(3,histeq(img(:,:,1)), histeq(img(:,:,2)), histeq(img(:,:,3)));

imgray = rgb2gray(img);
imgray = imbilatfilt(imgray,11);
imgbin = imbinarize(imgray);

stats = regionprops(imgbin,'Image', 'Circularity', 'BoundingBox');
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

[h, w] = size(imgbin);
template = create_template();

count = numel(stats);
plate_num = '';
for i = 1:count
    ow = length(stats(i).Image(1,:));
    oh = length(stats(i).Image(:,1));
    if ow<(w/2)
        %figure, imshow(stats(i).Image)
        %letter = detect_letter(stats(i).Image, stats(i).Image, template);
        %plate_num = strcat(plate_num, letter);
    end
end