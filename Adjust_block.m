%������

function after_block=Adjust_block(t_or_matrix,t_en_matrix,t_cap_matrix,dimen_x,dimen_y,dimen)
after_block=t_en_matrix;
or_sum=sum(sum(t_or_matrix(:)));%ԭʼMSB֮��
en_sum=sum(sum(t_en_matrix(:)));%����MSB֮��
cap_sum=sum(sum(t_cap_matrix(:)));%�ռ�֮��

radio_x=dimen/dimen_x;%%���Կ��С�͵������С�ı�
radio_y=dimen/dimen_y;%%���Կ��С�͵������С�ı�

cha=or_sum-en_sum;
if cha<=0
   return; 
end

if cha>cap_sum%��������
   adjust=cap_sum;
else%��������
    adjust=cha;
end

n=(dimen_x-1)*dimen_y;%�ܹ��ռ䣬��ȥ��һ��

for i=1:1:radio_x
    [begin_x,end_x]=begin_end(dimen_x,i);%ѹ����λ��
   for j=1:1:radio_y
       [begin_y,end_y]=begin_end(dimen_y,j);%ѹ����λ��
       t_matrix=t_en_matrix(begin_x:end_x,begin_y:end_y);%����ȡ����
       first_matrix=t_matrix(1,:);%��һ��
       t_matrix=t_matrix(2:dimen_x,:);%ȥ����һ��
      
       t_cap=t_cap_matrix(i,j);%��ѹ�����ж��ٿռ�
       if t_cap<adjust%��������Ŀռ䲻�ܹ�������ô�����
           t_adjust=t_cap;%����������λ��
           adjust=adjust-t_adjust;%��ʣ����λ��Ҫ����
       else
           t_adjust=adjust;
           adjust=adjust-t_adjust;%��ʣ����λ��Ҫ����
           
       end
       adjust_arry=ones(1,t_adjust);%��Ҫ���ٸ�1
       if t_adjust>0%�ж��ܹ�Ƕ��
            t_arry=t_matrix(:)';%���������з����˳��Ϊ����
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