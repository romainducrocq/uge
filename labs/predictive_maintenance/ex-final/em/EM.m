function EM(n)
  pkg("load", "statistics");
  
  %% Initialization
  [systems, t, failures] = Initialization();
  lambdas = zeros(n+1, 1);
  lambdas(1, 1) = getLambda(systems, t, failures);
  
  for i = 1:n
    %%Expectation 
    fexp = zeros((systems - sum(failures)), 1);
    for j = 1:size(fexp, 1)
      while fexp(j, 1) <= max(t)
        fexp(j, 1) = - log(exprnd(lambdas(i, 1))/lambdas(i, 1)) / lambdas(i, 1);
      endwhile
    endfor

    %%Maximization
    lambdas(i+1, 1) = getLambda(systems, [t; sort(fexp)], [failures; ones(size(fexp, 1), 1)]);
  endfor
  
  Plot(n, lambdas);
endfunction

function [systems, t, failures] = Initialization()
  systems = 500;
  t = [0.5; 1; 1.5; 2; 3; 4; 5; 6; 7; 8; 9; 10];
  failures = [31; 29; 27; 26; 46; 41; 36; 32; 28; 24; 22; 19];
endfunction

function lambda = getLambda(systems, t, failures)
  uptime = sum(t .* failures) + (systems - sum(failures)) * (t(size(t,1)) + 1);
  mtbf = uptime / systems;
  lambda = 1 / mtbf;
endfunction

function Plot(n, lambdas)
  plot(linspace(0, n, n+1)', lambdas, '-rx', 'MarkerSize', 10);
  ylabel('Lambdas');
  xlabel(sprintf('Iterations of the EM algorithm [0-%i]', n));
  
  for i = 1:n+1
    printf("it #%i: lambda = %i \n", i-1, lambdas(i));
  endfor
endfunction
