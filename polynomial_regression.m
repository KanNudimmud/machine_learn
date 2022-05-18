%% Polynomial Regression
%% Generate the data
n  = 30;
x  = linspace(-2,4,n);
y1 = x.^2 + randn(1,n);
y2 = x.^3 + randn(1,n);

% Plot the data
figure(1), hold on
plot(x,y1,'ko','markersize',10,'markerfacecolor','r','linew',2)
plot(x,y2,'ko','markersize',10,'markerfacecolor','g','linew',2)
legend({'Quadratic','Cubic'})

%% For a polynomial fit
% For y1
pterms = polyfit(x,y1,2);
yHat1 = polyval(pterms,x);
plot(x,yHat1,'r','linew',2)

% For y2
pterms = polyfit(x,y2,3);
yHat2 = polyval(pterms,x);
plot(x,yHat2,'g','linew',2)

%% Compute R2
% Compute R2 for several polynomial orders
orders = 1:5;

% Output matrices
r2 = zeros(2,length(orders));
sse = zeros(2,length(orders));

% The loop
for oi=1:length(orders)
    % Fit the model with oi terms
    pterms = polyfit(x,y1,orders(oi));
    yHat = polyval(pterms,x);
    
    % Compute R2
    ss_eta = sum((y1-yHat).^2); % numerator
    ss_tot = sum((y1-mean(y1)).^2); % denominator
    r2(1,oi) = 1 - ss_eta/ss_tot; % R^2
    sse(1,oi) = ss_eta; % store just the SSe for model comparison later
    
    % Repeat for y2
    pterms = polyfit(x,y2,orders(oi));
    yHat = polyval(pterms,x);
    ss_eta = sum((y2-yHat).^2);
    ss_tot = var(y2)*(n-1);
    r2(2,oi) = 1 - ss_eta/ss_tot;
    sse(2,oi) = ss_eta; % store just the SSe for model comparison later
end

% Plot results
figure(2)
subplot(211)
plot(orders,r2,'s-','linew',2,'markerfacecolor','w','markersize',12)
set(gca,'xlim',[orders(1)-.5 orders(end)+.5],'xtick',orders)
xlabel('Polynomial model order')
ylabel('Model R^2')
legend({'$y_1 = x^2$';'$y_2 = x^3$'},'Interpreter','latex')

% Compute the Bayes Information Criterion
bic = n*log(sse) + orders*log(n);
subplot(212)
plot(orders,bic,'s-','linew',2,'markerfacecolor','w','markersize',12)
set(gca,'xlim',[orders(1)-.5 orders(end)+.5],'xtick',orders)
xlabel('Polynomial model order')
ylabel('BIC')
zoom on

%% end.