function [ IP_vals ] = cardano_fn(ests)

  v1v2_mat = ests.small_v1v2;
  v1norm_mat = ests.small_v1norm;
  v2norm_mat = ests.small_v2norm;
  m1_mat = ones(ests.n1,ests.n2);
  m2_mat = ones(ests.n1,ests.n2);
  m1m2_mat = ones(ests.n1,ests.n2);
  
  a = 1;
  b = -v1v2_mat;
  c = - m1m2_mat + m1_mat .* v2norm_mat + m2_mat .* v1norm_mat;
  d = - m1m2_mat .* v1v2_mat;

  
  discr = 18*b .* c .*d - 4* b.^3 .* d + b.^2 .* c.^2 - 4 * a .* c.^3  - 27 * a.^2 .* d.^2;
  
  delta0 = b.^2 - 3 * a .* c;
  delta1 = 2 * b.^3 - 9 * a .* b .* c + 27 * a.^2 .* d.^2;
  
  C = -nthroot((delta1 + sqrt(-27 * a.^2 .* discr))/2,3);
  
  IP_vals = -1./(3*a) * (b + C + delta0 ./C);

end

