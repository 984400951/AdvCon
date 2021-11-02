%恢复MSB同时提取信息

function [another_information,re_MSB]=reprocessing_MSB_API(after_MSB,dimen_x,dimen_y,key)

emb_MSB=Decrypt_MSB(after_MSB,key);%解密MSB

threshold=need_to_locate(dimen_x,dimen_y);%位置阈值,具体来说就是截断的下限。例如，如果为1，则说明至少需要一列相等才能够进行嵌入过程
md_num=ceil(log2(dimen_y));%md所占的位数
[x,y]=size(emb_MSB);
block_x=x/dimen_x;%行上有多少块
block_y=y/dimen_y;%列上有多少块
md_matrix=[];
ideal_room=(dimen_x-1)*dimen_y;%除了第一行之外的容量
location_map=zeros(block_x,block_y);


%%提取md和location
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%取出相应块
       [location,md]=extract_to_cap_md(block,md_num);
       location_map(i,j)=location;
       if location==1
           md_matrix=[md_matrix;md];
       end
   end
end
after_cap_matrix=zeros(block_x,block_y);

md_count=1;
e=[];%补充信息
length_e_matrix=zeros(block_x,block_y);%补充信息的长度信息
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%取出相应块
       second_block=block(2:dimen_x,:);
       t_second_arry=second_block(:)';
       t=location_map(i,j);
       if t~=0%则说明嵌入容量不为零

           md=bin2dec(num2str(md_matrix(md_count,:)))+1;
           if md~=dimen_y %说明有补充信息
               begin_E=md_num+1;%剔除location+md
               one_e_num=dimen_y-md;%一个补充信息的长度
               lengh_e=one_e_num*(dimen_x-1);%块中补充信息的总长度
               t_e=t_second_arry(begin_E+1:begin_E+lengh_e);%取出补充信息
               length_e_matrix(i,j)=length(t_e);
               e=[e,t_e];
           end
           after_cap_matrix(i,j)=md*(dimen_x-1)-md_num-1;%md*(dimen_x-1)表明腾出的空间总位数，减去md占的位数，减去location占的位数
           md_count=md_count+1;
       end
   end
end


%提取额外信息
init_threshold_per=0.5;%初始计划每个块中嵌入的百分比

%fisrst_bit=[0,0,0];%测试所用，会删掉！
fisrst_bit=emb_MSB(1,1:3);%提取前三位
threshold_per=init_threshold_per+bin2dec(num2str(fisrst_bit))/10;%所用到的百分比阈值
all_bit=[];%提取嵌入的信息
for i=1:1:block_x
   for j=1:1:block_y
       if location_map(i,j)==1
           block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%取出相应块
           t_cap=after_cap_matrix(i,j);
           cap=ceil(t_cap*threshold_per);%该块中嵌入额外信息的数量
           second_block=block(2:dimen_x,:);
           t_arry=second_block(:)';%转化成数组
           t_bit=t_arry(1,ideal_room-t_cap+1:ideal_room-t_cap+cap);
           all_bit=[all_bit,t_bit];
       end
   end
end



re_first_bit=all_bit(1,1:3);%矩阵前三位的信息
emb_MSB(1,1:3)=re_first_bit;%改变前三位
all_bit=all_bit(1,4:length(all_bit));%删除第一到第三行



%恢复矩阵
re_MSB=emb_MSB;
md_count=1;
for i=1:1:block_x
    if i==97
     
    end
   for j=1:1:block_y 
       block=index_to_block(re_MSB,i,j,dimen_x,dimen_y);%取出相应块
       if location_map(i,j)==1
           md=bin2dec(num2str(md_matrix(md_count,:)))+1;%+1是因为md_matrix中数值从0开始的
           md_count=md_count+1;
           if md==dimen_y%第一行即为所有行的值
               for k=2:1:dimen_x
                  block(k,:)=block(1,:); 
               end
           else %需要补充值
               second_block=block(2:dimen_x,:);
               first_block=block(1,:);
               t_arry=second_block(:)';
               begin_e=md_num+2;%补充信息开始位置
               end_e=ideal_room-after_cap_matrix(i,j);%补充信息结束值
               e=t_arry(1,begin_e:end_e);%取补充信息
               e_num=dimen_x-1;%补充信息需要分多少份
               len_e=length(e)/e_num;%每份补充信息的长度
               common_information=first_block(1,1:md);
               for k=2:1:dimen_x
                   t_e=e(1,1:len_e);
                   e=e(1,1+len_e:length(e));%取出即删除
                   full_arry=[common_information,t_e];
                   block(k,:)=full_arry; 
               end
               
           end
       else %locate=0的情况
           block(2,1)=all_bit(1,1);%locate占用值被恢复
           all_bit=all_bit(1,2:length(all_bit));%取出即删除
       end
    re_MSB=block_to_matrix(re_MSB,block,i,j,dimen_x,dimen_y);%被处理后的MSB
   end
end
    another_information=all_bit;
