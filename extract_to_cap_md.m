%提取出每块的location_map和md
function [locate,md]=extract_to_cap_md(block,num_md)
[x,y]=size(block);
after_block=block(2:x,:);%剔除掉第一行
t_arry=after_block(:)';%
locate=t_arry(1,1);
if locate==1
    md=t_arry(1,2:1+num_md);
else
    md=[];
end