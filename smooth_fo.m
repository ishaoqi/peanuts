%%
% 
%  PREFORMATTED
%  �Է������ݽ������ƽ���˲��Ĺ���
% 
[data,info] = enviread2();
info.data_type = 4;
sdata = fivesmooth(data,info);
enviwrite2(sdata,info);