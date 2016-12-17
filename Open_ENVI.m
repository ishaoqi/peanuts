function imagedata = Open_ENVI()
%%
% 利用multibandread读取envi文件
% 

    [filename, pathname] = uigetfile({'*.bsq'; '*.tif'; '*.*'},'Read image file');
    dotpath = strfind(filename, '.');
    hdrname = filename(1:dotpath-1);
    hdrname = strcat(hdrname, '.hdr');
    hdrfullname = strcat(pathname, hdrname);
    sgc_exist = exist(hdrfullname, 'file');
    if sgc_exist == 0
        imagedata = 0;
        disp('The header file is not exist');
        return;
    else
        fid = fopen(hdrfullname, 'r');
        info = fread(fid, 'char=>char');
        info = info';
        fclose(fid);
        %查找列数
        a=strfind(info,'samples = ') ; %注意空格
        b=length('samples = ');
        c=strfind(info,'lines');
        samples=[];
        for i=a+b:c-1
            samples=[samples,info(i)];
        end
        samples=str2num(samples);

        %查找行数
        a=strfind(info,'lines   = ');%注意有3个空格
        b=length('lines   = ');
        c=strfind(info,'bands');
        lines=[];
        for i=a+b:c-1
            lines=[lines,info(i)];
        end
        lines=str2num(lines);

        %查找波段数
        a=strfind(info,'bands   = ');
        b=length('bands   = ');
        c=strfind(info,'header offset');
        bands=[];
        for i=a+b:c-1
        bands=[bands,info(i)];
        end
        bands=str2num(bands);

        %查找数据类型
        a=strfind(info,'data type = ');
        b=length('data type = ');
        c=strfind(info,'interleave');
        datatype=[];
        for i=a+b:c-1
            datatype=[datatype,info(i)];
        end
        datatype=str2num(datatype);
        precision=[];
        switch datatype
            case 1
                 precision='uint8=>uint8';%头文件中datatype=1对应ENVI中数据类型为Byte，对应MATLAB中数据类型为uint8
            case 2
                 precision='int16=>int16';%头文件中datatype=2对应ENVI中数据类型为Integer，对应MATLAB中数据类型为int16
            case 12
                 precision='uint16=>uint16';%头文件中datatype=12对应ENVI中数据类型为Unsighed Int，对应MATLAB中数据类型为uint16
            case 3
                 precision='int32=>int32';%头文件中datatype=3对应ENVI中数据类型为Long Integer，对应MATLAB中数据类型为int32
            case 13
                 precision='uint32=>uint32';%头文件中datatype=13对应ENVI中数据类型为Unsighed Long，对应MATLAB中数据类型为uint32
            case 4
                 precision='float32=>float32';%头文件中datatype=4对应ENVI中数据类型为Floating Point，对应MATLAB中数据类型为float32
            case 5
                 precision='double=>double';%头文件中datatype=5对应ENVI中数据类型为Double Precision，对应MATLAB中数据类型为double
            otherwise
                error('invalid datatype');%除以上几种常见数据类型之外的数据类型视为无效的数据类型
        end

        %查找数据格式
        a=strfind(info,'interleave = ');
        b=length('interleave = ');
        c=strfind(info,'sensor type');
        interleave=[];
        for i=a+b:c-1
             interleave=[interleave,info(i)];
        end
        interleave=strtrim(interleave);%删除字符串中的空格
        imagefullname = strcat(pathname, filename);
        imagedata = multibandread(imagefullname,[lines, samples, bands],precision,0,interleave,'ieee-le');
    end  
end
    
    