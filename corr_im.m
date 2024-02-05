%% Loïs GALLAUD I2S promo 2025
% Corrélation d'images
close all
clear

disp('Recalage d''images') ;
% Rotation de J (angle en degres)
ang = 30 ;

% Translation
tx = 5 ;
ty = 10 ;
a = 30 ;

%% Coordonnées pour le zoom
indices = 0 : a-1;
[x, y] = meshgrid(indices, indices);

% taille des images I et J
taille = 128;

% indices relatifs pour l'extraction
ext = -floor(taille/2) : -floor(taille/2) + taille-1;

%% LECTURE DE L'IMAGE et ROTATION
I0 = imread('trees.jpg') ;
I0 = rgb2gray(I0) ;
I0 = double(I0)/255.0 ;
centreI0 = floor(size(I0)/2) + [1 1] ; % point central

% Rotation
if (ang ~= 0)
    I1 = imrotate(I0, ang, 'bilinear') ;
else
    I1 = I0 ;
end
centreI1 = floor(size(I1)/2) + [1 1] ;

%% EXTRACTION DE I et J
I = I0(centreI0(1)+ext, centreI0(2)+ext) ;
figure;
subplot(4,2,1);
imshow(I);
title('image I');

J = I1(centreI1(1)+ext+tx, centreI1(2)+ext+ty) ;
subplot(4,2,2);
imshow(J);
title('image J');

%% SPECTRES
Itfd = fft2(I) ;
Jtfd = fft2(J) ;

% CORRELATION standard ; variable corr (matrice de corrélation)
corr = abs( ifft2(Itfd .* conj(Jtfd)) );
corr_zoom = corr(1:a, 1:a);

subplot(4,2,3);
imagesc(corr_zoom);
title('Corrélation standard (mod + phase)');

corr_zoom_color = zeros(size(corr_zoom)) ;
corr_zoom_color(1, end) = 1 ;

subplot(4,2,4);
mesh(x, y, corr_zoom, corr_zoom_color);
title('mesh corr standard');

%% CORRELATION DE PHASE
corr_phase = abs( ifft2( (angle(Itfd) .* conj(angle(Jtfd))) ) );
corr_phase_zoom = corr_phase(1:a, 1:a);

subplot(4,2,5);
imagesc(corr_phase_zoom);
title('Corr phase par angle(.)');
corr_phase_zoom_color = zeros(size(corr_phase_zoom)) ;
corr_phase_zoom_color(1,end) = 1;

subplot(4,2,6);
mesh(x,y,corr_phase_zoom,corr_phase_zoom_color);
title('mesh de la corr phase');

%% CORRELATION DE PHASE stratégie à proposer pour corréler uniquement
% les phases, variable CP2 (matrice de corrélation)

corr_phase_2 = abs(ifft2((Itfd./abs(Itfd)) .* conj(Jtfd./abs(Jtfd))))
corr_phase_zoom_2 = corr_phase_2(1:a, 1:a);

subplot(4,2,7);
imagesc(corr_phase_zoom_2);
title('Corr phase par calcul ./');
corr_phase_zoom_2_color=zeros(size(corr_phase_zoom_2)) ;
corr_phase_zoom_2_color(1,end) = 1;

subplot(4,2,8);
mesh(x, y, corr_phase_zoom_2, corr_phase_zoom_2_color);
title('mesh de la corr phase');

%% RECHERCHE AUTOMATIQUE DU PIC , variables col et lig
disp(fprintf('Translation réelle = (%d,%d)', tx, ty));
disp(fprintf('Rotation de %f', ang));

nblig = size(corr, 1);
[val, pos] = max(corr(:));
col = 1 + floor((pos - 1) / nblig);
lig = pos - nblig * (col - 1);
disp(fprintf('Recalage par corrélation classique. Translation estimée = (%d,%d)', lig - 1, col - 1));

nblig = size(corr_phase, 1);
[val, pos] = max(corr_phase(:));
col = 1 + floor((pos - 1) / nblig);
lig = pos - nblig * (col - 1);
disp(fprintf('Recalage par corrélation de phase V1. Translation estimée = (%d,%d)', lig - 1, col - 1));

nblig = size(corr_phase_2, 1);
[val, pos] = max(corr_phase_2(:));
col = 1 + floor((pos - 1) / nblig);
lig = pos - nblig * (col - 1);
disp(fprintf('Recalage par corrélation de phase V2. Translation estimée = (%d,%d)', lig - 1, col - 1));
