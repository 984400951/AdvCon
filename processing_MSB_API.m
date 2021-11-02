%加密MSB的接口

function after_MSB=processing_MSB_API(R_MSB,dimen_x,dimen_y,dimen,key,another_information)

threshold=need_to_locate(dimen_x,dimen_y);%位置阈值,具体来说就是截断的下限。例如，如果为1，则说明至少需要一列相等才能够进行嵌入过程
md_num=ceil(log2(dimen_y));%md所占的位数
md_matrix=[];
md_count=1;
[x,y]=size(R_MSB);
block_x=x/dimen_x;%行上有多少块
block_y=y/dimen_y;%列上有多少块
location_map=zeros(block_x,block_y);%映射图


for i=1:1:block_x%求location_map 以及 md_matrix
   for j=1:1:block_y
       block=index_to_block(R_MSB,i,j,dimen_x,dimen_y);%取出相应块
       location=location_pre(block);%每一块中截断的位置,note:0表示没有一列相等
       if location < threshold %判断是否有足够空间进行嵌入
          location_map(i,j)=0;%没有足够的空间
       else%有足够的空间进行嵌入
           location_map(i,j)=1;
           md_char=dec2bin(location-1,md_num);%减1，是因为在这一部分是从0开始的
           md=str2num(md_char(:))';
           md_matrix(md_count,:)=md;%只有有足够空间的时候才有
           md_count=md_count+1;
       end                
   end
end

%%%这个地方进行加密
en_location_map=location_map;
en_md_matrix=md_matrix;

%%%%这一部分是每一块划分后除了t=0外的辅助信息都嵌入进去
md_count=1;
aux_t=[];%记录辅助数据
aux_count=1;
after_matrix=R_MSB;
cap_matrix=zeros(block_x,block_y);
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(R_MSB,i,j,dimen_x,dimen_y);%取出相应块
       t=location_map(i,j);
       if t==1
           md=en_md_matrix(md_count,:);
           t_md=md_matrix(md_count,:);
           E=[t,md];%嵌入块中的辅助数据
           [after_block,cap_matrix(i,j)]=emb_block(block,E,t_md);
           md_count=md_count+1;%md矩阵的指针向下移一位
       else %t=0
           aux_t(aux_count)=block(2,1);
           after_block=block;
           after_block(2,1)=t;
           aux_count=aux_count+1;
       end
       after_matrix=block_to_matrix(after_matrix,after_block,i,j,dimen_x,dimen_y);%被处理后的MSB
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%这一部分进行嵌入额外的信息和aux

first=after_matrix(1,1:3);%这部分信息被存储，以用来保存百分比
all_aux_t=[first,aux_t,another_information];%first=前三位用来存储百分比-0.5，aux_t是location_map=0的替换值
emb_lengh=length(all_aux_t);%额外信息的总长度
sum_cap=sum(cap_matrix(:));
if emb_lengh>sum_cap
   after_MSB=zeros(x,y);%错误处理情况
   '嵌入失败'
   
   emb_lengh
   sum_cap
   return;
end
init_threshold_per=0.5;%初始计划每个块中嵌入的百分比

t_divide=emb_lengh/sum_cap;
if t_divide>init_threshold_per
    threshold_per=ceil(t_divide*10)/10;
else
    threshold_per=init_threshold_per;
end
t_first=dec2bin(uint8((threshold_per-init_threshold_per)*10),3);
first_replace=str2num(t_first(:))';
after_matrix(1,1:3)=first_replace;%前三位替换掉


[emb_MSB,after_cap_matrix]=emb_aux_information(after_matrix,all_aux_t,cap_matrix,threshold_per);%嵌入辅助信息

en_MSB=Encrypt_MSB(emb_MSB,after_cap_matrix,key);%加密MSB

after_MSB=Adjust_MSB(R_MSB,en_MSB,dimen,dimen_x,dimen_y,after_cap_matrix);%调整