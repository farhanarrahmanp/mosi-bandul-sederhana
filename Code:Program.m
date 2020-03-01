clc clear all

% Load package image
pkg load image

% Parameter sistem
m = 0.3; b = 0.1; L = 0.5; g = 9.8;

% Simplifikasi
r = g/L;
k = b/(m*L);

% ODE Bandul
f=@(t,x)  [x(2);-k*x(2) - r*sin(x(1))];

% Kondisi inisial
init = [pi/2; 0];

% Solve ODE, interval waktu diset dari 0 sampai 10 detik
[t,x] = ode45(f,[0 20],init);

%% Animasi

% Origin
O = [0 0];
axis(gca,'equal'); % Aspect ratio dari plot
axis([-0.7 0.7 -0.7 0.2]); % Batas plot
grid on; # Grid mode on

% Loop animasi
for i=1:length(t)
  
  % Mass point
  P = L*[sin(x(i,1)) -cos(x(i,1))];
  
  % Circle in origin
  lingkaran = viscircles(O,0.01);
  
  % Bandul
  bandul = line([O(1) P(1)],[O(2) P(2)]);
  
  % Bola
  bola = viscircles(P,0.05);
  
  % Interval waktu update plot
  pause(0.001);
  
  % Hapus objek sebelumnya jika tidak loop final
  if i<length(t)
    delete(bandul);
    delete(bola);
    delete(lingkaran);
  end
end