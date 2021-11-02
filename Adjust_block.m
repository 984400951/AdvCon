%调整块

function after_block=Adjust_block(t_or_matrix,t_en_matrix,t_cap_matrix,dimen_x,dimen_y,dimen)
after_block=t_en_matrix;
or_sum=sum(sum(t_or_matrix(:)));%原始MSB之和
en_sum=sum(sum(t_en_matrix(:)));%密文MSB之和
cap_sum=sum(sum(t_cap_matrix(:)));%空间之和

radio_x=dimen/dimen_x;%%缩略块大小和调整块的小的比
radio_y=dimen/dimen_y;%%缩略块大小和调整块的小的比

cha=or_sum-en_sum;
if cha<=0
   return; 
end

if cha>cap_sum%调整不完
   adjust=cap_sum;
else%调整的完
    adjust=cha;
end

n=(dimen_x-1)*dimen_y;%总共空间，减去第一行

for i=1:1:radio_x
    [begin_x,end_x]=begin_end(dimen_x,i);%压缩块位置
   for j=1:1:radio_y
       [begin_y,end_y]=begin_end(dimen_y,j);%压缩块位置
       t_matrix=t_en_matrix(begin_x:end_x,begin_y:end_y);%从中取出来
       first_matrix=t_matrix(1,:);%第一行
       t_matrix=t_matrix(2:dimen_x,:);%去除第一行
      
       t_cap=t_cap_matrix(i,j);%该压缩块有多少空间
       if t_cap<adjust%如果这个块的空间不能够承受这么多调整
           t_adjust=t_cap;%这个块调整的位数
           adjust=adjust-t_adjust;%还剩多少位需要调整
       else
           t_adjust=adjust;
           adjust=adjust-t_adjust;%还剩多少位需要调整
           
       end
       adjust_arry=ones(1,t_adjust);%需要多少个1
       if t_adjust>0%判断能够嵌入
            t_arry=t_matrix(:)';%将矩阵按照列方向的顺序化为数组
            t_arry(n-t_adjust+1:n)=adjust_arry;
            after_matrix=reshape(t_arry,dimen_x-1,dimen_y);
            after_matrix=[first_matrix;after_matrix];
            after_block(begin_x:end_x,begin_y:end_y)=after_matrix;
       
       end
       if adjust<=0
          return;
       end
   end
end