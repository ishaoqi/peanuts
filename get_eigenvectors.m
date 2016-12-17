s1 = input('please input PCA file:','s');
s2 = input('please input original file:','s');
img_PCA = multibandread(s1,[479 320 157],'float', 0, 'bsq', 'ieee-le');
img_PCA_1 = reshape(img_PCA, 479*320, 157);
img_org = multibandread(s2, [479 320 157],'double', 0, 'bsq', 'ieee-le');
img_org_1 = reshape(img_org, 479*320, 157);
rank1 = rank(img_org_1);
rank2 = rank([img_org_1 img_PCA_1]);
[L,U]=lu(img_org_1);
cof = U\(L\img_PCA_1);
s = 'end'



