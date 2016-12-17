%%
% 
%  PREFORMATTED
%  标记控制的分水岭算法
% 

% s1 = input('Please input file:','s');
% nrow = 468;
% ncol = 241;
% nbands = 91;
[img1,info] = enviread('C:\Users\qixia\Desktop\peanut\band55.img','C:\Users\qixia\Desktop\peanut\band55.hdr');
nrow = info.lines;
ncol = info.samples;
% img = multibandread(s1,[nrow ncol nbands],'double',0,'bsq','ieee-le');
% img1 = img(:,:,1);
% %将图像转换到0-255
% max_value = max(img1(:));
% min_value = min(img1(:));
% min_value_matrix = ones(479,320) .* min_value;
% index = find(abs(img1)>0);
% img_nor = zeros(479,320);
% img_nor(index) = (img1(index) - min_value)./(max_value - min_value) .* 255;
% % img_nor = (img1 - min_value_matrix)./(max_value - min_value) .* 255;
% 
% img1 = img_nor;

% imshow(img1);
% title('original image (img1)');

%计算梯度幅值图像
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(img1),hy,'replicate');
Ix = imfilter(double(img1),hx,'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
% figure
% imshow(gradmag,[]),title('radient magnitude (gradmag)');

%标记前景对象
se = strel('disk',3);%圆形模板核
Io = imopen(img1,se);%开操作，是腐蚀后膨胀
% figure
% imshow(Io),title('Opening(Io)')
%通过腐蚀后重建来做基于开的重建计算
Ie = imerode(img1, se);%图像腐蚀
Iobr = imreconstruct(Ie, img1);%图像重建
% figure
% imshow(Iobr),title('Opening-by-reconstruction (Iobr)')

Ioc = imclose(Io, se);%闭操作，可以移除较暗的斑点和枝干标记
% figure
% imshow(Ioc),title('Opening-closing(Ioc)')
%图像膨胀
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
% figure
% imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')
%计算Iobrcbr的局部极大来得到更好的前景标记
fgm = imregionalmax(Iobrcbr);
% figure
% imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')
I2 = img1;
I2(fgm) = 255;
% figure
% imshow(I2), title('Regional maxima superimposed on original image (I2)')

%注意到大多闭塞处和阴影对象没有被标记，这就意味着这些对象在结果中将不会得到合理的分割。
%而且，一些对象的前景标记会一直到对象的边缘。这就意味着应该清理标记斑点的边缘，然后收缩它们。
%可以通过闭操作和腐蚀操作来完成。
se2 = strel(ones(3,3));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 3);%BW2 = bwareaopen(BW,P)从二值图像中移除所以少于P像素值的连通块，
                           %得到另外的二值图像BW2
I3 = img1;
I3(fgm4) = 255;
% figure
% imshow(I3)
% title('Modified regional maxima superimposed on original image (fgm4)')
%计算背景标记
%现在，需要标记背景。在清理后的图像Iobrcbr中，暗像素属于背景，所以可以从阈值操作开始。
thresh = graythresh(Iobrcbr);
bw = im2bw(Iobrcbr,thresh);
% figure
% imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

%背景像素在黑色区域，但是理想情形下，不必要求背景标记太接近于要分割的对象边缘。
%通过计算“骨架影响范围”来“细化”背景，或者SKIZ，bw的前景。
%这个可以通过计算bw的距离变换的分水岭变换来实现，然后寻找结果的分水岭脊线（DL==0）。
%D = bwdist(BW)计算二值图像BW的欧几里得矩阵。
%对BW的每一个像素，距离变换指定像素和最近的BW非零像素的距离。
%bwdist默认使用欧几里得距离公式。BW可以由任意维数，D与BW有同样的大小。
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
% figure
% imshow(bgm), title('Watershed ridge lines (bgm)')

%计算分割函数的分水岭变换
%函数imimposemin可以用来修改图像，使其只是在特定的要求位置有局部极小。
%这里可以使用imimposemin来修改梯度幅值图像，使其只在前景和后景标记像素有局部极小。
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);
I4 = img1;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
% figure
% imshow(I4)
% title('Markers and object boundaries superimposed on original image (I4)')
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure
imshow(Lrgb)
title('Colored watershed label matrix (Lrgb)')