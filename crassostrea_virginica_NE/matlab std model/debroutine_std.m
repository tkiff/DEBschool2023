%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simple std model for checking amp outputs %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Output] = debroutine_std(pars, parsim, condini, env)

  global n_O n_M dwm

%% Unpack parameters
T_ref   = pars(1);  % K,        reference temperature
T_L     = pars(2);  % K,        lower boundary tolerance range
T_H     = pars(3);  % K,        upper boundary tolerance range
T_A     = pars(4);  % K,        Arrehnius temperature
T_AL    = pars(5);  % K,        Arrehnius temperature at lower boundary of tolerance range
T_AH    = pars(6);  % K,        Arrehnius temperature at upper boundary of tolerance range
p_Am    = pars(7);  % J/d/cm^2, maximum surface-specific assimilation rate
v       = pars(8);  % cm/d,     energy conductance
kap     = pars(9);  % -,        alloaction fraction to soma
kap_X   = pars(10); % -,        assimilation efficiency
kap_X_P = pars(11); % -,        defecation efficiency
kap_R   = pars(12); % -,        reproduction efficiency
p_M     = pars(13); % J/d/cm^3, volume-specific somatic maintenance rate
k_J     = pars(14); % 1/d,      maturity maintenance rate coefficient
E_G     = pars(15); % J/cm^3,   volume-specific cost for structure
E_Hp    = pars(16); % J,        maturity at puberty
del_M   = pars(17); % -,        shape coefficient
X_K     = pars(18); % �g/L,     half saturation coefficient (�g/L)

d_V = dwm(2,1); d_E = dwm(3,1); w_V = dwm(2,2); w_E = dwm(3,2); mu_X = dwm(1,3); mu_E = dwm(3,3); mu_P = dwm(4,3);

 % Compound parameters
E_m = p_Am / v;          % J/cm^3, maximum reserve density
g   = E_G / (kap * E_m); % -,      energy investment ratio
k_M = p_M / E_G;         % 1/d,    somatic maintenance rate coefficient
L_m = v / g / k_M;       % cm,     maximum volumetric length (= z = kap * p_Am / p_M)

 % eta_O matrix for mass-energy coupling
eta_XA = 1 / (kap_X * mu_X / mu_E) / mu_E;                       % mol/J, food-assimilation energy coupler
eta_PA = (kap_X_P * mu_X / mu_P) / (kap_X * mu_X / mu_E) / mu_E; % mol/J, faeces-assimilation energy coupler
eta_VG = mu_E * (d_V / w_V) / E_G / mu_E;                        % mol/J, structure-growth energy coupler
eta_O  = [-eta_XA   0         0;                                 % mol/J, mass-energy coupler
          0         0         eta_VG;
          1 / mu_E  -1 / mu_E -1 / mu_E;
          eta_PA    0         0];

 % Unpack simulation parameters
Ti = parsim(1); % begining time
Tf = parsim(2); % end time
dt = parsim(3); % time step

 % Set initial conditions
V   = condini(1);                               % cm^3, initial structural volume
E   = condini(2);                               % J,    initial reserves
E_H = condini(3);                               % J,    initial maturity
E_R = condini(4);                               % J,    initial reproduction buffer
L   = V^(1/3);                                  % cm,   initial structural length
DW  = V * d_V + ((E + E_R) * w_E / mu_E) * d_E; % g,    initial body dry weight

 % Initate simulation
nb_step = round((Tf - Ti) / dt) + 1; % d, number of steps
time    = Ti;                        % d, set initial time

