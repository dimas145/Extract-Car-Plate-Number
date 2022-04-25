function plate = preprocess_plate(plate_img, ref_image)
    lab_img = rgb2lab(plate_img);
    [rows, columns, channels] = size(lab_img);
    LChannel = lab_img(:,:,1);
    aChannel = lab_img(:,:,2);
    bChannel = lab_img(:,:,3);

    yellow_image = cat(3, 255 * ones(200, 200), 255 * ones(200, 200), 0 * ones(200, 200));
    ref_lab_img = rgb2lab(ref_image);
    refLChannel = ref_lab_img(:,:,1);
    refaChannel = ref_lab_img(:,:,2);
    refbChannel = ref_lab_img(:,:,3);

    ref_deltaE = sqrt(refLChannel(:) .^ 2 + refaChannel(:) .^ 2 + refbChannel(:) .^ 2);
    mean_ref = mean2(ref_deltaE);
    std_ref = std(ref_deltaE);

    LMean = mean2(refLChannel);
    aMean = mean2(refaChannel);
    bMean = mean2(refbChannel);
        
    LStandard = LMean * ones(rows, columns);
    aStandard = aMean * ones(rows, columns); 
    bStandard = bMean * ones(rows, columns);

    deltaL = LChannel - LStandard;
    deltaa = aChannel - aStandard;
    deltab = bChannel - bStandard;

    deltaE = sqrt(deltaL .^ 2 + deltaa .^ 2 + deltab .^ 2);

    
    thres = mean_ref + 1 * std_ref;
    %thres = 50;
    bw = deltaE <= thres;
    subplot(2,2,1), imshow(plate_img);
    subplot(2,2,2), imshow(ref_image);
    subplot(2,2,3), imshow(deltaE, []);
    subplot(2,2,4), imshow(bw)
    disp(max(max(ref_deltaE)));
    disp(min(min(ref_deltaE)));
    disp(mean_ref);
    disp(std_ref);
    disp(max(max(deltaE)));
    disp(min(min(deltaE)));
    disp(thres);
end