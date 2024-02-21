%% Loïs GALLAUD I2S promo 2025
% Détection de contour
close all
clear

%% Filtres classiques

I = imread("frog.jpg");
I = rgb2gray(I);
I = double(I) / 255.0;

threshold = 0.5;

%% Affichage
figure;
subplot(2, 2, 1);
imshow(I, []);
title("Image originale");

% Prewitt
h = fspecial("prewitt");
v = -h';
Gh = filter2(h, I);
Gv = filter2(v, I);
G = sqrt(Gh.*Gh + Gv.*Gv);
Gs = (G > threshold);
subplot(2, 2, 2);
imshow(Gs, []);
title("Filtre Prewitt");

% Roberts
Gs = edge(I, "Roberts");
subplot(2, 2, 3);
imshow(Gs, []);
title("Filtre Roberts");

% Sobel
h = fspecial("sobel");
v = -h';
Gh = filter2(h, I);
Gv = filter2(v, I);
G = sqrt(Gh.*Gh + Gv.*Gv);
Gs = (G > threshold);
subplot(2, 2, 4);
imshow(Gs, []);
title("Filtre Sobel");

%% Laplacien du gaussien
sigma = 6e-3;
cameraman = imread("cameraman.tif");
lena = imread("lena256.tif");
cont_cameraman = edge(cameraman, "log", sigma);
cont_lena = edge(lena, "log", sigma);

figure;
subplot(2, 2, 1);
imshow(cameraman, []);
title("Image originale");

subplot(2, 2, 2);
imshow(cont_cameraman, []);
title("Contours LoG")

subplot(2, 2, 3);
imshow(lena, []);
title("Image originale");

subplot(2, 2, 4);
imshow(cont_lena, []);
title("Contours LoG")