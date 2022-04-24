function template = create_template()
    folder = 'img/ref2/';

    A = imread(strcat(folder, 'A.bmp'));
    B = imread(strcat(folder, 'B.bmp'));
    C = imread(strcat(folder, 'C.bmp'));
    D = imread(strcat(folder, 'D.bmp'));
    E = imread(strcat(folder, 'E.bmp'));
    F = imread(strcat(folder, 'F.bmp'));
    G = imread(strcat(folder, 'G.bmp'));
    H = imread(strcat(folder, 'H.bmp'));
    I = imread(strcat(folder, 'I.bmp'));
    J = imread(strcat(folder, 'J.bmp'));
    K = imread(strcat(folder, 'K.bmp'));
    L = imread(strcat(folder, 'L.bmp'));
    M = imread(strcat(folder, 'M.bmp'));
    N = imread(strcat(folder, 'N.bmp'));
    O = imread(strcat(folder, 'O.bmp'));
    P = imread(strcat(folder, 'P.bmp'));
    Q = imread(strcat(folder, 'Q.bmp'));
    R = imread(strcat(folder, 'R.bmp'));
    S = imread(strcat(folder, 'S.bmp'));
    T = imread(strcat(folder, 'T.bmp'));
    U = imread(strcat(folder, 'U.bmp'));
    V = imread(strcat(folder, 'V.bmp'));
    W = imread(strcat(folder, 'W.bmp'));
    X = imread(strcat(folder, 'X.bmp'));
    Y = imread(strcat(folder, 'Y.bmp'));
    Z = imread(strcat(folder, 'Z.bmp'));
    
    num0 = imread(strcat(folder, '0.bmp'));
    num1 = imread(strcat(folder, '1.bmp'));
    num2 = imread(strcat(folder, '2.bmp'));
    num3 = imread(strcat(folder, '3.bmp'));
    num4 = imread(strcat(folder, '4.bmp'));
    num5 = imread(strcat(folder, '5.bmp'));
    num6 = imread(strcat(folder, '6.bmp'));
    num7 = imread(strcat(folder, '7.bmp'));
    num8 = imread(strcat(folder, '8.bmp'));
    num9 = imread(strcat(folder, '9.bmp'));
    
    letter = { A B C D E F G H I J K L M N O P Q R S T U V W X Y Z };
    number = { num0 num1 num2 num3 num4 num5 num6 num7 num8 num9 };
    template = [letter number];
end
