
function re_R=Decrypt(en_R,dimen_x,dimen_y,dimen,key,key_seven,key_per_MSB)

key=mod(key,2^20);
key_seven=mod(key_seven,2^20);
key_per_MSB=mod(key_per_MSB,2^20);

en_R=double(en_R);
after_R=De_I(en_R,dimen,key_per_MSB);%ÖÃÂÒ½âÃÜ
after_MSB=(floor(after_R/2^7));
re_remind_R=mod(after_R,2^7);%Í¼ÏñµÄµÍ7Î»
[re_another_information,re_MSB]=reprocessing_MSB_API(after_MSB,dimen_x,dimen_y,key);
de_remind=reprocessing_sevenLSB_API(re_remind_R,key_seven,re_another_information);
re_R=uint8(re_MSB)*2^7+de_remind;%½âÃÜÍ¼Ïñ