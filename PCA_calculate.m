function [img_PCA coeff latent_fraction latent_sum]= PCA_calculate(data,info)
%%
%  PCA主成分分析
%  input：
%    data：enviread读取的影像数据，原始三维的，经过背景掩膜处理的
%    info：enviread读取的头文件信息
%  output：
%    img_PCA：PCA变换结果
%    coeff：特征向量集合，coeff的列是特征向量
%    latent_fraction：各主成分所占的比例
%    latent_sum：各主成分所占的比例和

%PCA算法
    index = find(data(:,:,1)>0 | data(:,:,1)<0 );%使背景值不参与PCA计算
    s = [info.lines,info.samples];
    [rows,cols] = ind2sub(s,index);
    index_length = length(index);
    PCA_data = zeros(index_length,info.bands);
    for i = 1:index_length
        PCA_data(i,:) = data(rows(i),cols(i),:);
    end
    [coeff,score,latent] = princomp(zscore(PCA_data));%coeff 的列是特征向量
    latent_fraction = latent./sum(latent);
    latent_sum = cumsum(latent)./sum(latent);
    img_PCA = zeros(info.lines,info.samples,info.bands);
    for i = 1:index_length
        img_PCA(rows(i),cols(i),:) = score(i,:);
    end
end

    
