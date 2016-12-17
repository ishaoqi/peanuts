%df1_calculate
function df1 =  df1_calculate(data, info)
%%
% 
%  一阶差分计算函数
%  data：原始三维遥感数据
%  info：头文件信息

    str_wavelength = info.wavelength;
    index = strfind(str_wavelength,',');
    wavelength = zeros(info.bands,1);
    wavelength(1) = str2num(str_wavelength(2:index(1)-1));
    for i = 2 : length(index)
        wavelength(i) = str2num(str_wavelength(index(i-1)+1:index(i)-1));
    end
    wavelength(end) =  str2num(str_wavelength(index(end)+1:length(str_wavelength)-1));
    dfr1 = zeros(info.lines, info.samples, info.bands-1);
    dfl1 = zeros(info.lines, info.samples, info.bands-1);
    df1 = zeros(info.lines, info.samples, info.bands);
    for i = 1:info.bands-1
        dfr1(:,:,i) = (data(:,:,i+1) - data(:,:,i))/(wavelength(i+1)-wavelength(i));
    end
    for i = 2:info.bands
        dfl1(:,:,i) = (data(:,:,i) - data(:,:,i-1))/(wavelength(i)-wavelength(i-1));
    end
    df1(:,:,1) = dfr1(:,:,1);
    df1(:,:,info.bands) = dfl1(:,:,info.bands);
    for i = 2:info.bands-1
        df1(:,:,i) = (dfr1(:,:,i-1)+dfl1(:,:,i+1))./2;
    end
end
    
