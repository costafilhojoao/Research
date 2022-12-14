function irf_decomposition(endo_var_name,shock_name, shock_value, max_num_for_plotting, periods, irf_type, order)
%       This command runs IRF decomposition of an exogenous shock (shock_name) on endogenous variable (endo_var_name).
%       
%       The function is written for the paper:
%       Labus, M. & Labus, M. (2017):  “Monetary Transmission Channels in DSGE Models: Decomposition of Impulse Response Functions Approach”, 
%       Computation Economics, Volume 50, Number 1, pp.1-24. https://doi.org/10.1007/s10614-017-9717-1
%
% INPUTS
%   endo_var_name:          name of endogenous variable as defined in Dynade .mod file
%   shock_name:             name of exogenous variable (shock) as defined in Dynade .mod file
%   shock_value:            the size of shock
%   max_num_for_plotting:   maximim number of endogenous variables that will be desplayed on output figure
%   periods:                number of periods in IRF
%   irf_type:               option "1" for cumulative IRF, option "0" for period IRF
%   order:                  option "1" for first-order approximation, option "2" for second-order approximation
%             
% OUTPUTS
%   Figure with IRF decomposition
%        
% SPECIAL REQUIREMENTS
%   Dynare should solve a DSGE model, before this function is called
%   Dynare structures M_ and oo_ must be in the Workspace.
%
% DO NOT CHANGE CODE BELOW THIS LINE
fprintf('\n******************************************************\n');
fprintf('Decomposition of Impulse Response Function:\n\n');

% Load initial information and the solution matrices

try
base_oo_ = evalin('base','oo_');
base_M_ = evalin('base','M_');
catch
    error_msg(sprintf('Error: Please run Dynare command on your model first. Structures oo_ and M_ are missing from the Workspace!'));
    return;
end

num_state_vars = base_M_.nspred;
vars = base_M_.endo_names;
vars_long = base_M_.endo_names_long;
num_vars = size(vars,1);

exo_vars= base_M_.exo_names;
num_shocks= size(exo_vars,1);

% Check input parameters

j = 1;
notfound = 1;
while j<=num_shocks && notfound
    if(strcmp(strtrim(exo_vars(j,:)),shock_name))
        shock_index = j;
        notfound = 0;
    end
    j=j+1;
end

u_t = zeros(num_shocks,1);
u_t(shock_index) = shock_value; %1 ???

if(notfound)
    error_msg(sprintf('Error: Shock %s does not exist in Dynare model. Please enter correct shock_name name', endo_var_name));
    return;
else
    fprintf('... of Shock %s (order num %d)\n', shock_name,shock_index );
end

j = 1;
notfound = 1;
while j<=num_vars && notfound
    if(strcmp(strtrim(vars(j,:)),endo_var_name))
        var_index = j;
        notfound = 0;
    end
    j=j+1;
end

if(notfound)
    error_msg(sprintf('Error: Endogenous variable %s does not exist in Dynare model. Please enter correct variable name', endo_var_name));
    return;
else
   fprintf('... on Endogenous variable %s (order num %d)\n', endo_var_name,var_index );
end


% Computation starts here
SS=base_oo_.steady_state;

A = base_oo_.dr.ghx;             % this is Dynare simplified representation of matrix gy
B  = base_oo_.dr.ghu;            % this is Dynare simplified representation of matrix gu
if(order==2)
    if(isfield(base_oo_.dr, 'ghs2'))
        Delta2 = base_oo_.dr.ghs2;
    else
        error_msg(sprintf('\nError: irf decomposition can not be called with order ''2'' because model has not been solved with second-order approximation (filed ''ghs2'' does not exist in Dynare structure oo_.dr).'));
        return;
    end
    if(isfield(base_oo_.dr, 'ghxx'))
        C = base_oo_.dr.ghxx;
    else
        error_msg(sprintf('\nError: irf decomposition can not be called with order ''2'' because model has not been solved with second-order approximation (filed ''ghxx'' does not exist in Dynare structure oo_.dr).'));
        return;
    end
    if(isfield(base_oo_.dr, 'ghuu'))
        D  = base_oo_.dr.ghuu;
    else
        error_msg(sprintf('\nError: irf decomposition can not be called with order ''2'' because model has not been solved with second-order approximation (filed ''ghuu'' does not exist in Dynare structure oo_.dr).'));
        return;
    end
    if(isfield(base_oo_.dr, 'ghxu'))
        E  = base_oo_.dr.ghxu;
    else
        error_msg(sprintf('\nError: irf decomposition can not be called with order ''2'' because model has not been solved with second-order approximation (filed ''ghxu'' does not exist in Dynare structure oo_.dr).'));
        return;
    end
