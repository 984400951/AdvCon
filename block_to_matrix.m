%处理好的块组装回矩阵

function after_matrix=block_to_matrix(R,block,i,j,dimen_x,dimen_y)
[begin_x,end_x]=begin_end(dimen_x,i);
[begin_y,end_y]=begin_end(dimen_y,j);
R(begin_x:end_x,begin_y:end_y)=block;
after_matrix=R;