%调整
%or_MSB=原始的MSB，en_MSB=加密后的MSB,thumb_dimen缩略图的维度,dimen_x,dimen_y调整块的维度,cap_matrix=容量
function after_MSB=Adjust_MSB(or_MSB,en_MSB,dimen,dimen_x,dimen_y,cap_matrix)
after_MSB=en_MSB;
radio_x=dimen/dimen_x;%%缩略块大小和调整块的小的比
radio_y=dimen/dimen_y;%%缩略块大小和调整块的小的比
[b_x,b_y]=size(cap_matrix);%容量矩阵的大小
MSB_x=b_x/radio_x;%缩略块的数量
MSB_y=b_y/radio_y;

for i=1:1:MSB_x
    [or_begin_x,or_end_x]=begin_end(dimen,i);%压缩块调整位的区域
    cap_begin_x=(i-1)*radio_x+1;
    cap_end_x=i*radio_x;
   for j=1:1:MSB_y
       [or_begin_y,or_end_y]=begin_end(dimen,j);%压缩块调整位的区域
       cap_begin_y=(j-1)*radio_y+1;
       cap_end_y=j*radio_y;
       t_or_matrix=or_MSB(or_begin_x:or_end_x,or_begin_y:or_end_y);%从中取出来
       t_en_matrix=en_MSB(or_begin_x:or_end_x,or_begin_y:or_end_y);%从中取出来
       t_cap_matrix=cap_matrix(cap_begin_x:cap_end_x,cap_begin_y:cap_end_y);%从中取出来
       after_block=Adjust_block(t_or_matrix,t_en_matrix,t_cap_matrix,dimen_x,dimen_y,dimen);%调整
       after_MSB=block_to_matrix(after_MSB,after_block,i,j,dimen,dimen);%被处理后的MSB
   end
end
