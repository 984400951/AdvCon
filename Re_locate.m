%�ָ�λ�þ���

function re_locate=Re_locate(re_zone,re_cap,re_exp,de_R,lsbs,S,key)
[x,y]=size(re_cap);
diff=re_exp-re_cap;
locate=pix_locate(de_R,re_zone,S);
re_locate=locate;
flag=1;
for i=1:1:x
   for j=1:1:y
       cap_num=re_cap(i,j);
       exp_num=re_exp(i,j);
       lo=locate(i,j);
       
       if cap_num~=0
           if diff(i,j)==0%S1���
               en_lo=dec2bin(lo,exp_num);
           else 
               z=re_zone(i,j)-1;             
               lo_bit=dec2bin(lo,exp_num);     
               z_bit=dec2bin(z,exp_num);%��������������ת��Ϊ������
               first_bit=lo_bit(2:exp_num);%��һ��Ƕ�����Ϣ
               zbit=z_bit(2:exp_num);%��ĺ�n-1λ
               if bin2dec(zbit)>=bin2dec(first_bit) %�ܽ��еڶ���Ƕ�룬S2���
                   remind_bit=lo_bit(1:1);
                   en_lo=[first_bit,remind_bit];
               else%���򣬴�����λ����ȡ��Ϣ
                   remind_bit=num2str(lsbs(flag));
                   en_lo=[first_bit,remind_bit];
                   flag=flag+1;
               end
           end
       limit=2^(exp_num)-1;%���Ľ���
       k=i*100+j+key*1000;
       rng(k);
       key_bit=randi([0,limit],1,1);
       lo_bit=bitxor(key_bit,bin2dec(en_lo));%������
       re_locate(i,j)=lo_bit;
       else%Ƕ������Ϊ��
           re_locate(i,j)=0;
       end
      
%        if t(i,j)~=re_locate(i,j)
%            error('1');
%        end
   end
end