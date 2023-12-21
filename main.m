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
audiowrite(filename,audio,Fs);
disp(['录音已保存为 ' filename]);

%[audio, Fs] = audioread(filename); 

% 采样点数
sampleNum = length(audio); 
disp(['采样频率为 ' num2str(Fs/1000) ' kHz']);
disp(['采样点数为 ' num2str(sampleNum)]);


% 时间轴
t = (0:(length(audio)-1))*(1/fs);

% 音频的FFT
audio_fft = fft(audio);

freqfft = (0:(length(audio_fft)/2-1))*(fs/length(audio_fft));

% 作频谱图
Nspec = 256;
wspec = hamming(Nspec);
Noverlap = Nspec/2;
[S, fspec, tspec] = spectrogram(audio, wspec, Noverlap, Nspec, fs);

% 时域和频域

subplot(211);
plot(t, audio);
xlabel('Time (s)');
ylabel('Amplitude');

subplot(212);
plot(freqfft, abs(audio_fft(1:length(audio_fft)/2)));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');






% 设计滤波器

% 低通滤波器

fp = 1000;  % 通带截止频率
fs = 1200;  % 阻带截止频率
Ap = 1;     % 通带最大允许波纹
As = 100;   % 阻带衰减




% 高通滤波器
%fc = 4800
%fb = 5000
%As = 100
%Ap = 1

% 带通滤波器

%fb1 = 1200
%fb2 = 3000
%fc1 = 1000
%fc2 = 3200
%As = 100
%Ap = 1






