function resultimg = dispeanut(img,thr)
%由分类结果判断花生是否霉变
%本函数需确定每个花生是完整的
%img----分类结果图，霉变花生像素用1表示，健康花生用2表示
%thr----阈值，当花生中霉变像素比例大于该阈值时，认为i花生是霉变的
    [nrow,ncol] = size(img);
    mask = img;
    mask(find(mask ~= 0)) = 1;
    [labeled, numobjects] = bwlabel(mask, 4);
    sta = regionprops(labeled, 'basic');
    resultimg = zeros(size(mask));
    for i = 1:numobjects           %判断每个花生是健康的还是霉变的
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