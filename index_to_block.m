%根据index取出相应块
function block=index_to_block(R,i,j,dimen_x,dimen_y)
[begin_x,end_x]=begin_end(dimen_x,i);
[begin_y,end_y]=begin_end(dimen_y,j);
block=R(begin_x:end_x,begin_y:end_y);