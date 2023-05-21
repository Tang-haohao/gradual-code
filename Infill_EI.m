function EI = Infill_EI(x,GP_model,fmin)
% get the Kriging prediction and variance
[u,s] = GP_Predictor(x,GP_model);
% calcuate the EI value
EI = (fmin-u).*normcdf((fmin-u)./s)+s.*normpdf((fmin-u)./s);

end





