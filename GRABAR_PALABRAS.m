%                   RECONOCIMIENTO DE VOZ
%                  UNIVERSIDAD DE PAMPLONA
%                   CRISTIAN CASTRO RIOS
clc
clear all
close all

grabar = input('Para grabar Carro digite 1, para Navidad digite 2 y para Lunes digite 3: ');


t = 2;                   %tiempo de grabacion
Fs = 44100;              %frecuencia de muestreo
v = audiorecorder(Fs,24,1); %configuracion del canal
disp ('INICIO DE LA GRABACION')
recordblocking(v,t);  %ajuste de grabacion sobre el objeto
disp('FIN DE LA GRABACION')
audiograbado= getaudiodata(v,'single');  %vector de audio capturado
sound(audiograbado, Fs);
figure(1);
plot(audiograbado);
title('SENAL EN TIEMPO CONTINUO DE LA VOZ GRABADA');
voz = audiograbado; 

if(grabar == 1)
    audiowrite('carro.wav',audiograbado,Fs);
    car = audioread('carro.wav');
    
    %Normalización de la señal
    maximo = max(abs(car));
    n = length(car);
    for i = 1:n
        normcar(i) = car(i)/maximo;
    end
    fftcar = abs(fft(normcar));
    figure(2)
    subplot(2,1,1),plot(normcar,'r');title('NORM CARRO');
    subplot(2,1,2),plot(fftcar,'r');title('TF CARRO');
end

if(grabar == 2)
    audiowrite('Navidad.wav',audiograbado,Fs);
    nav = audioread('Navidad.wav');
    
    %Normalización de la señal
    maximo = max(abs(nav));
    n = length(nav);
    for i = 1:n
        normv(i) = nav(i)/maximo;
    end
    fftnav = abs(fft(normv));
    figure(2)
    subplot(2,1,1),plot(normv,'r');title('NORM NAVIDAD');
    subplot(2,1,2),plot(fftnav,'r');title('TF NAVIDAD');
end

if(grabar == 3)
    audiowrite('lunes.wav',audiograbado,Fs);
    lun = audioread('lunes.wav');
    
    %Normalización de la señal
    maximo = max(abs(lun));
    n = length(lun);
    for i = 1:n
        norml(i) = lun(i)/maximo;
    end
    fftlun = abs(fft(norml));
    figure(2)
    subplot(2,1,1),plot(norml,'r');title('NORM LUNES');
    subplot(2,1,2),plot(fftlun,'r');title('TF LUNES');
end


