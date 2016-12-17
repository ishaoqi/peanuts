%%
% 
%  对佛像进行反射率校正的过程
%  使用时需要修改下enviread2函数，增加输出参数
% 
[data,info,filepath, filename] = enviread2();
info.data_type = 4;
sdata = fivesmooth(data,info);
[wdata,winfo] = enviread('G:\佛像\white_small.sli','G:\佛像\white_small.hdr');
% [wdata,winfo] = enviread('G:\佛像\white_big.sli','G:\佛像\white_big.hdr');
reflect_data = zeros(info.lines,info.samples,info.bands);
for i =1:info.bands
    reflect_data(:,:,i) = sdata(:,:,i)./wdata(i);
end
outputfilename = strcat(filepath,filename);
outputfilename_1 = strcat(outputfilename,'_smooth_ref');
outputfilename1_1 = strcat(outputfilename_1,'.img');
outputfilename2_1 = strcat(outputfilename_1,'.hdr');

outputfilename_2 = strcat(outputfilename,'_smooth');
outputfilename1_2 = strcat(outputfilename_2,'.img');
outputfilename2_2 = strcat(outputfilename_2,'.hdr');

enviwrite(reflect_data,info,outputfilename1_1,outputfilename2_1);
enviwrite(sdata,info,outputfilename1_2,outputfilename2_2);