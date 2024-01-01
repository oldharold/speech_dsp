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


% 利用设计低通滤波器
% fp1=1000 fs1=1200 (Hz)
% rp1=1 rs1=100 (dB)


fp1=1000; fs1=1200; rp1=1; rs1=100;

% fir1设计
N = 48;
b = fir1(N,fp1/(fs/2),'low',kaiser(N+1));  

figure('Name','Lowpass FIR');
freqz(b, 1, 1024, fs);

% ellip设计
wp1=2*pi*fp1/fs;
ws1=2*pi*fs1/fs;
[N1,wpo1]=ellipord(wp1,ws1,rp1,rs1,'s');
[B1, A1]=ellip(N1,rp1,rs1,wpo1,'s');
[Bz1,Az1]=bilinear(B1, A1,1);

figure('Name','Lowpass IIR ')
freqz(Bz1, Az1, 1024, fs);




% 设计高通滤波器
% fp2=4800 fs2=5000 (Hz)
% rp2=1 rs2=100 (dB)
fp2=4800; fs2=5000; rp2=1; rs2=100;  

% fir1设计
b2 = fir1(N,fp2/(fs/2),'high',kaiser(N+1));  

figure('Name','Highpass FIR ');
freqz(b2, 1, 1024, fs);


wp2=2*pi*fp2/(fs/4);
ws2=2*pi*fs2/(fs/4);

[N2,wpo2]=ellipord(wp2,ws2,rp2,rs2,'s');
[B2,A2]=ellip(N2,rp2,rs2,wpo2,'high','s');
[Bz2,Az2]=bilinear(B2,A2,1);

figure('Name','Highpass IIR ')
freqz(Bz2,Az2);



% 设计带通滤波器
% fb1=1200 fb2=3000 fc1=1000以下滤除 fc2=3200以上滤除 (Hz)
% rs3=100 rp3=1 (dB)

fb1=1200; fb2=3000; fc1=1000; fc2=3200;
rp3=1; rs3=100;


% fir1设计
b3 = fir1(N,[fb1/(fs/2) fb2/(fs/2)],'bandpass',kaiser(N+1));  

figure('Name','Bandpass FIR ');
freqz(b3);



% ellip设计

wp3 = [2*pi*fb1/(fs/4), 2*pi*fb2/(fs/4)];  
ws3 = [2*pi*fc1/(fs/4), 2*pi*fc2/(fs/4)]     %归一化


[N3,wpo3]=ellipord(wp3,ws3,rp3,rs3,'s');
[B3,A3]=ellip(N3,rp3,rs3,wpo3,'s');
[Bz3,Az3]=bilinear(B3,A3,1);

figure('Name','Bandpass IIR ');
freqz(Bz3,Az3);



% 滤波

% Lowpass FIR滤波器对信号进行滤波

fir1_audio = fftfilt(b,audio);

figure('Name','Lowpass FIR fitting');

TimeFrep_plot(t,fir1_audio,fs)


% Lowpass IIR滤波器对信号进行滤波
iir1_audio = filter(Bz1,Az1,audio);

figure('Name','Lowpass IIR fitting');

TimeFrep_plot(t,iir1_audio,fs)



% Highpass FIR滤波器对信号进行滤波

fir2_audio = fftfilt(b2,audio);

figure('Name','Highpass FIR fitting')

TimeFrep_plot(t,fir2_audio,fs)


% Highpass IIR滤波器对信号进行滤波
iir2_audio = filter(Bz2,Az2,audio);

figure('Name','Highpass IIR fitting');

TimeFrep_plot(t,iir2_audio,fs)


% Bandpass FIR滤波器对信号进行滤波

fir3_audio = fftfilt(b3,audio);

figure('Name','Bandpass FIR fitting')

TimeFrep_plot(t,fir3_audio,fs)


% Bandpass IIR滤波器对信号进行滤波

iir3_audio = filter(Bz3,Az3,audio);

figure('Name','Bandpass IIR fitting')

TimeFrep_plot(t,iir3_audio,fs)










