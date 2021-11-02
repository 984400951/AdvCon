
function en_R=Encrypt(R,dimen_x,dimen_y,dimen,key,key_seven,key_per_MSB)
key=mod(key,2^20);
key_seven=mod(key_seven,2^20);
key_per_MSB=mod(key_per_MSB,2^20);
R_MSB=uint8(floor(double(R)/2^7));
remind_R=mod(R,2^7);%Í¼ÏñµÄµÍ7Î»
[after_remind,another_information]=provessiong_sevenLSB_API(remind_R,key_seven);
after_MSB=processing_MSB_API(R_MSB,dimen_x,dimen_y,dimen,key,another_information);

en_init_R=uint8(after_MSB)*2^7+after_remind;%ÃÜÎÄÍ¼Ïñ
en_R=en_init_R;
en_R=P_box(en_init_R,dimen,key_per_MSB);