%% Integration
for j=1:nb_step % beginning of the integration loop
  
  % Current environmental conditions
  T = env(j,1) + 273.15; % K,    current temperature
  X = env(j,2);          % mg/L, current food concentration
  %f = X / (X + X_K);     % -,    functional response
  f = 1; % food considered unlimited

  % Temperature correction
  TC = exp(T_A / T_ref - T_A / T) * (1 + exp(T_AL / T_ref - T_AL / T_L) + exp(T_AH / T_H - T_AH / T_ref)) ...
       * 1 / (1 + exp(T_AL / T - T_AL / T_L) + exp(T_AH / T_H - T_AH / T));
  p_AmT = p_Am * TC; % J/d/cm^2, maximum surface-specific assimilation rate at T
  p_MT  = p_M * TC;  % J/d/cm^3, volume-specific somatic maintenance rate at T
  vT    = v * TC;    % cm/d,     energy conductance at T
  k_MT  = k_M * TC;  % 1/d,      somatic maintenance rate coefficient at T
  k_JT  = k_J * TC;  % 1/d,      maturity maintenance rate coefficient at T
  
  % Allocation fluxes
  e   = E / V / E_m;                                         % -,   scaled reserve density
  p_A = p_AmT * f * V^(2/3);                                 % J/d, assimilation flux
  p_C = E_m * (vT * V^(2/3) + k_MT * V) * (e * g) / (e + g); % J/d, mobilisation flux
  p_S = p_MT * V;                                            % J/d, somatic maintenance flux
  p_G = max(0,kap * p_C - p_S);                              % J/d, growth flux
  p_J = E_H * k_JT;                                          % J/d, maturity maintenance flux
  if E_H < E_Hp
     p_H = max(0,(1 - kap) * p_C - p_J);                     % J/d, maturation flux
     p_R = 0;                                                % J/d, reproduction buffer flux
  else
     p_H = 0;                                                % J/d, maturation flux
     p_R = max(0,(1 - kap) * p_C - p_J) * kap_R;             % J/d, reproduction buffer flux
  end
  p_D = p_S + p_J + p_H + (1 - kap_R) * p_R;                 % J/d, dissipation flux
  
  % Mineral fluxes from scaled powers
  l      = L / L_m;                                       % cm,        scaled structural length
  u_Hp   = E_Hp / (g * E_m * L_m^3);                      % -,         scaled maturity at puberty
  p_s    = kap * l^3;                                     % J/d,       scaled somatic maintenance
  p_j    = k_J / k_MT * u_Hp;                             % J/d,       scaled maturity maintenance
  p_r    = (1 - kap) * e * l^2 * (g + l) / (g + e) - p_j; % J/d,       scaled reproduction flux
  p_a    = f * l^2;                                       % J/d,       scaled assimilation flux
  p_d    = p_s + p_j + (1 - kap_R) * p_r;                 % J/d,       scaled dissipation flux
  p_g    = kap * l^2 * (e - l) / (1 + e / g);             % J/d,       scaled growth flux
  pT_ref = p_AmT * L_m^2;                                 % J/d,       reference power (scaling)
  pADGs  = pT_ref * [p_a, p_d, p_g];                      % J/d,       scaled powers
  J_M    = (n_M \ n_O) * eta_O * pADGs';                  % mol/d,     J_C, J_H, J_O, J_N in rows
  
  J_OmL  = J_M(3,:)' * 22.4e3 / 24 / DW;                  % mLO2/h/g,  O2 consumption (22.4 L/mol)
  J_Omg  = J_M(3,:)' * 32e3 / 24 / DW;                    % mgO2/h/g,  O2 consumption (32 g/mol)
  J_N    = J_M(4,:)' * 18e6 / 24 / DW;                    % �gNH4/h/g, NH4 production (18 g/mol)

  % Lysis and shrinking
  shrink_M = max(0,p_S - kap * p_C);           % J/d, deficit in somatic maintenance
  shrink_J = max(0,p_J - (1 - kap) * p_C);     % J/d, deficit in maturity maintenance
  shrink   = shrink_M + shrink_J;              % J/d, total deficit in maintenance
  p_R_M    = min(shrink, p_R * kap_R);         % J/d, re-allocate p_R to maintenance
  p_L_R    = min(shrink - p_R_M, E_R * kap_R); % J/d, reproduction buffer resorption rate
  p_L_V    = max(0,shrink - p_R_M - p_L_R);    % J/d, lysis of structure rate
  
  % Compute length and weight
  L   = V^(1/3);                                  % cm, structural length
  L_w = L / del_M;                                % cm, physical length
  WW  = V + ((E + E_R) * w_E / mu_E);             % g,  body wet weight
  DW  = V * d_V + ((E + E_R) * w_E / mu_E) * d_E; % g,  body dry weight

  % Differential equations of state variables
  dVdt   = p_G / E_G - p_L_V;
  dEdt   = p_A - p_C;
  dE_Hdt = p_H;
  dE_Rdt = p_R - p_R_M - p_L_R;
  
  % Stock state variables before integration
  Timet(j) = time;   %  1
  Tt(j)    = T;      %  2
  Xt(j)    = X;      %  3
  TCt(j)   = TC;     %  4
  ft(j)    = f;      %  5
  Vt(j)    = V;      %  6
  Et(j)    = E;      %  7
  E_Ht(j)  = E_H;    %  8
  E_Rt(j)  = E_R;    %  9
  L_wt(j)  = L_w;    % 10
  WWt(j)   = WW;     % 11
  DWt(j)   = DW;     % 12
  pAt(j)   = p_A;    % 13
  pCt(j)   = p_C;    % 14
  pSt(j)   = p_S;    % 15
  pGt(j)   = p_G;    % 16
  pJt(j)   = p_J;    % 17
  pHt(j)   = p_H;    % 18
  pRt(j)   = p_R;    % 19
  pDt(j)   = p_D;    % 20
  skt(j)   = shrink; % 21
  JOmLt(j) = J_OmL;  % 22
  JOmgt(j) = J_Omg;  % 23
  JNt(j)   = J_N;    % 24
  
  % Integration
  V    = max(0,V + dVdt * dt);     % structure
  E    = max(0,E + dEdt * dt);     % reserves
  E_H  = max(0,E_H + dE_Hdt * dt); % maturity
  E_R  = max(0,E_R + dE_Rdt * dt); % reproduction buffer
  time = time + dt;
  
end % End of the integration loop

%% Pack OUTPUT
Output = [Timet' Tt' Xt' TCt' ft' Vt' Et' E_Ht' E_Rt' L_wt' WWt' DWt' ...
          pAt' pCt' pSt' pGt' pJt' pHt' pRt' pDt' skt' JOmLt' JOmgt' JNt'];

