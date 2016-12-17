function JM = calJM(X1,X2)
%%
% 计算JM距离
%  X1，X2：特征空间内两个类别的值
%  JM：JM距离
% 
    error(nargchk(2,2,nargin));   
    error(nargoutchk(0,1,nargout));   
    [n,m]=size(X1);   
    % check dimension    
    % assert(isequal(size(X2),[n m]),'Dimension of X1 and X2 mismatch.');   
    assert(size(X2,2)==m,'Dimension of X1 and X2 mismatch.');   

    mu1=mean(X1);   
    C1=cov(X1);   
    mu2=mean(X2);   
    C2=cov(X2);   
    C=(C1+C2)/2;   
    dmu=(mu1-mu2)/chol(C);   
    try   
        d=0.125*dmu*dmu'+0.5*log(det(C/chol(C1*C2))); 
    catch   
%         d=0.125*dmu*dmu'+0.5*log(abs(det(C/sqrtm(C1*C2))));   
        d=0.125*dmu*dmu'+0.5*log(abs(det(C))/sqrtm(det(C1)*det(C2)));    
        %warning('MATLAB:divideByZero','Data are almost linear dependent. The results may not be accurate.');   
    end   
    JM = 2*(1-exp(-d));
end