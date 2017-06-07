function [ Had ] = createHad( num_para )

	% For instances when we don't want to do the recursive matrix-vector multiplication
  Had = 1;
  for i = 1:(ceil(log2(num_para)));
    Had = [Had,Had;Had,-Had];
  end  

end

