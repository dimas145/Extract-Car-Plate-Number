function [plate_num, extracted_img] = extract_car_plate(img, imgbin, template)
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

    extracted_img = imcrop(img, boundingBox);

    img_bin_plate = imcrop(imgbin, boundingBox);
    img_bin_plate = ~bwareaopen(~img_bin_plate, 500);
    [h, w] = size(img_bin_plate);

    Iprops = regionprops(img_bin_plate, 'BoundingBox', 'Area', 'Image');
    count = numel(Iprops);
    plate_num = '';
    for i = 1:count
        ow = length(Iprops(i).Image(1,:));
        oh = length(Iprops(i).Image(:,1));
        if ow<(w/2) && oh>(h/3)
            letter = detect_letter(Iprops(i).Image, template);
            plate_num = strcat(plate_num, letter);
        end
    end
end
