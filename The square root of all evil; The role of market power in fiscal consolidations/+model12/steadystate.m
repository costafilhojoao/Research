function [ys_, params, info] = steadystate(ys_, exo_, params)
% Steady state generated by Dynare preprocessor
    info = 0;
    ys_(2)=params(19);
    ys_(10)=params(20);
    ys_(18)=params(21);
    ys_(17)=ys_(10);
    ys_(4)=((1-params(14))*ys_(17)^(1-params(15))+params(14)*ys_(18)^(1-params(15)))^(1/(1-params(15)));
    ys_(5)=ys_(4)*ys_(2)^(params(7)-1);
    ys_(12)=params(5)*ys_(10)*1/(params(2)*(2+params(8)-params(5)))/params(4);
    ys_(11)=ys_(10)*(params(2)-1)/params(2)+params(4)*ys_(12);
    ys_(13)=ys_(10)/ys_(11);
    ys_(14)=1/params(1);
    ys_(7)=params(5)*ys_(14)/params(4);
    ys_(8)=ys_(7);
    ys_(22)=ys_(8)*params(17);
    ys_(21)=ys_(4)*ys_(22);
    ys_(19)=ys_(22)*(1-params(14))*(ys_(17)/ys_(4))^(-params(15));
    ys_(20)=ys_(22)*params(14)*(ys_(18)/ys_(4))^(-params(15));
    ys_(1)=ys_(8)-ys_(22)-ys_(8)*params(18);
    ys_(15)=(1-params(14))*(ys_(17)/ys_(4))^(-params(15))*ys_(1);
    ys_(16)=params(14)*(ys_(18)/ys_(4))^(-params(15))*ys_(1);
    ys_(3)=(ys_(1)-ys_(2)^params(7)/params(7))^(-params(6))/ys_(4);
    ys_(24)=params(8);
    ys_(9)=ys_(4)*ys_(8)-ys_(2)*ys_(5);
    ys_(25)=ys_(4)/ys_(17)*(ys_(8)*params(18)+ys_(18)/ys_(4)*(ys_(20)+ys_(16)));
    ys_(6)=(ys_(21)+ys_(4)*ys_(1)-ys_(2)*ys_(5)-ys_(9))/ys_(24);
    ys_(23)=params(5)/(params(4)*params(1))*ys_(2)^(params(3)-1);
    ys_(26)=0;
    ys_(27)=0;
    ys_(28)=0;
    ys_(29)=ys_(3);
    ys_(30)=ys_(12);
    ys_(31)=ys_(7);
    ys_(33)=ys_(8);
    ys_(34)=ys_(4);
    ys_(32)=ys_(10);
    ys_(35)=0;
    ys_(36)=0;
    ys_(37)=0;
    ys_(38)=0;
    ys_(39)=0;
    ys_(40)=0;
    ys_(41)=0;
    ys_(42)=0;
    ys_(43)=0;
    ys_(44)=0;
    ys_(45)=0;
    ys_(46)=0;
    ys_(47)=0;
    ys_(48)=0;
    ys_(49)=0;
    % Auxiliary equations
end