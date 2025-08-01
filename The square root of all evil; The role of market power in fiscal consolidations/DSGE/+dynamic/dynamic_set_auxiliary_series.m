function ds = dynamic_set_auxiliary_series(ds, params)
%
% Computes auxiliary variables of the dynamic model
%
ds.AUX_ENDO_LEAD_271=ds.pD(1)*ds.Y(1)*params(16)*(ds.pD(1)/ds.pD-1)*ds.P(1)*ds.pD(1)^2;
ds.AUX_ENDO_LEAD_284=ds.LMEAC(1)/ds.P(1);
ds.AUX_ENDO_LAG_11_1=ds.e(-1);
end
