function JMdist=JMdistance(scatter1,scatter2,varargin)

%%
%Input arguments:
%  scatter1: the first sctter point with m*n(m for one point,n for features)
%            in other word,each row of scatter1 is an observation, and each
%            element in the row is a variable.
%  scatter2: the second sctter point with m*n.
%  varargin: option arguments for more classes with same size with 'scatter1'
%Output arguments:
%  JMdist: final J-M distance with a metrix of classno*classno 
%输入数据为高光谱的单层数据。即为进行一系列处理后的有效特征波段。
%%
[x y]=size(scatter1);
optargin = size(varargin,2);% number of inputs 输入变量排成行向量，所以列数即为输入变量个数。
classno=optargin+2;% 总共的输入变量数。
JMdist=zeros(classno,classno);% 定义输出结果为一个空矩阵。

m=zeros(classno,y);
v=zeros(y,y,classno);%covariance have no relation with the NO. of points
m(1,:)=mean(scatter1,1);
v(:,:,1)=cov(scatter1);
m(2,:)=mean(scatter2,1);
v(:,:,2)=cov(scatter2);
for i=1:optargin
    m(i+2,:)=mean(varargin{1,i},1);% 【1，i】不应该是{i}么？
    v(:,:,i+2)=cov(varargin{1,i},1);
end
% Compute the J-M distance for each classpair
for i=1:classno
    for j=i:classno
        a=0.125*(m(i,:)-m(j,:))/(0.5*(v(:,:,i)+v(:,:,j)))*(m(i,:)-m(j,:))'...
            +0.5*log(det(0.5*v(:,:,i)+0.5*v(:,:,j))/sqrt(det(v(:,:,i))*det(v(:,:,j))));
        JMdist(i,j)=2*(1-exp(-a));
    end
end
return