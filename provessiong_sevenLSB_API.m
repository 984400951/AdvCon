
function [after_remind,re_bit]=provessiong_sevenLSB_API(remind_R,key)
S=pix_sum(remind_R);%��7λ�ĺ;���
zone=Zone_num(S);%��7λ�������
cap=pix_Cap(zone);%��������
exp=pix_Exp(zone);%��ʾλ���ľ��󣬼�һ��λ����Ϣ��Ҫ����λbit����ʾ
locate=pix_locate(remind_R,zone,S);%λ�þ���ȷ�����������������ڵ�λ��
[en_locate,re_bit]=En_locate(cap,exp,zone,locate,key);%en_locate�Ǽ��ܵ�λ�ã�re_bit��ʣ����������
after_remind=en_I(remind_R,S,en_locate);%en_locate��Ӧ�ĵ���λ����������
