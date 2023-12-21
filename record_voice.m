Fs = 44100; 
recObj = audiorecorder(Fs,16,1); 

% 音频录制
time = 5;  
disp("开始说话!!")
recordblocking(recObj,time);  
audio = getaudiodata(recObj); 
disp("结束录制:)")   
     

% 保存录音文件
filename = 'recorded_audio.wav';
audiowrite(filename, audio,Fs);
disp(['录音已保存为 ' filename]);





