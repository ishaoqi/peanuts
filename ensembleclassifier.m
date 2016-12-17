
%%
% 
%  the process of several ensemble classifier
%  TEXT
% 
samples = read_ROI('C:\Users\qixia\Desktop\samples.txt');
c_x_meibian = samples(1:150,1:91);
c_y_zhengchang = samples(151:300,1:91);
[v_data,info_v] = enviread('C:\Users\qixia\Desktop\yjcf\reflect_cor_down_smooth.bsq','C:\Users\qixia\Desktop\yjcf\reflect_cor_down_smooth.hdr');
index = find(v_data(:,:,61)>0.25);
s = [info_v.lines, info_v.samples];
[rows, cols] = ind2sub(s, index);
index_length = length(index);
v_x = zeros(index_length,info_v.bands);
for i = 1:index_length
    v_x(i,:) = v_data(rows(i),cols(i),:);
end
yfit_Boosted = Boosted.predictFcn(v_x);
yfit_bagged = Bagged.predictFcn(v_x);
yfit_subspaceD = SubspaceD.predictFcn(v_x);
yfit_subspaceK = SubspaceK.predictFcn(v_x);
yfit_Rusboosted = Rusboosted.predictFcn(v_x);
v_boosted = zeros(info_v.lines, info_v.samples);
v_bagged = zeros(info_v.lines, info_v.samples);
v_subD = zeros(info_v.lines, info_v.samples);
v_subK = zeros(info_v.lines, info_v.samples);
v_Rusboosted = zeros(info_v.lines, info_v.samples);
for i = 1:index_length
v_boosted(rows(i),cols(i)) = yfit_Boosted(i);
v_bagged(rows(i),cols(i))  = yfit_bagged(i);
v_subD(rows(i),cols(i))  = yfit_subspaceD(i);
v_subK(rows(i),cols(i))  = yfit_subspaceK(i);
v_Rusboosted(rows(i),cols(i))  = yfit_Rusboosted(i);
end
info = info_v;
info.bands = 1;
info.data_type = 1;
enviwrite(v_boosted,info,'C:\Users\qixia\Desktop\boosted.bsq','C:\Users\qixia\Desktop\boosted.hdr');
enviwrite(v_bagged,info,'C:\Users\qixia\Desktop\bagged.bsq','C:\Users\qixia\Desktop\bagged.hdr');
enviwrite(v_subD,info,'C:\Users\qixia\Desktop\subD.bsq','C:\Users\qixia\Desktop\subD.hdr');
enviwrite(v_subK,info,'C:\Users\qixia\Desktop\subK.bsq','C:\Users\qixia\Desktop\subK.hdr');
enviwrite(v_Rusboosted,info,'C:\Users\qixia\Desktop\Rusboosted.bsq','C:\Users\qixia\Desktop\Rusboosted.hdr');