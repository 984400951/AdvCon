%”…Œª÷√æÿ’Ûª÷∏¥µÕ∆ﬂŒªµƒÕºœÒ

function  after_I=en_I(de_R,S,en_locate)
[x,y]=size(S);
emb_I=de_R;
for i=1:1:x
   for j=1:1:y
       s=S(i,j);
       lo=en_locate(i,j);
       group=rank_opposite(lo,s);
       emb_I(i,j*2-1)=group(1);
       emb_I(i,j*2)=group(2);
   end
end
emb_I=uint8(emb_I);
after_I=emb_I;