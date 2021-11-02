
function de_remind=reprocessing_sevenLSB_API(re_remind_R,key,re_re_bit)


re_S=pix_sum(re_remind_R);%低7位的和矩阵
re_zone=Zone_num(re_S);%低7位的域矩阵
re_cap=pix_Cap(re_zone);%容量矩阵
re_exp=pix_Exp(re_zone);%表示位数的矩阵，即一个位置信息需要多少位bit来表示
re_locate=Re_locate(re_zone,re_cap,re_exp,re_remind_R,re_re_bit,re_S,key);%恢复位置矩阵
de_remind=en_I(re_remind_R,re_S,re_locate);%en_locate对应的低七位的密文像素