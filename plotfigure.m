function plotfigure(x,y1,markSpacing)
%%
% ϡ�軭��  
% 

    %markSpacing=20; %ÿ20�������һ��Marker  
    %ȡ�����ݵ�ǰ��������������legend
    xlegend=x(1:2);
    y1legend=y1(1:2);
%     y2legend=y2(1:2);
%     y3legend=y3(1:2);
    y = [y1legend];
    plot(xlegend,y1legend,'-bo','MarkerSize',4,'LineWidth',1) %���legend 
    legend('data1') 
%     p1=plot(xlegend,y1legend,'-b*'); %���legend 
%     legend(p1,'data1') 
%     hold on
%     p2=plot(xlegend,y2legend,'-r*'); %���legend 
%     legend(p2,'data2')
%     p3=plot(xlegend,y3legend,'-k*'); %���legend 
%     legend(p3,'data3')     
    
    M = length(x);
    x_marker=x(1:markSpacing:M);% Markers �ĺ����� 
    y1_marker=y1(1:markSpacing:M); % Markers��������
%     y2_marker=y2(1:markSpacing:M); % Markers��������
%     y3_marker=y3(1:markSpacing:M); % Markers��������
    hold on
    plot(x_marker,y1_marker,'bo','MarkerSize',4) %����  
    plot(x,y1,'b-','LineWidth',1) 
%     plot(x_marker,y2_marker,'rs','MarkerSize',4) %����  
%     plot(x,y2,'r-','LineWidth',1) 
%     plot(x_marker,y3_marker,'kv','MarkerSize',4) %����  
%     plot(x,y3,'k-','LineWidth',1) 
end