end

% Define the order of variables

order_var = base_oo_.dr.order_var;
inv_order = base_oo_.dr.inv_order_var;

% Compute the irf at the first step

y1(order_var)=SS(order_var)+B * u_t;
irf2(1,:)= y1;

% Compute initial decomposition of irf
% All contributions are stored in 3-dimensional matrix
% The first dimention records individual contributions,
% The second dimenstion keeps track of time and
% The third dimension are endogenous variable for which IRF decomposition is calculated

% x(order_var)= B(:,shock_index)*shock_value;
x(order_var)= B * u_t;
for j=1:num_vars
    decom(j,1,j) = x(j);
end

% Recover state variables

k2 = base_oo_.dr.kstate(find(base_oo_.dr.kstate(:,2) == 2),[1 4]);

%Compute the remaining steps up to the end of the number of irf periods
if(order==1) %first-order aproximation
    fprintf('\nDoing first-order approximation!\n');
    
    for i=2:periods
        for j = 1:num_vars
            temp = 0;
            for k= 1:num_state_vars
                var_id = k2(k,1);
                x= A(inv_order(j),k) * (irf2(i-1,order_var(var_id))-SS(order_var(var_id)));
                % Step two of the decomposition process (eq. 5.3)
                decom(order_var(var_id),i,j) =x;
                temp = temp + x;
            end
            yt(j)=SS(j)+ temp;
        end
        irf2(i,:)= yt;
    end
    
else %second-order approximation
    fprintf('\nDoing second-order approximation!\n');
    
    dd= D*kron(u_t,u_t);
    irf2(1,:) = y1 + 0.5 * (Delta2(inv_order))' + 0.5 * (dd(inv_order))';
   
    
    for i=2:periods
        for j = 1:num_vars
            temp = 0;
            for k= 1:num_state_vars
                var_id = k2(k,1);
                x1= A(inv_order(j),k) * (irf2(i-1,order_var(var_id))-SS(order_var(var_id)));
                
                y_t = irf2(i-1,order_var(k2(:,1)))'-SS(order_var(k2(:,1)));
                
                x2 = 0.5 * Delta2(inv_order(j));
                
                x4 = 0;
                for s1 = 1:num_state_vars
                    for s2 = 1:num_state_vars
                        contribution= 0.5 * C(inv_order(j),s1*s2) * y_t(s1) * y_t(s2);
                        
                        if(s1==k && s2 ==k)
                            x4 = x4+ contribution;
                        elseif(s1==k)
                            x4 = x4+ contribution * y_t(s1)/(y_t(s1) + y_t(s2));
                        elseif(s2==k)
                            x4 = x4+ contribution * y_t(s2)/(y_t(s1) + y_t(s2));
                        end
                   end
                end
                
                x= x1+x2+x4;
                
                % Step two of the decomposition process
                decom(order_var(var_id),i,j) =x;
                temp = temp + x;
            end
            yt(j)=SS(j)+ temp;
        end
        irf2(i,:)= yt;
    end
    
end
%Compute the relative irf to the steady state of each variable

% for k=1:num_vars
%     irf2_(:,k)=irf2(:,k)-SS(k);  % NE KORISTIMO IRF2_, ovo moze da se izbrise
% end

%cumulative decom & IRF
if(irf_type)
    for j = 1:num_vars
        %cumulative decomposition
        temp = decom(:,:,j);
        decom(:,:,j) = cumsum(temp,2);
    end
end

% save decomp to a decomposition.mat file
decomposition = struct();
for j = 1:num_vars
    temp = decom(:,:,j);
    var_name = strtrim(vars(j,:));
    eval(sprintf('decomposition.%s = temp;', char(var_name)));
end

save('decomposition.mat', '-struct', 'decomposition');

%% Plot results

data = decom(:,:,var_index);

[new_data, labels] = getFirstNMax(data,vars,max_num_for_plotting);

%% Optional: save plotting data to a decomp_plot_results_varname.xls file

