
%lsb��ʣ������һλ
function [en_locate,lsb]=En_locate(cap,exp,zone,locate,key)
lsb=[];
flag=1;
[x,y]=size(cap);%y��ͼ����һ��
diff=exp-cap;%��ʾ�����Ƕ�����Ĳ�ֵ
en_locate=zeros(x,y);


t_k=zeros(x,y);
t_ov=zeros(x,y);
t_ov(:,:)=2;
f=zeros(x,y);

for i=1:1:x%ѡ�����������
    for j=1:1:y%ѡ�����������
    exp_num=exp(i,j);%�������������Ҫ�ö���λ��ʾ
    lo=locate(i,j);%�����������е�λ��
    limit=2^(exp_num)-1;%���Ľ���
    k=i*100+j+key*1000;
    rng(k);
    key_bit=randi([0,limit],1,1);
    t_k(i,j)=key_bit;
    lo_bit=dec2bin(bitxor(key_bit,lo),exp_num); %������
    
    if cap(i,j)~=0%����ܹ�Ƕ��,Ƕ������Ϊ������������ֻ�����ڣ�0,0���ͣ�127��127����
        if diff(i,j)==0 %S1���
            en_locate(i,j)=bin2dec(lo_bit);
            
        else
            z=zone(i,j)-1;%��ı�ʾ��Χ
            z_bit=dec2bin(z,exp_num);%ת��Ϊ������
            cap_num=cap(i,j);%Ƕ������
            lobit=lo_bit(1:cap_num);%��һ��Ƕ�������
            zbit=z_bit(2:exp_num);%��ĺ�n-1λ
            remind_bit= lo_bit(cap_num+1:exp_num);%��λ�þ�������һλ��ȡ����
            if bin2dec(zbit)>=bin2dec(lobit) %�ܽ��еڶ���Ƕ�룬S2���
                bit=[remind_bit,lobit];%������һλ�������λ
                en_locate(i,j)=bin2dec(bit);
                f(i,j)=1;
            else%���ܽ��ж���Ƕ�룬S3�����lsb���滻
                remind_bit=str2double(remind_bit);
                lsb(flag)=remind_bit; 
                flag=flag+1;
                en_locate(i,j)=bin2dec(lobit);
                t_ov(i,j)=remind_bit;
                f(i,j)=2;
            end
        end
    else
        en_locate(i,j)=0;%Ƕ������Ϊ������������ֻ�����ڣ�0,0���ͣ�127��127����
    end
%     if i==3 && j==220 
%        
%     end

    end
end
