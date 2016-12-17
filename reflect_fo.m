%%
% 
%  �Է�����з�����У���Ĺ���
%  ʹ��ʱ��Ҫ�޸���enviread2�����������������
% 
[data,info,filepath, filename] = enviread2();
info.data_type = 4;
sdata = fivesmooth(data,info);
[wdata,winfo] = enviread('G:\����\white_small.sli','G:\����\white_small.hdr');
% [wdata,winfo] = enviread('G:\����\white_big.sli','G:\����\white_big.hdr');
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