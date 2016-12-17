function [P,F_valueAB] = calFvalue(sample,n1)
%%
% 计算两个类别的F值
%  sample：样本数据，二维的，每行是一个样本
%  n1：第一个样本的数量

   [nrow,ncol] = size(sample);
   sampleA = sample(1:n1,1:ncol);
   sampleB = sample(n1+1:nrow,1:ncol);
    for i = 1:ncol
        y1 = sampleA(:,i);
        y2 = sampleB(:,i);
        y = [y1,y2];
        [p,tb1] = anova1(y,[], 'off');
        if i == 1
            F_valueAB = tb1{2,5};
            P = p;
        else
            t_value = tb1{2,5};
            F_valueAB = [F_valueAB;t_value];
            P = [P;p];
        end
    end
end