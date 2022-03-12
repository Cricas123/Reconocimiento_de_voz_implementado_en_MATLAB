%                   RECONOCIMIENTO DE VOZ
%                  UNIVERSIDAD DE PAMPLONA
%                   CRISTIAN CASTRO RIOS

clc
clear all
close all

% PALABRAS 
carro = audioread('carro.wav');
nav = audioread('Navidad.wav');
lun = audioread('lunes.wav');

a = [0.1 -0.95];
b = [1 -0.99];

%CARRO
carro = filter(a,b,carro);
maxcar = max(abs(carro));
n = length(carro);
for i = 1:n
    normcar(i) = carro(i)/maxcar;
end
fftcarro= abs(fft(normcar));
fftcarro = fftcarro.*conj(fftcarro);

%NAVIDAD
nav = filter(a,b,nav);
maxnav = max(abs(nav));
n = length(nav);
for i = 1:n
    normnav(i) = nav(i)/maxnav;
end
fftnav= abs(fft(normnav));
fftnav = fftnav.*conj(fftnav);


%LUNES
lun = filter(a,b,lun);
maxlun = max(abs(lun));
n = length(lun);
for i = 1:n
    norml(i) = lun(i)/maxlun;
end
fftlun = abs(fft(norml));
fftlun = fftlun.*conj(fftlun);

% GRABACION DE LA VOZ A RECONOCER
t = 2;                   %tiempo de grabacion
Fs = 44100;              %frecuencia de muestreo
v = audiorecorder(Fs,24,1); %configuracion del canal
disp ('INICIO DE LA GRABACION')
recordblocking(v,t);  %ajuste de grabacion sobre el objeto
disp('FIN DE LA GRABACION')
audiograbado = getaudiodata(v,'single');   %vector de audio capturado
sound(audiograbado,Fs);

% NORMALIZACION DE LA PALABRA GRABADA
audiograbado = filter(a,b,audiograbado);
maxin = max(abs(audiograbado));
n = length(audiograbado);
for i = 1:n
    x(i) = audiograbado(i)/maxin;
end
transff= abs(fft(x)); %transformada de fourier en una dimension
transff = transff.*conj(transff);

figure(1);
subplot(3,4,1),plot(carro), title('Señal de Carro');
subplot(3,4,2),plot(nav), title('Señal de Navidad');
subplot(3,4,3),plot(lun), title('Señal de Lunes');
subplot(3,4,4),plot(fftcarro), title('FFT de Carro');
subplot(3,4,5),plot(fftnav), title('FFT de Navidad');
subplot(3,4,6),plot(fftlun), title('FFT de Lunes');
subplot(3,4,7),plot(audiograbado), title('Señal entrante');
subplot(3,4,8),plot(transff), title('FFT de Señal Entrante');

corrca = corr2(transff,fftcarro); 
corrbi = corr2(transff,fftnav);
correl = corr2(transff,fftlun);

if(corrca > corrbi && corrca > correl)
    disp('La palabra mencionada es CARRO');
end
if(corrbi > corrca && corrbi > correl)
    disp('La palabra mencionada es NAVIDAD');
end
if(correl > corrbi && correl > corrca)
    disp('La palabra mencionada es LUNES');
end

