%������ͬλ��
%0��ʾ1�ж������
function count=location_pre(block)
[x,y]=size(block);
count=0;
for i=1:1:y
   t=block(:,i);%��block��ȡһ��
   t_length=length(unique(t));
   if t_length>1%������һ�µ� 
       return;%�˳�
   end
   count=count+1;
end
