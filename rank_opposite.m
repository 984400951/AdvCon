%��lo��������

function group=rank_opposite(r,s)
if s<=127
   beg=0;
else
   zone=254-s+1;
   beg=127-zone+1;%��ʼ��λ��
end
a=r+beg;
b=s-a;
group=[a,b];