function result=imgentropy(img)
%计算图像的信息熵
%written by hangbing6174,CUMT
%
[M,N]=size(img);
imax=ceil(max(max(img)));
temp=zeros(1,imax);
%????????[0,imax]???? 
for m=1:M; 
    for n=1:N; 
        if img(m,n)==imax;
            i=ceil(imax); 
            else 
            i=fix(img(m,n))+1; 
        end 
        temp(i)=temp(i)+1; 
    end 
end

temp=temp./(M*N); 
%???????? 
resul=0; 
for i=1:length(temp) 
    if temp(i)==0; 
        resul=resul; 
    else 
        resul=resul-temp(i)*log2(temp(i)); 
    end 
end
result=resul;