
%lsb是剩下来的一位
function [en_locate,lsb]=En_locate(cap,exp,zone,locate,key)
lsb=[];
flag=1;
[x,y]=size(cap);%y是图像宽的一半
diff=exp-cap;%表示矩阵和嵌入矩阵的差值
en_locate=zeros(x,y);


t_k=zeros(x,y);
t_ov=zeros(x,y);
t_ov(:,:)=2;
f=zeros(x,y);

for i=1:1:x%选中像素组的行
    for j=1:1:y%选中像素组的列
    exp_num=exp(i,j);%该像素组的域需要用多少位表示
    lo=locate(i,j);%像素组在域中的位置
    limit=2^(exp_num)-1;%异或的界限
    k=i*100+j+key*1000;
    rng(k);
    key_bit=randi([0,limit],1,1);
    t_k(i,j)=key_bit;
    lo_bit=dec2bin(bitxor(key_bit,lo),exp_num); %异或加密
    
    if cap(i,j)~=0%如果能够嵌入,嵌入容量为零的情况不处理（只存在于（0,0）和（127，127））
        if diff(i,j)==0 %S1情况
            en_locate(i,j)=bin2dec(lo_bit);
            
        else
            z=zone(i,j)-1;%域的表示范围
            z_bit=dec2bin(z,exp_num);%转化为二进制
            cap_num=cap(i,j);%嵌入容量
            lobit=lo_bit(1:cap_num);%第一次嵌入的数据
            zbit=z_bit(2:exp_num);%域的后n-1位
            remind_bit= lo_bit(cap_num+1:exp_num);%将位置矩阵的最后一位提取出来
            if bin2dec(zbit)>=bin2dec(lobit) %能进行第二次嵌入，S2情况
                bit=[remind_bit,lobit];%将余下一位放在最高位
                en_locate(i,j)=bin2dec(bit);
                f(i,j)=1;
            else%不能进行二次嵌入，S3情况，lsb被替换
                remind_bit=str2double(remind_bit);
                lsb(flag)=remind_bit; 
                flag=flag+1;
                en_locate(i,j)=bin2dec(lobit);
                t_ov(i,j)=remind_bit;
                f(i,j)=2;
            end
        end
    else
        en_locate(i,j)=0;%嵌入容量为零的情况不处理（只存在于（0,0）和（127，127））
    end
%     if i==3 && j==220 
%        
%     end

    end
end
