%%
% 
%  PREFORMATTED
%  对佛像数据进行五点平滑滤波的过程
% 
[data,info] = enviread2();
info.data_type = 4;
sdata = fivesmooth(data,info);
enviwrite2(sdata,info);