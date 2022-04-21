g = gcf;
g.WindowState = 'maximized';

template = create_template();

img_path = "img/plat_hitam.png";
img = imread(img_path);
subplot(2, 2, 1); imshow(img); title('Original Image');

imgray = rgb2gray(img);
imgbin = imbinarize(imgray);
subplot(2, 2, 2); imshow(imgray); title('Gray Image');
subplot(2, 2, 3); imshow(imgbin); title('Binary Image');
% imgbin = ~imgbin;

Iprops = regionprops(~imgbin, 'BoundingBox', 'Area', 'Image');
count = numel(Iprops);
maxa = Iprops.Area;
boundingBox = Iprops.BoundingBox;
for i = 1:count
    if maxa < Iprops(i).Area
        maxa = Iprops(i).Area;
        boundingBox = Iprops(i).BoundingBox;
    end
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