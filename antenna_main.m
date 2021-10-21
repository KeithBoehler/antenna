% This models the 436 CP16 antenna .
% Parameter : Datasheet / Model
% Gain : 13.3 dBic / 13.3 dBi
% Front -to - back : 15 dB / 16.6 dB
 % HPBW : 42.0 / 48.0
d1 = dipole ('Length' ,12.625*.0254 , 'Width' , cylinder2strip((3/32)*.0254) ,...
'Tilt' ,90,'TiltAxis' ,[0 1 0]);
d2 = dipole ('Length' ,12.250*.0254 , 'Width', cylinder2strip((3/32)*.0254),...
 'Tilt' ,90,'TiltAxis' ,[0 1 0]);
d3 = dipole ('Length',11.937*.0254 , 'Width', cylinder2strip((3/32)*.0254),...
'Tilt' ,90,'TiltAxis' ,[0 1 0]);
d4 = dipole ('Length' ,11.750*.0254 , 'Width', cylinder2strip((3/32)*.0254),...
 'Tilt' ,90,'TiltAxis' ,[0 1 0]);
d5 = dipole ('Length' ,11.531*.0254 , 'Width', cylinder2strip((3/32)*.0254),...
'Tilt' ,90,'TiltAxis' ,[0 1 0]);
d6 = dipole ('Length',11.375*.0254 , 'Width', cylinder2strip((3/32)*.0254),...
'Tilt',90,'TiltAxis' ,[0 1 0]);
r = dipole ('Length' ,13.687*.0254 , 'Width', cylinder2strip((3/32)*.0254),...
'Tilt' ,90,'TiltAxis' ,[0 1 0]);
dip=dipole('Length',13.625*0.0254,'Width',cylinder2strip((3/32)*0.0254),...
'Tilt',90,'TiltAxis' ,[0 1 0]) ;
uhf = quadCustom('Exciter',dip,...
'Director', {d1 d2 d3 d4 d5 d6 } ,...
'DirectorSpacing', [(17 -14.562) (23.313 -17) (31.875 -23.313)...
(41.813 -31.875) (51.563 -41.813) (61 -51.563)].*0.0254 ,...
'Reflector' ,{r} ,...
'ReflectorSpacing', 2.562*0.0254 ,...
'BoomLength', 65.75*0.0254 ,...
'BoomWidth', cylinder2strip((1/2)*0.0254) ,...
'BoomOffset' ,[0 0.005 (65.75/2 -14.562)*0.0254] ,...
'Tilt' ,90 ,...
'TiltAxis' ,[0 1 0]);
%%%%%%%%%%%%%%%%%%%%%%%%
% Reading in out paramonte stuff
pmlibRootDir = "/home/keithnator3000/src/ASTROSOFT/paramonte";
addpath(genpath(pmlibRootDir));

pm = paramonte();
pmpd = pm.ParaDRAM();

%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% pattern(uhf ,436e6)
% 
% figure
% patternAzimuth (uhf ,436e6);
% 
% figure
% show (uhf)

fc =435e6; % For UHF = 435e6 , f o r VHF = 146 e6
c = physconst ('LightSpeed');
ant = uhf;
lb = c/fc; % The lambda 

K = [1:20];

% = [A1x, A2x, ..., Anx]
x = [0, lb, lb, lb, lb, lb, lb, lb, lb, lb,lb, lb, lb, lb, lb, lb, lb, lb, 0, lb];
y = [0, lb, lb, lb, lb, 0, lb, lb, lb, lb, lb, lb, lb, lb, lb, lb, lb, lb, lb, lb];
z = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

x = K .* x;
y = K .* y;
z = K .* z;

elempos = [x; y; z];

% Create an arbitrary array which takes i n custom coordinates .
arbitrary = phased.ConformalArray(...
'ElementPosition', elempos,...
'ElementNormal', [0;90] ,...
'Element',ant);

% View the array elements by uncommenting below .
figure
viewArray (arbitrary ,'showNormals',true ,'ShowIndex','All')

% Look at the overall array ’s beam pattern .
figure
pattern (arbitrary,fc);
% 
% pattern(arbitrary,fc,'PropagationSpeed',c,'Type','powerdb',...
%     'CoordinateSystem','uv');
% 
% pattern(arbitrary,fc,-1:0.01:1,0,'PropagationSpeed',c, ...
%     'CoordinateSystem','UV','Type','powerdb')
% axis([-1 1 -50 0]);

% Show an azimuthal cut of the array ’s beam pattern .
% figure
% patternAzimuth(arbitrary,fc)

% Show an elevation cut of the array ’s beam pattern .
% figure
% patternElevation(arbitrary,fc ,'Elevation' , -90:0.01:90) ;
