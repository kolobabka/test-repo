lambdaDelta = importdata ("lambda_delta.csv");
lambdaStart = importdata ("lambda_start.csv");
spectra = importdata ("spectra.csv");
starNames = importdata ("star_names.csv");

lambdaPr = 656.28;
speedOfLight = 299792.458;

num_Names = size (starNames, 1);
n_Obs = size (spectra, 1);

lambdaEnd = (n_Obs - 1) * lambdaDelta + lambdaStart;
lambda = (lambdaStart : lambdaDelta : lambdaEnd)';

graph_1 = figure;
xlabel ('Длина волны, нм')
ylabel (['Интенсивность, эрг/см^2/с/', char(197)])
set (graph_1, 'Visible', 'on')

grid on
hold on

speed = zeros (num_Names, 1);
for i = 1:num_Names
col = spectra(:, i);
[colHa, idx] = min(col);
lambdaHa = lambda(idx);

z = (lambdaHa / lambdaPr) - 1 ;
speed(i) = z * speedOfLight ;

if speed(i) > 0
plot (lambda, col, 'LineWidth', 3, 'LineStyle', "-")
else
plot (lambda, col, 'LineWidth', 1, 'LineStyle', "--")
end
end
legend (starNames, "Location", "northeast")
text (lambdaStart + 3, max(col) * 8.2 ,'Белов Владислав Б01-005')
title('Спектры звезд')
hold off

flag = speed > 0;
movaway = starNames (flag)
saveas (graph_1, 'спектры.png')
