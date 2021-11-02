%加密MSB，其中腾出的空间不加密
function en_MSB=Encrypt_MSB(emb_MSB,cap_matrix,key)
[block_x,block_y]=size(cap_matrix);
[x,y]=size(emb_MSB);
dimen_x=x/block_x;
dimen_y=y/block_y;

rng(key);
key_matrix=uint8(randi([0,1],x,y));


init_en_MSB=bitxor(key_matrix,emb_MSB);
ideal_room=(dimen_x-1)*dimen_y;
en_MSB=init_en_MSB;
%把腾出的空间清零
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(en_MSB,i,j,dimen_x,dimen_y);%取出相应块
       t_cap=cap_matrix(i,j);
       if t_cap>0
           first_block=block(1,:);
           second_block=block(2:dimen_x,:);
           t_arry=second_block(:)';
           
           t_zeros=zeros(1,t_cap);
           t_arry(1,ideal_room-t_cap+1:ideal_room)=t_zeros;
           after_matrix=reshape(t_arry,dimen_x-1,dimen_y);
           block=[first_block;after_matrix];
           en_MSB=block_to_matrix(en_MSB,block,i,j,dimen_x,dimen_y);%被处理后的MSB
       end
   end
end