function [x,y]=squareSubplots(n,vert)
if vert
    x=ceil(sqrt(n));
else
    x=floor(sqrt(n));
end
y=ceil(n/x);
