function [err,pi1,pi2,pi3,RnotSIR,I,S,D,R,T] =calibrate_pi(pi_guess,HH,i_ini,pir,pid,pi1_shr_target,pi2_shr_target,RplusD_target,C_ss,N_ss,scale1,scale2)

%back out initial guesses
pi1=pi_guess(1)/scale1;
pi2=pi_guess(2)/scale2;
pi3=pi_guess(3);

%pre-allocate
I=NaN*ones(HH+1,1);
S=NaN*ones(HH+1,1);
D=NaN*ones(HH+1,1);
R=NaN*ones(HH+1,1);
T=NaN*ones(HH,1);

%initial conditions
I(1)=i_ini;
S(1)=1-I(1);
D(1)=0;
R(1)=0;

%iterate on SIR model equations
for j=1:1:HH
    T(j,1)=pi1*S(j)*C_ss^2*I(j)+pi2*S(j)*N_ss^2*I(j)+pi3*S(j)*I(j);
    S(j+1,1)=S(j)-T(j);
    I(j+1,1)=I(j)+T(j)-(pir+pid)*I(j);
    R(j+1,1)=R(j)+pir*I(j);
    D(j+1,1)=D(j)+pid*I(j);
end

%calculate equation residuals for target equations
err(1)=pi1_shr_target-(pi1*C_ss^2)/(pi1*C_ss^2+pi2*N_ss^2+pi3);
err(2)=pi2_shr_target-(pi2*N_ss^2)/(pi1*C_ss^2+pi2*N_ss^2+pi3);
err(3)=RplusD_target-(R(end)+D(end));


RnotSIR=T(1)/I(1)/(pir+pid);

 