%��Ҫ����λ����Ƕ��
function count=need_to_locate(dimen_x,dimen_y)
md=ceil(log2(dimen_y));%��Ҫ����λ��ʾλ�õ�
all=md+1;%1����location map����Ŀռ�
vocate=dimen_x-1;%ÿ��һ��λ�����ڳ����ٿռ�
count=ceil(all/vocate);

