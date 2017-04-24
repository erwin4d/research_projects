function [w1, w2 ] = read_msoft_words_li(word1, word2, option)

  w1_vec = feval('load',[word1]);
  w2_vec = feval('load',[word2]);


  if strcmp(option, 'existence')  
    % Creates 0-1 vector ; 1 if word exists in document, else 0
    w1 = zeros(1, 65536);
    w1(w1_vec(:,2) + 1) = 1;
    w1 = sparse(w1);

    w2 = zeros(1, 65536);
    w2(w2_vec(:,2) + 1) = 1;
    w2 = sparse(w2);

  end


end

