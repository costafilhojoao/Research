

sobs  = '1'; midsep = ':'; eobs ='192';

%GF = xlsread('Series_matlab_145','Plan1',['A',sobs,midsep,'EO',eobs]);
%GF = xlsread('Series_matlab_145_atualizada','Plan1',['A',sobs,midsep,'EO',eobs]);
GF = xlsread('Series_matlab_145_atualizada','Plan1',['A',sobs,midsep,'EK',eobs]);

sobs  = '1'; midsep = ':'; eobs ='1';
codeGF = xlsread('CodeGF_145','Plan2',['A',sobs,midsep,'EK',eobs]);

sobs  = '1'; midsep = ':'; eobs ='1';
transGF = xlsread('TransGF_145','Plan2',['A',sobs,midsep,'EK',eobs]);

x = standardize(GF);

% the number of static and dynamic factors
% static factors (Bai Ng 2002)
[PC,IC] = baingcriterion(x,25);
[minimum,rhat] = min(IC(:,2));

%rhat=5
Fhat = principalcomponents(x,rhat);

% number of lags in the VAR
[AIC, BIC, e] = aicbic(Fhat,6);

% dynamic factors (Bai Ng 2007, SW 2005)
k = 3;
nrepli=500;
baingqhat = baingdftest(x,rhat,k);
swqhat = swdftest(x,rhat,k);

% dynamic factors (Hallin Liska 2007)
q1 = HL2(x,  16,  1.5, 30, 'p1');
q2 = HL2(x,  16,  1.5, 30, 'p2');
q3 = HL2(x,  16,  1.5, 30, 'p3');
HLqhat = [q1;q2;q3];

% no of dyn fractors with r static factors according to Bai Ng 2007
rhat
HLqhat
baingqhat
swqhat
intv = [5 96 106 75];
%iv = [1 2 9 10 22 23 24 33 34 39 40 41 42 43 44 45 46 47 48 57 66 67 70 71 79 83 89 91 93 94 97 95 98 99 100 112 113 116 117 118 119 120 126 132 133 134 135 136 138 139 140 141 144 145 ];

iv = [1 2 9 10 22 23 24 33 34 39 40 41 42 43 44 45 46 47 48 57 66 67 70 71 79 83 89 91 93 94 97 95 98 99 100 112 113 116 117 118 119 120 126 132 133 134 135 136 138 139 140 141 144 145 ];

%%%% construct labels
for i=1:size(GF,2)
    titoli(i,:)=['                            '];
end
titoli(intv,:)= ...
   ['      Prod.Industrial       ';
    '           IPCA             ';
    '          Selic             ';
    '      Real/Dolar real       '];

titoli(iv,:)= ...
   ['   Prod Extrativa Mineral   ';
    '     Prod Ind Transf        ';
	'   Insumos Const Civil      ';
	'      PMC restrita          ';
    '      PMC ampliada          ';
    '         IBC-Br             ';
    '    Confianca da Ind.       ';
	'         NUCI               ';
	'      Energia EPE           ';
    '     Receita Liquida        ';
    '     Despesas Totais        ';
	'  Despesas Obrigatorias     ';
	'  Despesas Discricionarias  ';
	'        Divida/PIB          ';
    '    Tx de Desemprego        ';
	'    Tx de Participacao      ';
    '     Pop. Ocupada           ';
    '     Rend medio real        ';
	'    Caged Admissoes         ';
    '    Caged Demissoes         ';
    '  Caged Salario Adm (avg)   ';
	'  Caged Salario Dem (avg)   ';
    '   Cred. Saldo Total        ';
    '  Cred. Saldo Livre PF      ';
    '  Cred. Saldo Direc PF      ';
    '  Cred. Saldo Livre PJ      ';
    '  Cred. Saldo Direc PJ      ';
	'Cred. Saldo Direc PJ - BNDES';
    '           M1               ';
	'           M2               ';
    '      IPCA Livres           ';
    '   IPCA Administrados       ';
    '      IPCA Alimen           ';	
    '     IPCA Servicos          ';	
    '    IPCA Industriais        ';	
    '  IPCA Media dos Nucleos    ';
    '         IGP-DI             ';
    ' Resultado Trans. Correntes ';
    '          IDP               ';
    '      Inv Renda Fixa        ';
    '       Inv Acoes            ';
    '  Exportacoes (quantum)     ';
    '  Importacoes (quantum)     ';
	'     Pre DI 90 dias         '; 
	'     Pre DI 360 dias        '; 
    '          CDI               ';	
    '          TJLP              ';	
    '          VIX               ';	
    '          CDS               ';
    '        Ibovespa            ';
    '      R$/US$ nominal        ';	
    '      R$/Peso real          ';		
    '      Compulsorio           ';
    '   Carderneta de Poupanca   '];


[irf, v, stdv, meanv,chi,sh,ci,bootci,imp,bootimp] =DoEverything(GF, intv, rhat, k, 24, codeGF,nrepli);

for i=1:size(bootci,4),
    bootci(:,:,:,i)=bootci(:,:,:,i)/bootci(75,3,1,i)*0.5;
end

%bootci=bootci/ci(75,3,1)*0.5;

ci=ci/ci(75,3,1)*0.5;

irf = confband(bootci, ci, .8);

index5=MyFind([1:145]'.*(transGF==5)')
index4=MyFind([1:145]'.*(transGF==4)')
index=sort([index5;index4]);

irf(index,:,:,:)=irf(index,:,:,:)*100; 

figure(1);
DoSubPlots(irf,2,2,intv,3,titoli);

figure(2);
DoSubPlots(irf,2,3,[97 95 99 100 112 113 ],3,titoli);

figure(3);
DoSubPlots(irf,3,3,[1 2 9 10 22 23 24 33 34 ],3,titoli);

figure(4);
DoSubPlots(irf,3,3,[44 45 46 47 48 57 66 67 67],3,titoli);

figure(5);
DoSubPlots(irf,2,3,[70 71 79 83 89 89],3,titoli);

figure(6);
DoSubPlots(irf,2,3,[39 40 41 42 43 43],3,titoli);

figure(7);
DoSubPlots(irf,2,3,[116 117 118 119 119 119],3,titoli);

figure(8);
DoSubPlots(irf,2,3,[138 139 141 144 145 145],3,titoli);