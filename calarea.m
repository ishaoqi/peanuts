function area = calarea(data, band1, band2)
%%
% ������㺯��
%  ����ÿ��������band1 �� band2 ֮������  
% 

    [m,n] = size(data);
    area = zeros(m,1);    
    for j = 1:m
        sum = 0;
        data1 = data(j,:);
        for i = band1:band2-1
            x = abs(data1(i));
            y = abs(data1(i+1));
            temparea = (x+y)/2;
            sum = sum + temparea;
        end     
        area(j) = sum;
    end
end