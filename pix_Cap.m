%��������
%zone ����������
function cap=pix_Cap(zone)
[x,y]=size(zone);
cap=zeros(x,y);

for i=1:1:x
   for j=1:1:y
      num=zone(i,j);
      t=floor(log2(num));%���Ӧ�Ķ���
      cap(i,j)=t;
   end
end
