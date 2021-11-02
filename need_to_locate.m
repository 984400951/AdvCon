%需要多少位才能嵌入
function count=need_to_locate(dimen_x,dimen_y)
md=ceil(log2(dimen_y));%需要多少位表示位置点
all=md+1;%1代表location map所需的空间
vocate=dimen_x-1;%每多一个位置能腾出多少空间
count=ceil(all/vocate);

