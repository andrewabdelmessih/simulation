clc
clear; 
close all;
warning off;

time_delay = 0.05;

% hold on
% grid on
numLinks = 4;
L = repmat(Link('d', 0, 'a', 40, 'alpha', 0, 'm', .001, 'r', [-0.5, 0, 0]), numLinks, 1);
R = SerialLink(L);
axLim = [sum(R.a)*[-1 1 -1 1] -100 100];
% base = R.base
% R.base = trotx(pi/2)*;

R.plotopt = {'view', 'top', 'noshading', 'noname', 'ortho', ...
    'workspace', axLim, 'tile1color', [1,1,1], 'delay', time_delay, 'trail', '',...
    'noshadow', 'nobase', 'nowrist'};
% axis(axLim); axis square; hold on;

Base_InputInMM      = 20; % input the distance on the axis for the base module
First_InputInMM     = 20; % input the distance on the axis for the first module
Second_InputInMM    = 20; % input the distance on the axis for the second module
Third_InputInMM     = 20; % input the distance on the axis for the third module

BaseValueInMM       = Base_InputInMM;
FirstValueInMM      = First_InputInMM +  Base_InputInMM;
SecondValueInMM     = Second_InputInMM + FirstValueInMM;
ThirdValueInMM      = Third_InputInMM + SecondValueInMM;

Numberofturns_base  = BaseValueInMM/20 
Angle_base          = atan(BaseValueInMM/40)

Numberofturns_first = FirstValueInMM/20
Angle_first         = atan(FirstValueInMM/40)

Numberofturns_second= SecondValueInMM/20 
Angle_second        = atan(SecondValueInMM/40)

Numberofturns_third = ThirdValueInMM/20 
Angle_third         = atan(ThirdValueInMM/40)

base_angle          = linspace(0,Angle_base,25);
first_angle         = linspace(0,Angle_first,25);
second_angle        = linspace(0,Angle_second,25);
third_angle         = linspace(0,Angle_third,25);

base_angle_min      = min (base_angle);
first_angle_min     = min (first_angle);
second_angle_min    = min (second_angle);
third_angle_min     = min (third_angle);


h = gcf;
R.plot(zeros(1,R.n));
axis(axLim); axis square; hold on;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'testAnimated.gif';

for j = 1:(length(base_angle))
    R.plot([base_angle(j) -first_angle(j) second_angle(j) -third_angle(j)])
    
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

