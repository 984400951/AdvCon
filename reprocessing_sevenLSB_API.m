
function de_remind=reprocessing_sevenLSB_API(re_remind_R,key,re_re_bit)


re_S=pix_sum(re_remind_R);%��7λ�ĺ;���
re_zone=Zone_num(re_S);%��7λ�������
re_cap=pix_Cap(re_zone);%��������
re_exp=pix_Exp(re_zone);%��ʾλ���ľ��󣬼�һ��λ����Ϣ��Ҫ����λbit����ʾ
re_locate=Re_locate(re_zone,re_cap,re_exp,re_remind_R,re_re_bit,re_S,key);%�ָ�λ�þ���
de_remind=en_I(re_remind_R,re_S,re_locate);%en_locate��Ӧ�ĵ���λ����������