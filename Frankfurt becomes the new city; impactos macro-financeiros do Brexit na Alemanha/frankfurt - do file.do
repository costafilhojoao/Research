***Frankfurt becomes the new city: impactos macro-financeiros do BrexitBrexit sobre a Alemanha
***Thais Palanca e João Ricardo Costa Filho

use "C:\Users\jcfil\Documents\Econometria\brexit.dta", clear

**Dados em painel 
xtset cod year 

**Quadrado do IC

gen ic2 = ic^2

**Arellano-Bond (nível como instrumento)

xtabond  gdppercapita ic ic2 aberturacomercialxmgdp  inflation unemployment  expensesgdp  savingrate, lags(1) artests(2) vce(robust) 

outreg2 using "C:\Users\jcfil\Documents\Econometria\Painel", word replace

*Sargan-Hansen teste de sobreidentificação
*H0: overidentifying restrictions are valid

estat sargan

**Arellano-Bover/Blundell-Bond (nível e primeira diferença como instrumentos)

xtdpdsys  gdppercapita ic ic2 aberturacomercialxmgdp  inflation  unemployment  expensesgdp  savingrate, lags(1) artests(2) vce(robust) 

outreg2 using "C:\Users\jcfil\Documents\Econometria\Painel", word append

*Sargan-Hansen teste de sobreidentificação
*H0: overidentifying restrictions are valid

estat sargan

**Ahn and Schmidt (1995) 

xtdpdgmm L(0/1). gdppercapita ic ic2 aberturacomercialxmgdp  inflation  unemployment  expensesgdp  savingrate, gmm(L. gdppercapita ic ic2 aberturacomercialxmgdp  inflation  unemployment  expensesgdp  savingrate, l(1,3) m(d)) vce(robust)

outreg2 using "C:\Users\jcfil\Documents\Econometria\Painel", word append

*Sargan-Hansen teste de sobreidentificação
*H0: overidentifying restrictions are valid

estat overid
