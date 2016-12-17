%%
% 
%  配合getroi函数使用，用来读取roi的txt文档，c_x存储的为样本数据，c_y存储的为样本对应的标签数据
%  并将c_x，c_y数据进行了存储
% 

[filename, pathname] = uigetfile({'*.txt'; '*.*'},'Read txt file');
fullname = strcat(pathname,filename);
dotpath = strfind(fullname,'.');
name = fullname(1:dotpath-1);
sample = readroi(fullname);
y = sample(:,end);
xname = strcat(name,'_x.mat');
yname = strcat(name,'_y.mat');
c_x = sample(:,1:end-1);
c_y = sample(:,end);
save(xname,'c_x');
save(yname,'c_y');