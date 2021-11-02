%计算相同位置
%0表示1列都不相等
function count=location_pre(block)
[x,y]=size(block);
count=0;
for i=1:1:y
   t=block(:,i);%从block中取一列
   t_length=length(unique(t));
   if t_length>1%遇见不一致的 
       return;%退出
   end
   count=count+1;
end
