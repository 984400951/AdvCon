%Ω‚√‹

function re_MSB=Decrypt_MSB(emb_MSB,key)
[x,y]=size(emb_MSB);
rng(key);
key_matrix=randi([0,1],x,y);

re_MSB=bitxor(key_matrix,emb_MSB);