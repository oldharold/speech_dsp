fullFilePath = "/Users/harold/projects/dsp-ahjzu/audios/recorded_audio.wav"

[audioData, Fs] = audioread(fullFilePath);  %使用audioread读取音频中数据

sampleNum = length(audioData);

disp(['采样频率为 ' num2str(Fs/1000) ' kHz']);
disp(['采样点数为 ' num2str(sampleNum)]);

time = (0:sampleNum-1) / Fs;   % 1 / Fs 是单个采样周期
subplot(2,2,1);
plot(time, audioData);
xlabel('时间 (秒)');
ylabel('振幅');
title('语音信号的时域波形');

% 或者进行频谱分析：
subplot(2,2,2);

title('语音信号的频谱图');





