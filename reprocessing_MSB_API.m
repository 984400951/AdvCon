%�ָ�MSBͬʱ��ȡ��Ϣ

function [another_information,re_MSB]=reprocessing_MSB_API(after_MSB,dimen_x,dimen_y,key)

emb_MSB=Decrypt_MSB(after_MSB,key);%����MSB

threshold=need_to_locate(dimen_x,dimen_y);%λ����ֵ,������˵���ǽضϵ����ޡ����磬���Ϊ1����˵��������Ҫһ����Ȳ��ܹ�����Ƕ�����
md_num=ceil(log2(dimen_y));%md��ռ��λ��
[x,y]=size(emb_MSB);
block_x=x/dimen_x;%�����ж��ٿ�
block_y=y/dimen_y;%�����ж��ٿ�
md_matrix=[];
ideal_room=(dimen_x-1)*dimen_y;%���˵�һ��֮�������
location_map=zeros(block_x,block_y);


%%��ȡmd��location
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
       [location,md]=extract_to_cap_md(block,md_num);
       location_map(i,j)=location;
       if location==1
           md_matrix=[md_matrix;md];
       end
   end
end
after_cap_matrix=zeros(block_x,block_y);

md_count=1;
e=[];%������Ϣ
length_e_matrix=zeros(block_x,block_y);%������Ϣ�ĳ�����Ϣ
for i=1:1:block_x
   for j=1:1:block_y
       block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
       second_block=block(2:dimen_x,:);
       t_second_arry=second_block(:)';
       t=location_map(i,j);
       if t~=0%��˵��Ƕ��������Ϊ��

           md=bin2dec(num2str(md_matrix(md_count,:)))+1;
           if md~=dimen_y %˵���в�����Ϣ
               begin_E=md_num+1;%�޳�location+md
               one_e_num=dimen_y-md;%һ��������Ϣ�ĳ���
               lengh_e=one_e_num*(dimen_x-1);%���в�����Ϣ���ܳ���
               t_e=t_second_arry(begin_E+1:begin_E+lengh_e);%ȡ��������Ϣ
               length_e_matrix(i,j)=length(t_e);
               e=[e,t_e];
           end
           after_cap_matrix(i,j)=md*(dimen_x-1)-md_num-1;%md*(dimen_x-1)�����ڳ��Ŀռ���λ������ȥmdռ��λ������ȥlocationռ��λ��
           md_count=md_count+1;
       end
   end
end


%��ȡ������Ϣ
init_threshold_per=0.5;%��ʼ�ƻ�ÿ������Ƕ��İٷֱ�

%fisrst_bit=[0,0,0];%�������ã���ɾ����
fisrst_bit=emb_MSB(1,1:3);%��ȡǰ��λ
threshold_per=init_threshold_per+bin2dec(num2str(fisrst_bit))/10;%���õ��İٷֱ���ֵ
all_bit=[];%��ȡǶ�����Ϣ
for i=1:1:block_x
   for j=1:1:block_y
       if location_map(i,j)==1
           block=index_to_block(emb_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
           t_cap=after_cap_matrix(i,j);
           cap=ceil(t_cap*threshold_per);%�ÿ���Ƕ�������Ϣ������
           second_block=block(2:dimen_x,:);
           t_arry=second_block(:)';%ת��������
           t_bit=t_arry(1,ideal_room-t_cap+1:ideal_room-t_cap+cap);
           all_bit=[all_bit,t_bit];
       end
   end
end



re_first_bit=all_bit(1,1:3);%����ǰ��λ����Ϣ
emb_MSB(1,1:3)=re_first_bit;%�ı�ǰ��λ
all_bit=all_bit(1,4:length(all_bit));%ɾ����һ��������



%�ָ�����
re_MSB=emb_MSB;
md_count=1;
for i=1:1:block_x
    if i==97
     
    end
   for j=1:1:block_y 
       block=index_to_block(re_MSB,i,j,dimen_x,dimen_y);%ȡ����Ӧ��
       if location_map(i,j)==1
           md=bin2dec(num2str(md_matrix(md_count,:)))+1;%+1����Ϊmd_matrix����ֵ��0��ʼ��
           md_count=md_count+1;
           if md==dimen_y%��һ�м�Ϊ�����е�ֵ
               for k=2:1:dimen_x
                  block(k,:)=block(1,:); 
               end
           else %��Ҫ����ֵ
               second_block=block(2:dimen_x,:);
               first_block=block(1,:);
               t_arry=second_block(:)';
               begin_e=md_num+2;%������Ϣ��ʼλ��
               end_e=ideal_room-after_cap_matrix(i,j);%������Ϣ����ֵ
               e=t_arry(1,begin_e:end_e);%ȡ������Ϣ
               e_num=dimen_x-1;%������Ϣ��Ҫ�ֶ��ٷ�
               len_e=length(e)/e_num;%ÿ�ݲ�����Ϣ�ĳ���
               common_information=first_block(1,1:md);
               for k=2:1:dimen_x
                   t_e=e(1,1:len_e);
                   e=e(1,1+len_e:length(e));%ȡ����ɾ��
                   full_arry=[common_information,t_e];
                   block(k,:)=full_arry; 
               end
               
           end
       else %locate=0�����
           block(2,1)=all_bit(1,1);%locateռ��ֵ���ָ�
           all_bit=all_bit(1,2:length(all_bit));%ȡ����ɾ��
       end
    re_MSB=block_to_matrix(re_MSB,block,i,j,dimen_x,dimen_y);%��������MSB
   end
end
    another_information=all_bit;
