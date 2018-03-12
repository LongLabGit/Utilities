reboot;
addpath S:\Vigi\Matlab\GitHub\Clustering\IO 
maxPiece=10*60;%analyze X seconds at a time. here 10 minutes. use for RAM control, increase for minor time speedups and avoiding edge effects
F='S:\Vigi\Datasets\CorticalSpikes\Data\Monkey2\ECoG1#4_2018-02-23_18-41-58_briefsf11\intanClean\';
fOrig=[F,'amplifier.dat'];
fNew=[F,'amplifier.fil'];
fs=3e4;nAmp=64;
%%
fileinfo = dir(fOrig);
total_seconds = fileinfo.bytes/(nAmp * 2)/fs;
%250 to 3000 is really good for MUA
bpFilt = designfilt('bandpassfir','FilterOrder',1000,'SampleRate',fs,...
    'CutoffFrequency1',250,'CutoffFrequency2',3000);
fid = fopen(fNew, 'w');
start = 0;
stop = total_seconds;
indCut=0;
right = start;
while right < stop
    left = start+indCut*maxPiece;
    right = min(stop,left+maxPiece);
    dur=right-left;
    dataChunk = LoadBinary(fOrig,'nChannels',nAmp,'channels',1:nAmp,'start',left,'duration',dur,'frequency',fs);
    dataChunk=filtfilt(bpFilt,double(dataChunk*10))/10; 
    fwrite(fid, int16(dataChunk'), 'int16');
    indCut=indCut+1; 
    fprintf([num2str(indCut) '/' num2str(ceil((stop-start)/maxPiece)) ', '])
end
fclose(fid);
disp('done')