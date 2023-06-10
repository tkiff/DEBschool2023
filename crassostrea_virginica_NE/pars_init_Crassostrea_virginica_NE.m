function [par, metaPar, txtPar] = pars_init_Crassostrea_virginica_NE(metaData)

metaPar.model = 'abj'; 

%% reference parameter (not to be changed) 
par.T_ref = 293.15;   free.T_ref = 0;   units.T_ref = 'K';        label.T_ref = 'Reference temperature'; 

%% core primary parameters 

par.z = 1.8681;       free.z     = 1;   units.z = '-';            label.z = 'z'; 
par.F_m = 32.0063;    free.F_m   = 1;   units.F_m = 'l/d.cm^2';   label.F_m = '{F_M}'; 
% allow F_m to move when cr data is included
par.kap_X = 0.8;      free.kap_X = 0;   units.kap_X = '-';        label.kap_X = 'kap_X'; 
par.kap_P = 0.1;      free.kap_P = 0;   units.kap_P = '-';        label.kap_P = 'kap_P'; 
par.v = 0.021986;     free.v     = 1;   units.v = 'cm/d';         label.v = 'v'; 
par.kap = 0.68103;    free.kap   = 1;   units.kap = '-';          label.kap = 'kap'; 
par.kap_R = 0.95;     free.kap_R = 0;   units.kap_R = '-';        label.kap_R = 'kap_R'; 
par.p_M = 25;         free.p_M   = 0;   units.p_M = 'J/d.cm^3';   label.p_M = '[p_M]'; 
par.p_T = 0;          free.p_T   = 0;   units.p_T = 'J/d.cm^2';   label.p_T = '{p_T}'; 
par.k_J = 0.002;      free.k_J   = 0;   units.k_J = '1/d';        label.k_J = 'k_J'; 
par.E_G = 2315.0631;  free.E_G   = 1;   units.E_G = 'J/cm^3';     label.E_G = '[E_G]'; 
par.E_Hb = 1.248e-03; free.E_Hb  = 1;   units.E_Hb = 'J';         label.E_Hb = 'E_Hb'; 
par.E_Hj = 7.197e-02; free.E_Hj  = 1;   units.E_Hj = 'J';         label.E_Hj = 'E_Hj'; 
par.E_Hp = 9.740e+02; free.E_Hp  = 1;   units.E_Hp = 'J';         label.E_Hp = 'E_Hp'; 
par.h_a = 9.487e-10;  free.h_a   = 1;   units.h_a = '1/d^2';      label.h_a = 'h_a'; 
par.s_G = 0.0001;     free.s_G   = 0;   units.s_G = '-';          label.s_G = 's_G'; 

%% other parameters 

% Temperature parameters
par.T_A  = 6700;   free.T_A  = 0;   units.T_A  = 'K'; label.T_A  = 'Arrhenius temperature';
par.T_AH = 45380; free.T_AH  = 0;   units.T_AH = 'K'; label.T_AH = 'Arrhenius temperature above the upper boundary'; 
par.T_AL = 21820; free.T_AL  = 0;   units.T_AL = 'K'; label.T_AL = 'Arrhenius temperature below the lower boundary'; 
par.T_H  = 303;    free.T_H  = 0;   units.T_H  = 'K'; label.T_H  = 'upper boundary tolerance range'; 
par.T_L  = 283;    free.T_L  = 0;   units.T_L  = 'K'; label.T_L  = 'lower boundary tolerance range';

par.del_Mb           = 1.2722;  free.del_Mb         = 1; units.del_Mb         = '-'; label.del_Mb = 'del_Mb'; 
par.del_Mj           = 0.22   ; free.del_Mj         = 0; units.del_Mj         = '-'; label.del_Mj = 'del_Mj'; 
par.f                = 1;       free.f              = 0; units.f              = '-'; label.f = 'scaled functional response for 0-var data'; 
par.f_Kiff2022       = 0.9;     free.f_Kiff2022     = 1; units.f_Kiff2022     = '-'; label.f_Kiff2022 = 'scaled functional response for f_Kiff2022 data'; 
par.f_GrizWard2017   = 1;       free.f_GrizWard2017 = 1; units.f_GrizWard2017 = '-'; label.f_GrizWard2017 = 'scaled functional response for GrizWard2017 data'; 
par.f_KraeFord2007   = 0.74469; free.f_KraeFord2007 = 1; units.f_KraeFord2007 = '-'; label.f_KraeFord2007 = 'scaled functional response for KraeFord2007 data'; 
par.f_1              = 1;       free.f_1            = 1; units.f_1            = '-'; label.f_1 = 'scaled func response for flume 1 in RheaRice1996';
par.f_2              = 0.9;     free.f_2            = 1; units.f_2            = '-'; label.f_2 = 'scaled func response for flume 2 in RheaRice1996';
par.f_3              = 0.8;     free.f_3            = 1; units.f_3            = '-'; label.f_3 = 'scaled func response for flume 3 in RheaRice1996';
par.f_4              = 0.7;     free.f_4            = 1; units.f_4            = '-'; label.f_4 = 'scaled func response for flume 4 in RheaRice1996';

par.f_tL1_Davi1999   = 0.5;     free.f_tL1_Davi1999 = 1; units.f_tL1_Davi1999 = '-'; label.f_tL1_Davi1999   = 'scaled functional response for Davis upper DRE';
par.f_tL2_Davi1999   = 0.6;     free.f_tL2_Davi1999 = 1; units.f_tL2_Davi1999 = '-'; label.f_tL2_Davi1999   = 'scaled functional response for Davis DMC';
par.f_LeviDoal2013   = 1;       free.f_LeviDoal2013 = 1; units.f_LeviDoal2013 = '-'; label.f_LeviDoal2013   = 'scaled functional response for LeviDoal2013';

% Inital size for davis data
par.Lw0_f             = 42.9/10; free.Lw0_f             = 0; units.Lw0_f             = 'cm'; label.Lw0_f             = 'initial shell height for RheaRice1996 tL data';
par.Lw_0_davi1999     = 0.595;   free.Lw_0_davi1999     = 0; units.Lw_0_davi1999     = 'cm'; label.Lw_0_davi1999     = 'initial shell height for davi1999 tL data'; 
par.Wd_0_LeviDoal2013 = 0.29;    free.Wd_0_LeviDoal2013 = 0; units.Wd_0_LeviDoal2013 = 'g';  label.Wd_0_LeviDoal2013 = 'initial dry tissue weight for LeviDoal2013 tWd data';


%% set chemical parameters from Kooy2010 
[par, units, label, free] = addchem(par, units, label, free, metaData.phylum, metaData.class); 

%% Pack output: 
txtPar.units = units; txtPar.label = label; par.free = free; 
