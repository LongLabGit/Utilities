function plotRaster(times,trial,maxTr,tSong,c)
if nargin<5
    c='b';
end
for i=1:length(times)
    line(times(i)*[1,1],trial(i)+[-.5,.5],'color',c)
end
line(tSong(1)*[1,1],[-.5,maxTr+.5],'color','k','linestyle','-','linewidth',2)
line(tSong(2)*[1,1],[-.5,maxTr+.5],'color','k','linestyle','-','linewidth',2)
ylim([.5,maxTr+.5])