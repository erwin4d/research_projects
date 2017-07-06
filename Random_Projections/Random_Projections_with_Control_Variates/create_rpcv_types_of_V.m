function [bigV] = create_rpcv_types_of_V( EDInfo, IPInfo, eig_vecs, rand_vecs, num_para, k_max, num_mats, Had)

  % Initialize them:
  EDPair1 = EDInfo.pair1;
  EDPair2 = EDInfo.pair2;

  IPPair1 = IPInfo.pair1;
  IPPair2 = IPInfo.pair2;

  X = [EDPair1 ; EDPair2 ;IPPair1 ; IPPair2 ; eig_vecs ; rand_vecs ];

  V_norm = gen_typeof_V(X, k_max, 'option', 'normal');
  V_bin = gen_typeof_V(X, k_max, 'option', 'binary');
  V_SB5 = gen_typeof_V(X, k_max, 'option', 'SB', 'opt_para', 5);
  V_SB10 = gen_typeof_V(X, k_max, 'option', 'SB', 'opt_para', 10);
  V_SRHT = gen_typeof_V(X, k_max, 'option', 'SRHT', 'opt_para', Had);

  bigV.V_norm = V_norm;
  bigV.V_bin = V_bin;
  bigV.V_SB5 = V_SB5;
  bigV.V_SB10 = V_SB10;
  bigV.V_SRHT = V_SRHT;



end

