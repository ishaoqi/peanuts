%%
% 
%  ���getroi����ʹ�ã�������ȡroi��txt�ĵ���c_x�洢��Ϊ�������ݣ�c_y�洢��Ϊ������Ӧ�ı�ǩ����
%  ����c_x��c_y���ݽ����˴洢
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