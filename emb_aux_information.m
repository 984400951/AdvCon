%Ƕ�������Ϣ

function [emb_MSB,after_cap_matrix]=emb_aux_information(after_MSB,aux_information,cap_matrix,threshold_per)
emb_MSB=after_MSB;
after_cap_matrix=cap_matrix;
[block_x,block_y]=size(cap_matrix);
[x,y]=size(after_MSB);
dimen_x=x/block_x;
dimen_y=y/block_y;
len_block=(dimen_x-1)*dimen_y;
for i=1:1:block_x
   for j=1:1:block_y
       length_aux=length(aux_information);
       block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
       first_block=block(1,:);
       block=block(2:dimen_x,:);%��ĵ�һ�в�����
       t_arry=block(:)';
       cap=after_cap_matrix(i,j);
       t_cap=ceil(threshold_per*cap);%Ԥ����һ��Ƕ�����Ϣ������ȡ��
       
       if length_aux<=t_cap %�ж��Ƿ���һ����Ƕ��
           t_cap=length_aux;
           after_cap_matrix(i,j)=cap-t_cap;%ʣ�������
           t_zeros=zeros(1,cap-t_cap);%ʣ��λ����Ϊ0
           emb_arry=[aux_information,t_zeros];%Ƕ�����Ϣ�����еķ�ʽ����
           t_arry(1,len_block-cap+1:len_block)=emb_arry;
           blo_t=reshape(t_arry,dimen_x-1,dimen_y);%��һ��Ԫ�����±��һ�飬���е�˳�����
           after_block=[first_block;blo_t];%��װ��
           emb_MSB=block_to_matrix(emb_MSB,after_block,i,j,dimen_x,dimen_y);
           return;
       else
           after_cap_matrix(i,j)=cap-t_cap;%ʣ�������
           t_information=aux_information(1,1:t_cap);%ȡ����Ӧ����
           aux_information=aux_information(1,t_cap+1:length_aux);%����
           t_zeros=zeros(1,cap-t_cap);
           emb_arry=[t_information,t_zeros];%Ƕ�����Ϣ
           t_arry(1,len_block-cap+1:len_block)=emb_arry;
           blo_t=reshape(t_arry,dimen_x-1,dimen_y);%��һ��Ԫ�����±��һ�飬���е�˳�����
           after_block=[first_block;blo_t];%��װ��
           emb_MSB=block_to_matrix(emb_MSB,after_block,i,j,dimen_x,dimen_y);
       end
   end
end