fs = 44100; 
recObj = audiorecorder(fs,16,1); 

% 音频录制
time = 3;  
disp("开始说话!!")
recordblocking(recObj,time);  
audio = getaudiodata(recObj); 
disp("结束录制:)")   


% 保存录音文件
filename = 'recorded_audio.wav';
audiowrite(filename,audio,fs);
disp(['录音已保存为 ' filename]);

[audio, Fs] = audioread(filename); 

sound(audio,Fs);



