**** Fiscal Consolidation and the Euro Crisis: the role of markups
****
**** Corresponding author: João Costa-Filho
**** E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao
**** Original austerity data in stata from Brinca et al. (2020) [https://onlinelibrary.wiley.com/doi/10.1111/iere.12482]

use panel.dta, clear

**Dados em painel 
xtset country year

**Arellano-Bond (nível como instrumento)

eststo: xtabond  dlngdp f_u_t f_a_t gini markup , lags(1) artests(2) vce(robust) 

*Sargan-Hansen teste de sobreidentificação
*H0: overidentifying restrictions are valid

estat sargan

**Arellano-Bover/Blundell-Bond (nível e primeira diferença como instrumentos)

eststo: xtdpdsys  dlngdp f_u_t f_a_t gini markup, lags(1) artests(2) vce(robust) 

*Sargan-Hansen teste de sobreidentificação
*H0: overidentifying restrictions are valid

estat sargan

**Ahn and Schmidt (1995) 

eststo: xtdpdgmm L(0/1). dlngdp f_u_t f_a_t gini markup, gmm(L. dlngdp f_u_t f_a_t gini markup, l(1,3) m(d)) vce(robust)

*Sargan-Hansen teste de sobreidentificação
*H0: overidentifying restrictions are valid

esttab using example.tex, label
