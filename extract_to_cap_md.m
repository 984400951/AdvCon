%��ȡ��ÿ���location_map��md
function [locate,md]=extract_to_cap_md(block,num_md)
[x,y]=size(block);
after_block=block(2:x,:);%�޳�����һ��
t_arry=after_block(:)';%
locate=t_arry(1,1);
if locate==1
    md=t_arry(1,2:1+num_md);
else
    md=[];
end