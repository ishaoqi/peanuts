function corr = calcorr(data,info)
%%
% 计算相邻波段间的相关系数
%  data：原始三维的图像数据
%  info：头文件信息
% 

    corr = zeros(info.bands);
    for i = 1:info.bands
        corr(i,i) = 1;
    end
    for i = 1:info.bands-1
        for j = i+1:info.bands
            [r,p] = corrcoef(data(:,:,i),data(:,:,j));
            corr(i,j) = r(1,2);
            corr(j,i) = r(1,2);
        end
    end        
end