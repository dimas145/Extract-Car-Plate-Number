g = gcf;
g.WindowState = 'maximized';

template = create_template();

img_path = "img/plat_kuning.png";
img = imread(img_path);
% subplot(2, 2, 1); imshow(img); title('Original Image');
% 
imgray = rgb2gray(img);
% imgbin = imbinarize(imgray);
% subplot(2, 2, 2); imshow(imgray); title('Gray Image');
% subplot(2, 2, 3); imshow(imgbin); title('Binary Image');
% % imgbin = ~imgbin;
% 
% [noPlate, img_plate] = extract_car_plate(img, imgbin, template);
% subplot(2, 2, 4); imshow(img_plate); title('Extracted Plate Number');
% 
% disp('Plate Number = ');
% disp(noPlate);

% figure,
subplot(2, 2, 1); imshow(img); title('Original Image');

g = medfilt2(imgray, [3, 3]);
subplot(2, 2, 2); imshow(g); title('Median Filtered Image');

se = strel('disk', 1);
gi = imdilate(g, se);
ge = imerode(g, se);
gdiff = imsubtract(gi, ge);
gdiff = mat2gray(gdiff);
gdiff = conv2(gdiff, [0.5 0.5;0.5 0.5]);
gdiff = imadjust(gdiff, [0.5 0.7], [0 1], 0.1);
B = logical(gdiff);
subplot(2, 2, 3); imshow(B); title('Edge Enhanced Image');

er = imerode(B, strel('line', 50, 0));
out1 = imsubtract(B, er);
F = imfill(out1, 'holes');
H = bwmorph(F, 'thin', 1);
H = imerode(H, strel('line', 3, 90));
final = bwareaopen(H, 100);
subplot(2, 2, 4); imshow(final); title('Removed Lines Image');

Iprops = regionprops(final, 'BoundingBox', 'Area', 'Image');
[h, w] = size(final);
boundingBox = Iprops.BoundingBox;
count = numel(Iprops);
plate_num = '';
for i = 1:count
    ow = length(Iprops(i).Image(1,:));
    oh = length(Iprops(i).Image(:,1));
    figure,
    imshow(Iprops(i).Image);
    if ow<(w/2) && oh>(h/3)
        letter = detect_letter(Iprops(i).Image, template);
        plate_num = strcat(plate_num, letter);
    end
end
disp("plate_num: ")
disp(plate_num)
