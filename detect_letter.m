function letter = detect_letter(letter_image, template)
    letter_image = imresize(letter_image, [42 24]);
    len = length(template);
    cors = zeros(1, len);

    for n = 1:len
        cor = corr2(template{n}, letter_image);
        cors(n) = cor;
    end

    ind = cors == max(cors);
    dict = strcat(char(65:90), char(48:57));
    letter = dict(ind);
end
