%%
% 
%  PREFORMATTED
%  ��ǿ��Ƶķ�ˮ���㷨
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
% %��ͼ��ת����0-255
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

%�����ݶȷ�ֵͼ��
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(img1),hy,'replicate');
Ix = imfilter(double(img1),hx,'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
% figure
% imshow(gradmag,[]),title('radient magnitude (gradmag)');

%���ǰ������
se = strel('disk',3);%Բ��ģ���
Io = imopen(img1,se);%���������Ǹ�ʴ������
% figure
% imshow(Io),title('Opening(Io)')
%ͨ����ʴ���ؽ��������ڿ����ؽ�����
Ie = imerode(img1, se);%ͼ��ʴ
Iobr = imreconstruct(Ie, img1);%ͼ���ؽ�
% figure
% imshow(Iobr),title('Opening-by-reconstruction (Iobr)')

Ioc = imclose(Io, se);%�ղ����������Ƴ��ϰ��İߵ��֦�ɱ��
% figure
% imshow(Ioc),title('Opening-closing(Ioc)')
%ͼ������
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
% figure
% imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')
%����Iobrcbr�ľֲ��������õ����õ�ǰ�����
fgm = imregionalmax(Iobrcbr);
% figure
% imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')
I2 = img1;
I2(fgm) = 255;
% figure
% imshow(I2), title('Regional maxima superimposed on original image (I2)')

%ע�⵽������������Ӱ����û�б���ǣ������ζ����Щ�����ڽ���н�����õ�����ķָ
%���ң�һЩ�����ǰ����ǻ�һֱ������ı�Ե�������ζ��Ӧ�������ǰߵ�ı�Ե��Ȼ���������ǡ�
%����ͨ���ղ����͸�ʴ��������ɡ�
se2 = strel(ones(3,3));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 3);%BW2 = bwareaopen(BW,P)�Ӷ�ֵͼ�����Ƴ���������P����ֵ����ͨ�飬
                           %�õ�����Ķ�ֵͼ��BW2
I3 = img1;
I3(fgm4) = 255;
% figure
% imshow(I3)
% title('Modified regional maxima superimposed on original image (fgm4)')
%���㱳�����
%���ڣ���Ҫ��Ǳ�������������ͼ��Iobrcbr�У����������ڱ��������Կ��Դ���ֵ������ʼ��
thresh = graythresh(Iobrcbr);
bw = im2bw(Iobrcbr,thresh);
% figure
% imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

%���������ں�ɫ���򣬵������������£�����Ҫ�󱳾����̫�ӽ���Ҫ�ָ�Ķ����Ե��
%ͨ�����㡰�Ǽ�Ӱ�췶Χ������ϸ��������������SKIZ��bw��ǰ����
%�������ͨ������bw�ľ���任�ķ�ˮ��任��ʵ�֣�Ȼ��Ѱ�ҽ���ķ�ˮ�뼹�ߣ�DL==0����
%D = bwdist(BW)�����ֵͼ��BW��ŷ����þ���
%��BW��ÿһ�����أ�����任ָ�����غ������BW�������صľ��롣
%bwdistĬ��ʹ��ŷ����þ��빫ʽ��BW����������ά����D��BW��ͬ���Ĵ�С��
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
% figure
% imshow(bgm), title('Watershed ridge lines (bgm)')

%����ָ���ķ�ˮ��任
%����imimposemin���������޸�ͼ��ʹ��ֻ�����ض���Ҫ��λ���оֲ���С��
%�������ʹ��imimposemin���޸��ݶȷ�ֵͼ��ʹ��ֻ��ǰ���ͺ󾰱�������оֲ���С��
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