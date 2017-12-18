reboot;
addpath S:\Vigi\Matlab\GitHub\Clustering\IO 
maxPiece=8*60;%analyze X seconds at a time. here 10 minutes. use for RAM control, increase for minor time speedups
fOrig='S:\Vigi\Datasets\CorticalSpikes\Data\Monkey\Intan\jointClean\amplifier.dat';
fNew='S:\Vigi\Datasets\CorticalSpikes\Data\Monkey\Intan\jointClean\amplifier.fil';
fs=3e4;nAmp=64;
%%
fileinfo = dir(fOrig);
total_seconds = fileinfo.bytes/(nAmp * 2)/fs;
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