%块开始的行和列

function [begin_x,end_x]=begin_end(dimen,i)
begin_x=(i-1)*dimen+1;
end_x=i*dimen;