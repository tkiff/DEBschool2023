%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          %
%     % Run DEB model %    %
%                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   global n_O n_M dwm

%% Parameters

% Parameter for the std model
% p_AM and p_M multiplied by acceleration factor

 % Temperature correction parameters
T_ref = 273 + 20; %  1 K, reference temperature
T_L   = 273 + 10;  %  2 K, lower boundary tolerance range
T_H   = 273 + 30; %  3 K, upper boundary tolerance range
T_A   = 4559;     %  4 K, Arrehnius temperature
T_AL  = 21820;    %  5 K, Arrehnius temperature at lower boundary of tolerance range
T_AH  = 45380;    %  6 K, Arrehnius temperature at upper boundary of tolerance range
 % Primary parameters (Crassostrea virginica - kiffney 2023)
p_Am    = 11.43 * 	3.85925  ;%  7 J/d/cm^2, maximum surface-specific assimilation rate
v       = 0.022 * 	3.85925 ; %  8 cm/d,     energy conductance
kap     = 0.68;   %  9 -,        alloaction fraction to soma
kap_X   = 0.8;   % 10 -,        assimilation efficiency
kap_X_P = 0.1;    % 11 -,        defecation efficiency
kap_R   = 0.95;   % 12 -,        reproduction efficiency
p_M     = 4.17;   % 13 J/d/cm^3, volume-specific somatic maintenance rate
k_J     = 0.00054; % 14 1/d,      maturity maintenance rate coefficient
E_G     = 2315;   % 15 J/cm^3,   volume-specific cost for structure
E_Hp    = 974 ;    % 16 J,        maturity at puberty

del_M   = 0.29;  % 17 -,        shape coefficient
 % Additional parameters
X_K = 1e4; % 18 µg/L, half-saturation coefficient
% forod considered unlimited

 % Chemical conversion coefficients parameters
%       C H O N
n_M  = [1 0 0 0;  % C/C
        0 2 0 3;  % H/C
        2 1 2 0;  % O/C
        0 0 0 1]; % N/C
%        X     V     E     P
n_O  = [1.00 1.00 1.00 1.00;  % C/C
        1.80 1.80 1.80 1.80;  % H/C
        0.50 0.50 0.50 0.50;  % O/C
        0.15 0.15 0.15 0.15]; % N/C
d_O  = [0.2 0.2 0.2 0.2]';      % g/cm^3, specific densities for organics
w_O  = n_O' * [12; 1; 16; 14];      % g/mol,  molecular weights for organics
mu_O = [525  500  550  480]' * 1e3; % J/mol,  chemical potentials for organics

 % Pack parameters
pars = [T_ref T_L T_H T_A T_AL T_AH p_Am v kap kap_X kap_X_P kap_R p_M k_J E_G E_Hp del_M X_K];
dwm  = [d_O, w_O, mu_O];

%% Initial conditions

Li   = 3;                    % cm,   initial physical length
Vi   = (Li * del_M)^3;       % cm^3, initial structural volume
ei   = 0.8;                % -,    initial scaled reserve - how to calculate this?
Ei   = ei * p_Am / v * Vi; % J,    initial reserve
E_Hi = E_Hp;                 % J,    initial maturity
E_Ri = 0;                    % J,    initial reproduction buffer
condini = [Vi Ei E_Hi E_Ri]; % pack initial conditions

% Maine conditions
% Li   = 4.306;                % cm,   initial physical length
% Vi   = (Li * del_M)^3;       % cm^3, initial structural volume
% ei   = 0.8;                  % -,    initial scaled reserve - how to calculate this?
% Ei   = ei * p_Am / v * Vi;   % J,    initial reserve
% E_Hi = E_Hp;                 % J,    initial maturity
% E_Ri = 0;                    % J,    initial reproduction buffer
% condini = [Vi Ei E_Hi E_Ri]; % pack initial conditions

%% DMC data

dmcEnv = readtable('DMC_env.csv');

%% Simulation parameters

% dt     = 1;   % d, time step
% Ti     = 1;   % d, start
% Tf     = height(dmcEnv); % d, end - length of DMC env data
% tT     = (Ti:dt:Tf+dt);
% parsim = [Ti Tf dt];

dt     = 1;   % d, time step
Ti     = 1;   % d, start
Tf     = 120; % d, end
tT     = (Ti:dt:Tf+dt);
parsim = [Ti Tf dt];

%% Environmental consitions

T = repmat(14,Tf,1);  % °C,   temperature
X = repmat(1e6,Tf,1); % µg/L, chlorophyll-a concentration
env = [T X];

% T = dmcEnv(:, 'meanTemp');
% X = dmcEnv(:, 'meanChl'); % µg/L, chlorophyll-a concentration
% env = [T X];
% 
% env = table2array(env);

T = repmat(20,Tf,1);  % °C,   temperature
X = repmat(1e6,Tf,1); % µg/L, chlorophyll-a concentration

%% Run the model

Results = debroutine_std(pars, parsim, condini, env);

%% Plots
% figure(1)
% subplot(2,2,1)
% plot(Results(:,1), Results(:,2)-273.15)
% title('T')
% subplot(2,2,2)
% plot(Results(:,1), Results(:,3))
% title('X')
% subplot(2,2,3)
% plot(Results(:,1), Results(:,5))
% ylim([0 1])
% title('f')

figure(2)
subplot(2,3,1)
plot(Results(:,1), Results(:,10))
xlabel('d'); ylabel('Shell length (cm)')
subplot(2,3,2)
plot(Results(:,1), Results(:,12))
xlabel('d'); ylabel('DW (g)'); title('Std model (high f)')
subplot(2,3,3)
plot(Results(:,1), Results(:,21))
xlabel('d'); ylabel('Shrink (J/d)')
subplot(2,3,4)
plot(Results(:,1), Results(:,13), Results(:,1), Results(:,14), Results(:,1), Results(:,20))
legend('p_A','p_C','p_D','location','north'); xlabel('d'); ylabel('J/d')
subplot(2,3,5)
plot(Results(:,1), Results(:,15), Results(:,1), Results(:,16))
legend('p_S','p_G','location','north'); xlabel('d'); ylabel('J/d')
subplot(2,3,6)
plot(Results(:,1), Results(:,23))
xlabel('d'); ylabel('J_O (mg_{O_2}/h)')

%% export results
    
names = ["Timet" "Tt" "Xt" "TCt" "ft" "Vt" "Et" "E_Ht" "E_Rt" "L_wt" "WWt" "DWt" ...
         "pAt" "pCt" "pSt" "pGt" "pJt" "pHt" "pRt" "pDt" "skt" "JOmLt" "JOmgt" "JNt"];

out = [names; num2cell(Results)];
out = cellstr(out);
% Write the table to a CSV file
writecell(out,'exportMatlabResults.csv')

