function [currV] = get_V_mats_given_k(currV, para, kvals)
  
  currV.small_V1 = currV.V1(:, para.kidx(kvals,1):para.kidx(kvals,2));
  currV.small_V2 = currV.V2(:, para.kidx(kvals,1):para.kidx(kvals,2));

end