%块嵌入
%block 嵌入块，E=locate_map+md(加密后),t_md=原始md；如果t_md等于0则说明只有最高位相等！！！
function [after_block,cap]=emb_block(block,E,t_md)
[x,y]=size(block);
dec_md=bin2dec(num2str(t_md))+1;%1最高位相等，最大则说明都相等！！
e=[];%补充值
for i=2:1:x%从第二行开始，第一行作为基准
   c=block(i,:);%取出
   if dec_md~=y%这种情况下有补充值
       t_e=c(dec_md+1:y);
       e=[e,t_e];
   end
end
aux=[E,e];

len_aux=length(aux);
len_stand=(x-1)*y;

if len_aux<len_stand
   t_arry=zeros(1,len_stand-len_aux);
   aux=[aux,t_arry];
end
cap=len_stand-len_aux;
blo_t=reshape(aux,x-1,y);%将一列元素重新变成一块，以列的顺序进行
after_block=[block(1,:);blo_t];