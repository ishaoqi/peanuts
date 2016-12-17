function wavelength = getwavelength(info)
%%
% 
%  根据info头文件信息获取波长
%  info：enviread 读取出的info头文件信息
% 

    str_wavelength = info.wavelength;
    index = strfind(str_wavelength,',');
    wavelength = zeros(info.bands,1);
    wavelength(1) = str2num(str_wavelength(2:index(1)-1));
    for i = 2 : length(index)
        wavelength(i) = str2num(str_wavelength(index(i-1)+1:index(i)-1));
    end
    wavelength(end) =  str2num(str_wavelength(index(end)+1:length(str_wavelength)-1));
end