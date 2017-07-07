clc

clear; close all;
warning off;

time_delay = 0.05;
axLim = [-4 4 -1 4 -10 10 ];
% hold on
% grid on
numLinks = 4;
L = repmat(Link('d', 0, 'a', 1, 'alpha', 0, 'm', .001, 'r', [-0.5, 0, 0]), numLinks, 1);
R = SerialLink(L);
% base = R.base
% R.base = trotx(pi/2)*;

R.plotopt = {'view', 'top', 'noshading', 'noname', 'ortho', ...
    'workspace', axLim, 'tile1color', [1,1,1], 'delay', time_delay, 'trail', '',...
    'noshadow', 'nobase', 'nowrist'};
axis(axLim); axis square; hold on;

InputInMM =40 % input the distance on the axis

Numberofturns_base = InputInMM/20 
Angle_base = atan(InputInMM/20)
Angle_base_radians = (pi/180)*Angle_base

base_angle   = [linspace(pi/3,2*pi/3,25), linspace(2*pi/3,pi/3,25)];
first_angle  = [linspace(-pi/3,pi/3,25), linspace(pi/3,-pi/3,25)];
second_angle = [linspace(pi/3,-pi/3,25), linspace(-pi/3,pi/3,25)];
third_angle  = [linspace(-pi/3,pi/3,25), linspace(pi/3,-pi/3,25)];

base_angle_min   = min (base_angle);
first_angle_min  = min (first_angle);
second_angle_min = min (second_angle);
third_angle_min  = min (third_angle);


pause(1)
base_angle_start   = [linspace(pi/2,base_angle_min,25)];
first_angle_start  = [linspace(0,first_angle_min,25)];
second_angle_start = [linspace(0,second_angle_min,25)];
third_angle_start  = [linspace(0,third_angle_min,25)];


R.plot([pi/2 0 0 0])
pause(1)

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'testAnimated.gif';

for j = 1:(length(base_angle)/2)
    R.plot([base_angle_start(j) -first_angle_start(j) second_angle_start(j) -third_angle_start(j)])
    
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if j == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end 
    
    %imwrite([base_angle_start(j) -first_angle_start(j) second_angle_start(j) -third_angle_start(j)],'test.gif','gif', 'Loopcount',inf);
end

