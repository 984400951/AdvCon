
function [after_remind,re_bit]=provessiong_sevenLSB_API(remind_R,key)
S=pix_sum(remind_R);%低7位的和矩阵
zone=Zone_num(S);%低7位的域矩阵
cap=pix_Cap(zone);%容量矩阵
exp=pix_Exp(zone);%表示位数的矩阵，即一个位置信息需要多少位bit来表示
locate=pix_locate(remind_R,zone,S);%位置矩阵，确定像素组在域中所在的位置
[en_locate,re_bit]=En_locate(cap,exp,zone,locate,key);%en_locate是加密的位置，re_bit是剩下来的像素
after_remind=en_I(remind_R,S,en_locate);%en_locate对应的低七位的密文像素
