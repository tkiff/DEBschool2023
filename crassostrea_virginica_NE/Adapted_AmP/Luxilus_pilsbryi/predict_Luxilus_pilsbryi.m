function [prdData, info] = predict_Luxilus_pilsbryi(par, data, auxData)
  
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);

  
%% compute temperature correction factors
  TC = tempcorr(temp.am, T_ref, T_A);  kT_M = k_M * TC; 

  % life cycle
  pars_tj = [g k l_T v_Hb v_Hj v_Hp];
  [tau_j, tau_p, tau_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f);
  if info == 0
      prdData = []; return
  end
  
  % birth
  L_b = L_m * l_b;                  % cm, structural length 
  Ww_b = L_b^3 * (1 + f * w);       % g, wet weight at birth
  
  % metam
  s_M = l_j/ l_b;                   % -, acceleration factor
  
  % puberty 
  L_p = L_m * l_p;                  % cm, structural length 
  Lw_p = L_p/ del_M;                % cm, total length at puberty
  Ww_p = L_p^3 * (1 + f * w);       % g, wet weight at puberty 
  tT_p = (tau_p - tau_b)/ kT_M;     % d, time since birth at pubert

  % ultimate
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate standard length at f
  Ww_i = L_i^3 * (1 + f * w);       % g, ultimate wet weight 
  
  % reproduction
  GSI = TC * 365 * k_M * g/ f^3/ (f + kap * g * y_V_E);
  GSI = GSI * ((1 - kap) * f^3 - k_M^2 * g^2 * k_J * U_Hp/ v^2/ s_M^3); % mol E_R/ mol W
  
  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ kT_M;                     % d, mean life span at T
  
  % males
  p_Am_m = z_m * p_M/ kap;             % J/d.cm^2, {p_Am} spec assimilation flux
  E_m_m = p_Am_m/ v;                   % J/cm^3, reserve capacity [E_m]
  g_m = E_G/ (kap* E_m_m);             % -, energy investment ratio
  L_mm = v/ k_M/ g_m;                  % cm, max struct length
  pars_tjm = [g_m k l_T v_Hb v_Hj v_Hp];
  
  % pack to output
  prdData.am = aT_m;
  prdData.Lp = Lw_p;
  prdData.Li = Lw_i;
  prdData.Wwb = Ww_b;
  prdData.GSI = GSI;

  % time-length post metam
  % females
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL);
  rT_B = rho_B * kT_M; tT_j = (t_j - t_b)/ kT_M; L_j = L_m * l_j; L_i = L_m * l_i;
  L = L_i - (L_i - L_j) * exp( - rT_B * (tL_f(:,1) - tT_j)); % cm, total length
  ELw_f = L/ del_M; 
  % males
  [t_jm, t_pm, t_bm, l_jm, l_pm, l_bm, l_im, rho_jm, rho_Bm] = get_tj(pars_tjm, f_tL);
  rT_Bm = rho_Bm * kT_M; tT_jm = (t_jm - t_bm)/ kT_M; L_jm = L_mm * l_jm; L_im = L_mm * l_im;
  L = L_im - (L_im - L_jm) * exp( - rT_Bm * (tL_m(:,1) - tT_jm)); % cm, total length
  ELw_m = L/ del_M; 
  % females
  L = L_i - (L_i - L_j) * exp( - rT_B * (tWw_f(:,1) - tT_j)); % cm, total length
  EWw_f = L.^3 * (1 + f_tL * ome); % g, wet weight 
  % males
  L = L_im - (L_im - L_jm) * exp( - rT_Bm * (tWw_m(:,1) - tT_jm)); % cm, total length
  EWw_m = L.^3 * (1 + f_tL * ome); % g, wet weight 
  
  % pack to output
  prdData.tL_f = ELw_f;
  prdData.tL_m = ELw_m;
  prdData.tWw_f = EWw_f;
  prdData.tWw_m = EWw_m;

