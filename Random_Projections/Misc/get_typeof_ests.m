function [val_req] = get_typeof_ests(ests, typeof, funtype)

  % Get typeof ests

  if strcmp(typeof, 'ordinary_IP')
    val_req = ests.v1v2;
  elseif strcmp(typeof, 'li_mle')
    val_req = li_vectorized_NR(ests);
  elseif strcmp(funtype, 'bivar_cv')
  	val_req = get_bivar_control_var(ests, typeof);
  end


end
      
  