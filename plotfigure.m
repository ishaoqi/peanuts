function plotfigure(x,y1,markSpacing)
%%
% 稀疏画点  
% 

    %markSpacing=20; %每20个点添加一个Marker  
    %取出数据的前两个点用于生成legend
    xlegend=x(1:2);
    y1legend=y1(1:2);
%     y2legend=y2(1:2);
%     y3legend=y3(1:2);
    y = [y1legend];
    plot(xlegend,y1legend,'-bo','MarkerSize',4,'LineWidth',1) %添加legend 
    legend('data1') 
%     p1=plot(xlegend,y1legend,'-b*'); %添加legend 
%     legend(p1,'data1') 
%     hold on
%     p2=plot(xlegend,y2legend,'-r*'); %添加legend 
%     legend(p2,'data2')
%     p3=plot(xlegend,y3legend,'-k*'); %添加legend 
%     legend(p3,'data3')     
    
    M = length(x);
    x_marker=x(1:markSpacing:M);% Markers 的横坐标 
    y1_marker=y1(1:markSpacing:M); % Markers的纵坐标
%     y2_marker=y2(1:markSpacing:M); % Markers的纵坐标
%     y3_marker=y3(1:markSpacing:M); % Markers的纵坐标
    hold on
    plot(x_marker,y1_marker,'bo','MarkerSize',4) %画出  
    plot(x,y1,'b-','LineWidth',1) 
%     plot(x_marker,y2_marker,'rs','MarkerSize',4) %画出  
%     plot(x,y2,'r-','LineWidth',1) 
%     plot(x_marker,y3_marker,'kv','MarkerSize',4) %画出  
%     plot(x,y3,'k-','LineWidth',1) 
end