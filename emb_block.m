%��Ƕ��
%block Ƕ��飬E=locate_map+md(���ܺ�),t_md=ԭʼmd�����t_md����0��˵��ֻ�����λ��ȣ�����
function [after_block,cap]=emb_block(block,E,t_md)
[x,y]=size(block);
dec_md=bin2dec(num2str(t_md))+1;%1���λ��ȣ������˵������ȣ���
e=[];%����ֵ
for i=2:1:x%�ӵڶ��п�ʼ����һ����Ϊ��׼
   c=block(i,:);%ȡ��
   if dec_md~=y%����������в���ֵ
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
blo_t=reshape(aux,x-1,y);%��һ��Ԫ�����±��һ�飬���е�˳�����
after_block=[block(1,:);blo_t];