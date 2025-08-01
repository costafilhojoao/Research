/*

Business cycles in the State of Rio Grande do Sul: A Regional DSGE approach (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare name" (where name stands for how you named your mod-file) into the command window

For Matlab R2020a and DYNARE 4.6.1.

*/

%% This code produces Figure 2 of the paper. Run 'dynare irf.mod' first.

t = 10; % number of periods

figure
subplot(2, 2, 1);
plot(1:1:t, oo_.irfs.y_eps_g*100, 'Color',[  0 0.4470 0.7410], 'Linewidth',2); hold on;
plot(1:1:t, oo_.irfs.y_eps_gc*100, '--', 'Color',[  0 0.4470 0.7410], 'Linewidth',2); 
plot(1:1:t, zeros(1, t),           'Color',[0.5 0.5 0.5], 'Linewidth',2)
xlim([1 t])
ylabel("%")
axis("square")
title('Output'); hold off;

subplot(2, 2, 2);
plot(1:1:t, oo_.irfs.c_eps_g*100, 'Color',[  0 0.4470 0.7410], 'Linewidth',2); hold on;
plot(1:1:t, oo_.irfs.c_eps_gc*100,'--', 'Color',[  0 0.4470 0.7410], 'Linewidth',2);
plot(1:1:t, zeros(1, t),           'Color',[0.5 0.5 0.5], 'Linewidth',2)
xlim([1 t])
ylabel("%")
axis("square")
title('Consumption'); hold off;

subplot(2, 2, 3);
plot(1:1:t, oo_.irfs.pi_eps_g*100, 'Color',[  0 0.4470 0.7410], 'Linewidth',2); hold on;
plot(1:1:t, oo_.irfs.pi_eps_gc*100, '--', 'Color',[  0 0.4470 0.7410], 'Linewidth',2); hold on;
plot(1:1:t, zeros(1, t),           'Color',[0.5 0.5 0.5], 'Linewidth',2)
xlim([1 t])
ylabel("%")
axis("square")
title('Inflation'); hold off;

subplot(2, 2, 4);
plot(1:1:t, oo_.irfs.W_eps_g*100, 'Color',[  0 0.4470 0.7410], 'Linewidth',2); hold on;
plot(1:1:t, oo_.irfs.W_eps_gc*100, '--', 'Color',[  0 0.4470 0.7410], 'Linewidth',2); hold on;
plot(1:1:t, zeros(1, t),           'Color',[0.5 0.5 0.5], 'Linewidth',2)
xlim([1 t])
ylabel("%")
axis("square")
title('Wages'); hold off;
exportgraphics(gcf,'figure2.jpg','Resolution',300)