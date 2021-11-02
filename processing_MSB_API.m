%����MSB�Ľӿ�

function after_MSB=processing_MSB_API(R_MSB,dimen_x,dimen_y,dimen,key,another_information)

threshold=need_to_locate(dimen_x,dimen_y);%λ����ֵ,������˵���ǽضϵ����ޡ����磬���Ϊ1����˵��������Ҫһ����Ȳ��ܹ�����Ƕ�����
md_num=ceil(log2(dimen_y));%md��ռ��λ��
md_matrix=[];
md_count=1;
[x,y]=size(R_MSB);
block_x=x/dimen_x;%�����ж��ٿ�
block_y=y/dimen_y;%�����ж��ٿ�
location_map=zeros(block_x,block_y);%ӳ��ͼ


for i=1:1:block_x%��location_map �Լ� md_matrix
   for j=1:1:block_y
       block=index_to_block(R_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
       location=location_pre(block);%ÿһ���нضϵ�λ��,note:0��ʾû��һ�����
       if location < threshold %�ж��Ƿ����㹻�ռ����Ƕ��
          location_map(i,j)=0;%û���㹻�Ŀռ�
       else%���㹻�Ŀռ����Ƕ��
           location_map(i,j)=1;
           md_char=dec2bin(location-1,md_num);%��1������Ϊ����һ�����Ǵ�0��ʼ��
           md=str2num(md_char(:))';
           md_matrix(md_count,:)=md;%ֻ�����㹻�ռ��ʱ�����
           md_count=md_count+1;
       end                
   end
end

%%%����ط����м���
en_location_map=location_map;
en_md_matrix=md_matrix;

%%%%��һ������ÿһ�黮�ֺ����t=0��ĸ�����Ϣ��Ƕ���ȥ
md_count=1;
aux_t=[];%��¼��������
aux_count=1;
after_matrix=R_MSB;
cap_matrix=zeros(block_x,block_y);
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(R_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
       t=location_map(i,j);
       if t==1
           md=en_md_matrix(md_count,:);
           t_md=md_matrix(md_count,:);
           E=[t,md];%Ƕ����еĸ�������
           [after_block,cap_matrix(i,j)]=emb_block(block,E,t_md);
           md_count=md_count+1;%md�����ָ��������һλ
       else %t=0
           aux_t(aux_count)=block(2,1);
           after_block=block;
           after_block(2,1)=t;
           aux_count=aux_count+1;
       end
       after_matrix=block_to_matrix(after_matrix,after_block,i,j,dimen_x,dimen_y);%��������MSB
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%��һ���ֽ���Ƕ��������Ϣ��aux

first=after_matrix(1,1:3);%�ⲿ����Ϣ���洢������������ٷֱ�
all_aux_t=[first,aux_t,another_information];%first=ǰ��λ�����洢�ٷֱ�-0.5��aux_t��location_map=0���滻ֵ
emb_lengh=length(all_aux_t);%������Ϣ���ܳ���
sum_cap=sum(cap_matrix(:));
if emb_lengh>sum_cap
   after_MSB=zeros(x,y);%���������
   'Ƕ��ʧ��'
   
   emb_lengh
   sum_cap
   return;
end
init_threshold_per=0.5;%��ʼ�ƻ�ÿ������Ƕ��İٷֱ�

t_divide=emb_lengh/sum_cap;
if t_divide>init_threshold_per
    threshold_per=ceil(t_divide*10)/10;
else
    threshold_per=init_threshold_per;
end
t_first=dec2bin(uint8((threshold_per-init_threshold_per)*10),3);
first_replace=str2num(t_first(:))';
after_matrix(1,1:3)=first_replace;%ǰ��λ�滻��


[emb_MSB,after_cap_matrix]=emb_aux_information(after_matrix,all_aux_t,cap_matrix,threshold_per);%Ƕ�븨����Ϣ

en_MSB=Encrypt_MSB(emb_MSB,after_cap_matrix,key);%����MSB

after_MSB=Adjust_MSB(R_MSB,en_MSB,dimen,dimen_x,dimen_y,after_cap_matrix);%����