filename = sprintf('decomp_plot_results_%s_%s.xls', endo_var_name, shock_name);
range_labels = sprintf('A1:%s1',  char('A'+ max_num_for_plotting+1));
xlswrite(filename,[labels, 'IRF'],range_labels);
range_data = sprintf('A2:%s%d', char('A'+ max_num_for_plotting+1),periods +1); 
xlswrite(filename,new_data',range_data);

irf_graph_decomp(new_data, labels, endo_var_name, shock_name);

fprintf('\nProgram finished successfully!');
fprintf('\n******************************************************\n');

end

function error_msg(str)
    fprintf('%s\n',str);
    fprintf('\nProgram finished with error!');
    fprintf('\n******************************************************\n');
end

function [C, labels] = getFirstNMax(A , vars, numMax)

temp = mean(A,2);
B = [abs(temp), A];

[C, index] = sortrows(B, -1);

C2 = C(1:numMax, 2:end);
rest = C(numMax+1:end, 2:end);
R = (sum(rest',2))';
t = C(:, 2:end);
S = (sum(t',2))';

C = [C2; R; S];

for j=1:numMax
    labels(j) = cellstr(vars(index(j),:));
end
labels(numMax+1) = cellstr('others') ;

end


function irf_graph_decomp(z, endo_names, var_name, shock_name)

% number of components equals number of shocks + 1 (initial conditions)
comp_nbr = size(z,1)-1;

gend = size(z,2);
freq = 1;%initial_date.freq;
initial_period = 1;%initial_date.period + initial_date.subperiod/freq;
x = initial_period-1/freq:(1/freq):initial_period+(gend-1)/freq;

z1=z;
xmin = x(1);
xmax = x(end);
ix = z1 > 0;
ymax = max(sum(z1.*ix));
ix = z1 < 0;
ymin = min(sum(z1.*ix));
if ymax-ymin < 1e-6
    return;
end

fhandle = figure('Name',sprintf('IRF decomposition of %s on variable: %s', char(shock_name), var_name));

hdt = datacursormode(fhandle);
set(hdt,'UpdateFcn',@myupdatefcn,'SnapToDataVertex','off');
datacursormode on;

ax=axes('Position',[0.1 0.1 0.6 0.8]);
plot(ax,x(2:end),z1(end,:),'k-','LineWidth',3,'Color','r');
title(sprintf('IRF decomposition of %s on: %s', shock_name, var_name));
axis(ax,[xmin xmax ymin ymax]);
hold on;
for i=1:gend
    i_1 = i-1;
    yp = 0;
    ym = 0;
    for k = 1:comp_nbr
        zz = z1(k,i);
        v_name = char(endo_names(k));
        
        if zz > 0
            a = fill([x(i) x(i) x(i+1) x(i+1)],[yp yp+zz yp+zz yp],k, 'Tag', v_name, 'UserData', v_name);
            yp = yp+zz;             
        else
            fill([x(i) x(i) x(i+1) x(i+1)],[ym ym+zz ym+zz ym],k, 'Tag', v_name, 'UserData', v_name);
            ym = ym+zz; 
        end
        hold on;
    end
end

plot(ax,x(2:end),z1(end,:),'k-','LineWidth',3,'Color','r');
hold off;

axes('Position',[0.75 0.1 0.2 0.8]);
axis([0 1 0 1]);
axis off;
hold on;
y1 = 0;
height = 1/comp_nbr;

labels = char(endo_names);

for i=1:comp_nbr
    fill([0 0 0.2 0.2],[y1 y1+0.7*height y1+0.7*height y1],i, 'Tag', char(endo_names(i)));
    hold on
    text(0.3,y1+0.3*height,labels(i,:),'Interpreter','none');
    hold on
    y1 = y1 + height;
end

grid on;
hold off

    function [txt] = myupdatefcn(obj,event_obj)
        src = get(event_obj,'Target');
        var_name = get(src, 'Tag');
        txt = getEndoName(var_name);
    end

end

function [varName] = getEndoName(varCode)
varName = varCode;

base_M_ = evalin('base', 'M_');
x = strmatch(varCode, base_M_.endo_names, 'exact');
if(size(x)==1)
    
    longName = base_M_.endo_names_long(x,:);
    if(~strcmp(strtrim(longName),varCode))
        varName = sprintf('%s (%s)', strtrim(longName), varCode);
    else
        varName = varCode;
    end
end

end
