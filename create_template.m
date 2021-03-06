function template = create_template()
    A = imread('img/ref/A.bmp');
    B = imread('img/ref/B.bmp');
    C = imread('img/ref/C.bmp');
    D = imread('img/ref/D.bmp');
    E = imread('img/ref/E.bmp');
    F = imread('img/ref/F.bmp');
    G = imread('img/ref/G.bmp');
    H = imread('img/ref/H.bmp');
    I = imread('img/ref/I.bmp');
    J = imread('img/ref/J.bmp');
    K = imread('img/ref/K.bmp');
    L = imread('img/ref/L.bmp');
    M = imread('img/ref/M.bmp');
    N = imread('img/ref/N.bmp');
    O = imread('img/ref/O.bmp');
    P = imread('img/ref/P.bmp');
    Q = imread('img/ref/Q.bmp');
    R = imread('img/ref/R.bmp');
    S = imread('img/ref/S.bmp');
    T = imread('img/ref/T.bmp');
    U = imread('img/ref/U.bmp');
    V = imread('img/ref/V.bmp');
    W = imread('img/ref/W.bmp');
    X = imread('img/ref/X.bmp');
    Y = imread('img/ref/Y.bmp');
    Z = imread('img/ref/Z.bmp');
    
    num0 = imread('img/ref/0.bmp');
    num1 = imread('img/ref/1.bmp');
    num2 = imread('img/ref/2.bmp');
    num3 = imread('img/ref/3.bmp');
    num4 = imread('img/ref/4.bmp');
    num5 = imread('img/ref/5.bmp');
    num6 = imread('img/ref/6.bmp');
    num7 = imread('img/ref/7.bmp');
    num8 = imread('img/ref/8.bmp');
    num9 = imread('img/ref/9.bmp');
    
    letter = { A B C D E F G H I J K L M N O P Q R S T U V W X Y Z };
    number = { num0 num1 num2 num3 num4 num5 num6 num7 num8 num9 };
    template = [letter number];
end
