%ͼ�����Ҽ���

function after_I=P_box(I,dimen,key)
[x,y]=size(I);
after_I=I;
b_x=x/dimen;
b_y=y/dimen;
pix_num=dimen^2;
step=0;
rng(key);
r=randsample(pix_num,pix_num);

for i=1:1:b_x
   x_begin=(i-1)*dimen+1;
   x_end=i*dimen;
   for j=1:1:b_y
       step=step+1;
       y_begin=(j-1)*dimen+1;
       y_end=j*dimen;
       t_matrix=after_I(x_begin:x_end,y_begin:y_end);%ȡ�����е�Ԫ��
       after_t=t_matrix(r);%����Ԫ�ش���,Ϊһ��
       blo_t=reshape(after_t,dimen,dimen);%��һ��Ԫ�����±��һ�飬���е�˳�����
       after_I(x_begin:x_end,y_begin:y_end)=blo_t;
   end
end
