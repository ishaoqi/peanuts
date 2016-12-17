function [img_PCA coeff latent_fraction latent_sum]= PCA_calculate(data,info)
%%
%  PCA���ɷַ���
%  input��
%    data��enviread��ȡ��Ӱ�����ݣ�ԭʼ��ά�ģ�����������Ĥ�����
%    info��enviread��ȡ��ͷ�ļ���Ϣ
%  output��
%    img_PCA��PCA�任���
%    coeff�������������ϣ�coeff��������������
%    latent_fraction�������ɷ���ռ�ı���
%    latent_sum�������ɷ���ռ�ı�����

%PCA�㷨
    index = find(data(:,:,1)>0 | data(:,:,1)<0 );%ʹ����ֵ������PCA����
    s = [info.lines,info.samples];
    [rows,cols] = ind2sub(s,index);
    index_length = length(index);
    PCA_data = zeros(index_length,info.bands);
    for i = 1:index_length
        PCA_data(i,:) = data(rows(i),cols(i),:);
    end
    [coeff,score,latent] = princomp(zscore(PCA_data));%coeff ��������������
    latent_fraction = latent./sum(latent);
    latent_sum = cumsum(latent)./sum(latent);
    img_PCA = zeros(info.lines,info.samples,info.bands);
    for i = 1:index_length
        img_PCA(rows(i),cols(i),:) = score(i,:);
    end
end

    
