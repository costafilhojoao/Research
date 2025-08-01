
close all;
options_.dynare_tempdir = 'C:\Temp\DynareTemp';
dynare solve;

util_ss = s_ss * ( log( cs_ss ) - theta/2 * ns_ss^2 ) + i_ss * ( log( ci_ss ) - theta/2 * ni_ss^2 ) + r_ss * ( log( cr_ss ) - theta/2 * nr_ss^2 );
u = util_ss-util;

figure

yyaxis left
plot(1:78, OCSI.WA/100, 'k-', 'LineWidth', 2)
ylabel('OCSI')

yyaxis right
plot(1:78, u(2:79), '-b', 'LineWidth', 2)
ylabel('Utility loss')

xlabel('Time')
title('Containment: data vs model', 'FontSize', 14)

grid on

round( corr( u(2:79), OCSI.WA/100 ), 2 )

rmdir('+solve', 's')
