%% Loïs GALLAUD I2S promo 2025
close all
addpath("images");

%% Afficher l'image
cameraman = imread("cameraman-texture.tif");

figure(1);
subplot(2, 3, 1);
imshow(cameraman, []);
title("Image bruitée");

% Calcul de la TF
ft_cam = fft2(cameraman);
shifted_cam = fftshift(ft_cam);
ampl_cam = abs(shifted_cam);
subplot(2, 3, 4);
imshow(log(ampl_cam+eps), []);
title("TF image bruitée");

%% Texture du bruit
texture = rgb2gray(imread("texture.jpg"));
texture = double(texture);

subplot(2, 3, 2);
imshow(texture, []);
title("Texture");

% Calcul de la TF
ft = fft2(texture);
shifted = fftshift(ft);
ampl = abs(shifted);
subplot(2, 3, 5);
imshow(log(ampl+eps), []);
title("TF texture");

%% Reconstruction
% Masque du zero (couleurs de l'image)
square_size = 20;
half_len = floor(square_size/2);
center_x = 127;
center_y = 127;
mask_zero = zeros(mask_size);
mask_zero(center_x - half_len : center_x + half_len, ...
     center_y - half_len : center_y + half_len) = 1;

% Masque Texture
threshold = max(mean(ampl))/8;
mask = 1-(ampl > threshold).*(1-mask_zero);

% Filtrage
filtered = fftshift(ft_cam) .* mask;

% Affichage du masque
subplot(2, 3, 6);
%imshow(mask, []);
imshow(log(abs(filtered)+eps), ...
   [min(log(ampl(:))), max(log(ampl(:)))]);
title('TF masquée');

% Reconstruction de l'image après débruitage
reconstructed = ifft2(ifftshift(filtered));
subplot(2, 3, 3);
imshow(abs(reconstructed), []);
title("Image débruitée");

figure;
imshow(abs(reconstructed), []);
title("Image débruitée");

