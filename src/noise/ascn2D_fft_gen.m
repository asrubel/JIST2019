function [ ASCN ] = ascn2D_fft_gen( AWGN, gsigma)
s = size(AWGN);
[x,y] = meshgrid(-s(2)/2:s(2)/2-1, -s(1)/2:s(1)/2-1);

G = exp(-pi*(x.^2 + y.^2)./(2*gsigma^2));
g = fft2(G);
n = fft2(AWGN);

ASCN = ifft2(g.*n);
ASCN = ASCN/std(ASCN(:));
return;