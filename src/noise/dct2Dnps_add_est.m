function [ NPS ] = dct2Dnps_add_est( nimg, Trans2D ) %#codegen
bsize = size(Trans2D,2);
s = size(nimg)-bsize+1;
vDCT = zeros(bsize^2,s(1)*s(2));

ind = 1;
for i = 1:s(1)
    for j = 1:s(2)
        bspat = nimg(i:i+bsize-1,j:j+bsize-1);
        bdct = Trans2D*bspat*Trans2D';
        vDCT(:,ind) = bdct(:).^2;
        ind = ind + 1;
    end
end
mvDCT = mean(vDCT,2);

NPS = reshape(mvDCT,[bsize,bsize]);
NPS(1,1) = 0;
NPS = NPS*(bsize^2-1)./sum(NPS(:));
NPS = sqrt(NPS);
return;