function[data, cor]= readroi(file_name)

%%函数主要是读取envi输入的ROI的txt文档
% file_name：envi输出的txt文档的roi
% data:读取的样本数据和标签数据，标签数据由1往上增加
% cor：样本点的坐标 

   fid =  fopen(file_name, 'r');
   line_data = fgetl(fid);
   line_data = fgetl(fid);
   sline = sscanf(line_data,'%s');
   len = length(sline);
   sclass_num = sline(15:len);
   class_num = str2num(sclass_num);%获取类数
   aclass_num = zeros(1,class_num);%声明数组，用于存储每类包含的样本数
   line_data = fgetl(fid);
   for i = 1:class_num%读取每个类别包含的样本数并保存
     for j = 1:4
        line_data = fgetl(fid);
     end
     sline = sscanf(line_data,'%s');
     len = length(sline);
     ssample_num = sline(10:len);
     sample_num = str2num(ssample_num);
     aclass_num(i) = sample_num;
   end
   total_sample_num = sum(aclass_num);
   line_data = fgetl(fid);
   [sline, count] = sscanf(line_data, '%s');
   clear i
   clear j
   for i = 1:class_num       
       for j = 1:aclass_num(i)
           if i == 1 && j == 1
               line_data = fgetl(fid);
               total_data = sscanf(line_data, '%f',[1, count-1]);
               total_data = [total_data,i];
           else
               line_data = fgetl(fid);
               tdata = sscanf(line_data, '%f',[1, count-1]);
               tdata = [tdata,i];
               total_data = [total_data; tdata];
           end
       end
       if ~feof(fid)
           line_data = fgetl(fid);
       end
   end
   data = total_data(:,4:end);
   cor = total_data(:,2:3);
end

               
           
           
   

   
   
   