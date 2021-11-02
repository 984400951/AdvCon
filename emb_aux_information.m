%嵌入额外信息

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
       block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%取出相应块
       first_block=block(1,:);
       block=block(2:dimen_x,:);%块的第一行不参与
       t_arry=block(:)';
       cap=after_cap_matrix(i,j);
       t_cap=ceil(threshold_per*cap);%预计这一块嵌入的信息，向上取整
       
       if length_aux<=t_cap %判断是否能一次性嵌入
           t_cap=length_aux;
           after_cap_matrix(i,j)=cap-t_cap;%剩余的容量
           t_zeros=zeros(1,cap-t_cap);%剩余位补充为0
           emb_arry=[aux_information,t_zeros];%嵌入的信息，以行的方式进行
           t_arry(1,len_block-cap+1:len_block)=emb_arry;
           blo_t=reshape(t_arry,dimen_x-1,dimen_y);%将一列元素重新变成一块，以列的顺序进行
           after_block=[first_block;blo_t];%组装块
           emb_MSB=block_to_matrix(emb_MSB,after_block,i,j,dimen_x,dimen_y);
           return;
       else
           after_cap_matrix(i,j)=cap-t_cap;%剩余的容量
           t_information=aux_information(1,1:t_cap);%取出相应数组
           aux_information=aux_information(1,t_cap+1:length_aux);%更新
           t_zeros=zeros(1,cap-t_cap);
           emb_arry=[t_information,t_zeros];%嵌入的信息
           t_arry(1,len_block-cap+1:len_block)=emb_arry;
           blo_t=reshape(t_arry,dimen_x-1,dimen_y);%将一列元素重新变成一块，以列的顺序进行
           after_block=[first_block;blo_t];%组装块
           emb_MSB=block_to_matrix(emb_MSB,after_block,i,j,dimen_x,dimen_y);
       end
   end
end