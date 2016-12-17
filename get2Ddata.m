function [data, info,nrow, ncol]= get2Ddata()
%%
% 
%  get 2d imagedata
%  data:2d imagedata,m*n,n:the number of features,m:the number of samples
%  info: the header file of image
%  nrow:the row number of samples
%  ncol: the col number of samples

    [filename, pathname] = uigetfile({'*.*'},'open file');
    dotpath = strfind(filename, '.');
    dot2 = dotpath(end);
    hdrname = filename(1:dot2-1);
    hdrname = strcat(hdrname, '.hdr');
    hdrfullname = strcat(pathname, hdrname);
    sgc_exist = exist(hdrfullname, 'file');
    if sgc_exist == 0
        disp('The header file is not exist');
        return;
    else
        imgname = strcat(pathname, filename);
        hdrname = hdrfullname;
    end
    [data1,info] = enviread(imgname,hdrname);
    index = find(data1(:,:,1)>0);
    s = [info.lines, info.samples];
    [nrow, ncol] = ind2sub(s,index);
    n = length(index);
    data = zeros(n, info.bands);
    for i = 1:n
        data(i,:) = data1(nrow(i),ncol(i),:);
    end
end