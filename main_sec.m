filename = 'keyboad-typing.wav';

[audio, fs] = audioread(filename); 

% 采样点数
sampleNum = length(audio); 
disp(['采样频率为 ' num2str(fs/1000) ' kHz']);
disp(['采样点数为 ' num2str(sampleNum)]);


% 时间轴
t = (0:(length(audio)-1))*(1/fs);

% 音频的FFT
audio_fft = fft(audio);

freqfft = (0:(length(audio_fft)/2-1))*(fs/length(audio_fft));

% 时域和频域
figure('Name','Time & Freq')

subplot(211);
plot(t, audio);
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(212);
plot(freqfft, abs(audio_fft(1:length(audio_fft)/2)));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

% 利用汉明窗设计低通滤波器
% fp1=1000 fs1=1200 (Hz)
% rp1=1 rs1=100 (dB)

fp1=1000; fs1=1200; rp1=1; rs1=100;
N1 = 48;
b = fir1(N1,fp1/(fs/2),'low',hamming(N1+1));  % 使用汉明窗

figure('Name','Hamming');
freqz(b, 1, 1024, fs);
grid on;


% 设计巴特沃斯高通滤波器
% fp2=4800 fs2=5000 (Hz)
% rp2=1 rs2=100 (dB)

fp2=4800; fs2=5000; rp2=1; rs2=100;  
wp2_n = fp2 / (fs/2); ws2_n = fs2 / (fs/2);     %归一化

[N2,wc2] = buttord(wp2_n,ws2_n,rp2,rs2);
[B2, A2] = butter(N2, wc2, 'high');

figure('Name','Butterworth')
freqz(B2, A2, 1024, fs);
grid on;


% 设计椭圆带通滤波器
% fb1=1200 fb2=3000 fc1=1000以下滤除 fc2=3200以上滤除 (Hz)
% rs3=100 rp3=1 (dB)

fb1=1200; fb2=3000; fc1=1000; fc2=3200;
wp3 = [2*fb1/fs, 2*fb2/fs];  ws3 = [2*fc1/fs, 2*fc2/fs]     %归一化
rp3=1; rs3=100;

[N3,wpo] = ellipord(wp3,ws3,rp3,rs3);
[B3,A3] = ellip(N3,rp3,rs3,wpo);

figure('Name','ellip')
freqz(B3, A3, 1024, fs);
grid on;









