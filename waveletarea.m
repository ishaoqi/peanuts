%%
% 本流程主要用来计算比值指数文章中基于小波系数的面积比指数
%  c_x：样本，每一行为一个样本
%  计算出的为每个样本的面积比指数
% 

[m,n] = size(c_x);
area = zeros(m,1);
% area1 = 0;
% area2 = 0;
for i = 1:m
    coefs = cwt(c_x(i,:),[2^1,2^2,2^3,2^4,2^5,2^6],'haar');
    
    area1 = calarea(coefs(4,:),25,50);
    area2 = calarea(coefs(5,:),25,50);
    area3 = calarea(coefs(6,:),25,50);
    
    area4 = calarea(coefs(4,:),1,15);
    area5 = calarea(coefs(5,:),1,15);
    area6 = calarea(coefs(6,:),1,15);
    area(i) = (area1+area2+area3)/(area4+area5+area6);
%     for j = 1:6
%         area1 = area1 + calarea(coefs(j,:),25,50);
%         area2 = area2 + calarea(coefs(j,:),1,15);
%     end
%     area(i) = (area1)/(area2);

end
    