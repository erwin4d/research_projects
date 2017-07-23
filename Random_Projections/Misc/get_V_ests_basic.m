function [ests] = get_V_ests_basic(currV, ests, kvals)

  n1 = size(currV.small_V1,1);
  n2 = size(currV.small_V2,1);

  ests.v1norm(:,:,kvals) = repmat(sum(currV.small_V1.^2,2) ,1,n2);
  ests.v2norm(:,:,kvals) = repmat(sum(currV.small_V2.^2,2)' ,n1,1);
  ests.v1v2(:,:,kvals)= currV.small_V1 * currV.small_V2';

  ests.n1 = n1;
  ests.n2 = n2;


end
