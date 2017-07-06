function [small_V_EDPair1, small_V_EDPair2, small_V_IPPair1,small_V_IPPair2, small_V_eigvec, small_V_randvec ] = rpcv_v_decoder(V_struct, k, types, num_quantiles, num_eig, num_rand)
  
  if types == 1
    this_V = V_struct.V_norm;
  elseif types == 2
    this_V = V_struct.V_bin;
  elseif types == 3
    this_V = V_struct.V_SB5;
  elseif types == 4
    this_V = V_struct.V_SB10;
  elseif types == 5
    this_V = V_struct.V_SRHT;
  else
    ['no types!']
    return;
  end

  idx_start = 1:num_quantiles:(4*num_quantiles);
  idx_end = 11:num_quantiles:(4*num_quantiles);
  
  small_V_EDPair1.vmat = this_V.vmat(idx_start(1):idx_end(1),1:k);
  small_V_EDPair2.vmat = this_V.vmat(idx_start(2):idx_end(2),1:k);
  small_V_IPPair1.vmat = this_V.vmat(idx_start(3):idx_end(3),1:k);
  small_V_IPPair2.vmat = this_V.vmat(idx_start(4):idx_end(4),1:k);  


  small_V_EDPair1.rand_var = this_V.rand_var;
  small_V_EDPair1.scaling_factor = this_V.scaling_factor;
  small_V_EDPair1.signature = this_V.signature;  


  small_V_EDPair2.rand_var = this_V.rand_var;
  small_V_EDPair2.scaling_factor = this_V.scaling_factor;
  small_V_EDPair2.signature = this_V.signature;  

  small_V_IPPair1.rand_var = this_V.rand_var;
  small_V_IPPair1.scaling_factor = this_V.scaling_factor;
  small_V_IPPair1.signature = this_V.signature;  

  small_V_IPPair2.rand_var = this_V.rand_var;
  small_V_IPPair2.scaling_factor = this_V.scaling_factor;
  small_V_IPPair2.signature = this_V.signature;  

  small_V_eigvec.vmat = this_V.vmat(((4*num_quantiles)+1):((4*num_quantiles)+num_eig), 1:k);
  small_V_randvec.vmat = this_V.vmat(((4*num_quantiles)+num_eig+1):((4*num_quantiles)+num_eig+num_rand), 1:k);

  small_V_eigvec.rand_var = this_V.rand_var;
  small_V_eigvec.scaling_factor = this_V.scaling_factor;
  small_V_eigvec.signature = this_V.signature;  

  small_V_randvec.rand_var = this_V.rand_var;
  small_V_randvec.scaling_factor = this_V.scaling_factor;
  small_V_randvec.signature = this_V.signature;  



end