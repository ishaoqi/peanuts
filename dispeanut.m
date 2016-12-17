function resultimg = dispeanut(img,thr)
%�ɷ������жϻ����Ƿ�ù��
%��������ȷ��ÿ��������������
%img----������ͼ��ù�仨��������1��ʾ������������2��ʾ
%thr----��ֵ����������ù�����ر������ڸ���ֵʱ����Ϊi������ù���
    [nrow,ncol] = size(img);
    mask = img;
    mask(find(mask ~= 0)) = 1;
    [labeled, numobjects] = bwlabel(mask, 4);
    sta = regionprops(labeled, 'basic');
    resultimg = zeros(size(mask));
    for i = 1:numobjects           %�ж�ÿ�������ǽ����Ļ���ù���
        index = find(labeled == i);
        bound = sta(i).BoundingBox;
        subimg = img(bound(2)-0.5:bound(2)+0.5+bound(4),bound(1)-0.5:bound(1)+0.5+bound(3));
        index1 = find(subimg == 1);
        index2 = find(subimg == 2);
        alpha = length(index1)/(length(index1)+length(index2));
        if alpha > thr
           resultimg(index) = 1;
        else
           resultimg(index) = 2;
        end
    end
end