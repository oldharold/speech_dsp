% main_third.m 使用子函数

filename = 'keyboad-typing.wav';

[audio, fs] = audioread(filename); 

% 采样点数
sampleNum = length(audio); 
disp(['采样频率为 ' num2str(fs/1000) ' kHz']);
disp(['采样点数为 ' num2str(sampleNum)]);


% 时间轴
t = (0:(length(audio)-1))*(1/fs);

% 时域和频域
figure('Name','Time & Freq')

TimeFrep_plot(t,audio,fs)


% 利用kaiser窗设计低通滤波器
% fp1=1000 fs1=1200 (Hz)
% rp1=1 rs1=100 (dB)

fp1=1000; fs1=1200; rp1=1; rs1=100;
N1 = 48;
b = fir1(N1,fp1/(fs/2),'low',kaiser(N1+1));  % 使用汉明窗

figure('Name','Hamming');
freqz(b, 1, 1024, fs);
grid on;


% 设计巴特沃斯高通滤波器
% fp2=4800 fs2=5000 (Hz)
% rp2=1 rs2=100 (dB)

fp2=4800; fs2=5000; rp2=1; rs2=100;  
wp2 = 2*pi*fp2/fs; ws2 = 2*pi*fs2/fs;     %归一化
wp2n = 2*tan(wp2/2)/5;
ws2n = 2*tan(ws2/2)/5;

[N2,wc2] = buttord(wp2n,ws2n,rp2,rs2);
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


% 用kaiser窗滤波器对信号进行滤波

fir_audio = fftfilt(b,audio);

figure('Name','Time & Freq After Hamming fitting')

TimeFrep_plot(t,fir_audio,fs)



% 巴特沃斯滤波器对信号进行滤波

iir1_audio = filter(B2,A2,audio);

figure('Name','Time & Freq After Butterworth fitting')

TimeFrep_plot(t,iir1_audio,fs)


% 椭圆滤波器对信号进行滤波

iir2_audio = filter(B3,A3,audio);

figure('Name','Time & Freq After Ellip fitting')

TimeFrep_plot(t,iir2_audio,fs)



% Butterworth,ellip滤波有问题

sound(fir_audio,fs,16);






