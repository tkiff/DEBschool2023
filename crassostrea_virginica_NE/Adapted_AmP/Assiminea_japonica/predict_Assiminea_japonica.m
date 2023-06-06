function [prdData, info] = predict_Assiminea_japonica(par, data, auxData)

% unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);
  
  if tL(:,1) < t_0
    info = 0; prdData = []; return
  end
  
  % compute temperature correction factors
  TC = tempcorr(temp.am, T_ref, T_A);
  
  % zero-variate data

  % life cycle
  pars_tj = [g k l_T v_Hb v_Hj v_Hp];
  [tau_j, tau_p, tau_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f);
  
  % birth
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  Ww_b = L_b^3 * (1 + f * ome);     % g, wet weight at birth at f
    
  % puberty 
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = L_p/ del_M;                % cm, total length at puberty at f

  % ultimate
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate total length at f
 
  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb;U_Hj;  U_Hp]; % compose parameter vector at T
  RT_i = TC * reprod_rate_j(L_i, f, pars_R);                % #/d, ultimate reproduction rate at T
  
  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ k_M/ TC;                  % d, mean life span at T
  
  % pack to output
  prdData.am = aT_m;
  prdData.Lp = Lw_p;
  prdData.Li = Lw_i;
  prdData.Wwb = Ww_b;
  prdData.Ri = RT_i;
  
  % uni-variate data
  
  % time-length post metam 
  [tau_j, tau_p, tau_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL);
  r_B = rho_B * k_M; 
  L_j = l_j * L_m;
  L_i = l_i * L_m;
  
  [t, L] = ode45(@get_L, [0;tL(:,1) - t_0], L_j, [], L_i, r_B, T_ref, T_A);
  L(1) = []; 
  ELw = L/del_M; % cm, shell length
  %
  [t, L] = ode45(@get_L, [0; tWd(:,1) - t_0], L_j, [], L_i, r_B, T_ref, T_A);
  L(1) = []; 
  EWd = L.^3 * (1 + f_tL * ome) * 1e3; % mg, AFDW


  % pack to output
  prdData.tL = ELw;
  prdData.tWd = EWd;
end

function dL = get_L(t, L, L_i, r_B, T_ref, T_A)
  TC = tempcorr(C2K(17+14*sin(2*pi*(t-60)/365)), T_ref, T_A);
  dL = TC * r_B * (L_i - L);
end
