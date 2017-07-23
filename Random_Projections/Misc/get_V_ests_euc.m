function [ests] = get_V_ests_euc(currV, ests, kvals)

  ests.euc_dist(:,:,kvals) = (ests.v1norm(:,:,kvals) + ests.v2norm(:,:,kvals) - 2*ests.v1v2(:,:,kvals));


end
