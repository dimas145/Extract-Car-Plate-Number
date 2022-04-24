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

[noPlate, img_plate] = extract_car_plate(img, imgbin, template);
subplot(2, 2, 4); imshow(img_plate); title('Extracted Plate Number');

disp('Plate Number = ');
disp(noPlate);