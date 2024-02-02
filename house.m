%% Loïs GALLAUD I2S promo 2025
close all
addpath("images");

%% Filtrage du bruit
house = double(rgb2gray(imread("house.jpg")));
house_noise = double(imread("house_noise.jpg"));

figure(1);
subplot(2, 3, 1);
imshow(house, []);
title("house");

subplot(2, 3, 2);
imshow(house_noise, []);
title("house noise");

ft_house = fftshift(fft2(house));
amplitude_house = abs(ft_house);
ft_house_noise = fftshift(fft2(house_noise));
amplitude_noise = abs(ft_house_noise);

subplot(2, 3, 4);
imshow(log(amplitude_house+eps), []);
title("TF house");

subplot(2, 3, 5);
imshow(log(amplitude_noise+eps), []);
title("TF house noise");

%% Passe-bas : filtrage du bruit
SIZE = 180;
LPF = zeros(256, 256);
LPF((129-SIZE/2):(128+SIZE/2), ...
    (129-SIZE/2):(128+SIZE/2)) = ones(SIZE,SIZE);
filtered_house = ft_house_noise .* LPF;

subplot(2, 3, 6);
imshow(log(abs(filtered_house) + eps), ...
    [min(log(amplitude_noise(:))), ...
    max(log(amplitude_noise(:)))]);
title("TF filtrée");

% Reconstruction de l'image bruitée filtrée
reconstructed = ifft2(ifftshift(filtered_house));
subplot(2, 3, 3);
imshow(abs(reconstructed), []);
title("Image reconstruite");

%% Téléchargement de l'image
% dl_path = "im.jpg";
% imwrite(abs(reconstructed), dl_path);

