function m=wmean(x,w)
assert(length(w)==length(x));%make sure they are the same length
assert(any(size(w)==1));%make sure they are vectors
assert(any(size(x)==1));%make sure they are vectors
if size(x,1)~=1
    x=x';
end
if size(w,2)~=1
    w=w';
end

m=(x*w)/sum(w);