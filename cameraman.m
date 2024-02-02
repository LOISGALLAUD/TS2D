%% Loïs GALLAUD I2S promo 2025
close all
addpath('images');

%% Afficher une image
path = "cameraman.tif";
image = imread(path);
image = double(image);

figure(1);
subplot(2, 3, 1);
imshow(image, []);
title("Image originale")

%% Inverser une image
inverted = 255 - image;

subplot(2, 3, 2);
imshow(inverted, []);
title("Image inversée");

%% Tranformée de Fourier
ft = fft2(image);
shifted = fftshift(ft);
amplitude = abs(shifted);
phase = angle(shifted);

% Amplitude
subplot(2, 3, 3);
imshow(log(amplitude+eps), []);
axis off;
title("Amplitude de la TF");

% Phase
subplot(2, 3, 4);
imshow(phase, []);
axis off;
title("Phase de la TF");

% Créer le masque
mask_size = 256;
square_size = 20;
half_len = floor(square_size/2);
center_x = 127;
center_y = 127;

mask = zeros(mask_size);
mask(center_x - half_len : center_x + half_len, ...
     center_y - half_len : center_y + half_len) = 1;

% Appliquer le masque à la transformée de Fourier
ft_masked = shifted .* mask;
subplot(2, 3, 5);
imshow(log(abs(ft_masked)+eps), ...
    [min(log(amplitude(:))), ...
    max(log(amplitude(:)))]);
axis off;
title("Amplitude masquée")

% Afficher l'image reconstruite
image_reconstructed = ifft2(ifftshift(ft_masked));
subplot(2, 3, 6);
imshow(abs(image_reconstructed), []);
title("Image reconstruite");

%% Autre Figure
figure(2);
imshow(abs(image_reconstructed), []);
axis off;
title("Reconstruction avec TF masquée");