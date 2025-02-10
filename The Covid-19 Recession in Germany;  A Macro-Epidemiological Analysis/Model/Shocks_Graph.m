%% read in OCSI data

OCSI = readtable('OCSI.dat');


%% plot
%figure;

%subplot(2,1,1);
plot(1:78, OCSI.WA/100, 'LineWidth',2);hold on
plot(1:78,muc(2:79),'--b','LineWidth',2);
plot(1:78,mun(2:79),'--r','LineWidth',2);
plot(1:78,mul(2:79),'--g','LineWidth',2);
title("Containment Variables");
legend("OCSI Weekly Avg","Consumption Tax", "Labour Tax", "Social Restrictions", 'Orientation', 'horizontal', Location='southoutside', FontSize = 6)
xlabel('Weeks','FontSize',fsize);



%subplot(2,1,2);
%plot(1:79, ro(2:80), 'b-','LineWidth',2);
%title("Containment Persistency");
%xlabel('Weeks','FontSize',fsize);

