%����
%or_MSB=ԭʼ��MSB��en_MSB=���ܺ��MSB,thumb_dimen����ͼ��ά��,dimen_x,dimen_y�������ά��,cap_matrix=����
function after_MSB=Adjust_MSB(or_MSB,en_MSB,dimen,dimen_x,dimen_y,cap_matrix)
after_MSB=en_MSB;
radio_x=dimen/dimen_x;%%���Կ��С�͵������С�ı�
radio_y=dimen/dimen_y;%%���Կ��С�͵������С�ı�
[b_x,b_y]=size(cap_matrix);%��������Ĵ�С
MSB_x=b_x/radio_x;%���Կ������
MSB_y=b_y/radio_y;

for i=1:1:MSB_x
    [or_begin_x,or_end_x]=begin_end(dimen,i);%ѹ�������λ������
    cap_begin_x=(i-1)*radio_x+1;
    cap_end_x=i*radio_x;
   for j=1:1:MSB_y
       [or_begin_y,or_end_y]=begin_end(dimen,j);%ѹ�������λ������
       cap_begin_y=(j-1)*radio_y+1;
       cap_end_y=j*radio_y;
       t_or_matrix=or_MSB(or_begin_x:or_end_x,or_begin_y:or_end_y);%����ȡ����
       t_en_matrix=en_MSB(or_begin_x:or_end_x,or_begin_y:or_end_y);%����ȡ����
       t_cap_matrix=cap_matrix(cap_begin_x:cap_end_x,cap_begin_y:cap_end_y);%����ȡ����
       after_block=Adjust_block(t_or_matrix,t_en_matrix,t_cap_matrix,dimen_x,dimen_y,dimen);%����
       after_MSB=block_to_matrix(after_MSB,after_block,i,j,dimen,dimen);%��������MSB
   end
end
