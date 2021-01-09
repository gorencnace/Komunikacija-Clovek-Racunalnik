load('variable.mat')
% [eeg, freq, tm] = rdsamp('S010R01.edf');
figure('Name','Osnovni signali');
for i = 1:size(eeg, 2) - 1 % ker imamo 65 signalov, hocem jih 64
    subplot(16, 4, i);
    plot(tm, eeg(:, i));
end

% [icasig, A, W] = fastica(eeg(:, 1:64)'); % moram se odstrant enga (zadnga)
figure('Name','Signali v prostoru komponent');
for i = 1:size(icasig, 1)
     subplot(16, 4, i);
    plot(tm, icasig(i, :));
end


ch_list = {'Fc5', 'Fc3', 'Fc1', 'Fcz', 'Fc2', 'Fc4', 'Fc6', ...
           'C5', 'C3', 'C1', 'Cz', 'C2', 'C4', 'C6', ...
           'Cp5', 'Cp3', 'Cp1', 'Cpz', 'Cp2', 'Cp4', 'Cp6', ...
           'Fp1', 'Fpz', 'Fp2', ...
           'Af7', 'Af3', 'Afz', 'Af4', 'Af8', ...
           'F7', 'F5', 'F3', 'F1', 'Fz', 'F2', 'F4', 'F6', 'F8', ...
           'Ft7', 'Ft8', ...
           'T9', 'T7', 'T8', 'T10', ...
           'Tp7', 'Tp8', ...
           'P7', 'P5', 'P3', 'P1', 'Pz', 'P2', 'P4', 'P6', 'P8', ...
           'Po7', 'Po3', 'Poz', 'Po4', 'Po8', ...
           'O1', 'Oz', 'O2', ...
           'Iz'};
       
W1 = inv(W);

% Funkcija plot_topography je dostopna na 
% https://www.mathworks.com/matlabcentral/fileexchange/72729-topographic-eeg-meg-plot/

% primer pregleda vseh posnetkov
% for i = 1:64
%     figure;
%     plot_topography(ch_list, W1(:, i));
% end


% v primeru uporabe workspace-a shranjenega v 'variable.mat' so naslednje
% slike kljucne
% figure('Name','Stolpec 2');
% plot_topography(ch_list, W1(:, 2));
% figure('Name','Stolpec 3');
% plot_topography(ch_list, W1(:, 3));
% figure('Name','Stolpec 10');
% plot_topography(ch_list, W1(:, 10));
% figure('Name','Stolpec 19');
% plot_topography(ch_list, W1(:, 19));
% figure('Name','Stolpec 23');
% plot_topography(ch_list, W1(:, 23));
% figure('Name','Stolpec 35');
% plot_topography(ch_list, W1(:, 35));
% figure('Name','Stolpec 36');
% plot_topography(ch_list, W1(:, 36));


brisi = [1, 4:9, 11:18, 20, 21, 22, 24:34, 37:64];
Wap = W1(:, brisi);
sigs = icasig(brisi, :);

Xap = Wap * sigs;
figure('Name','Korigirani signali');
for i = 1:size(Xap, 1)
    subplot(64 / 4, 4, i);
    plot(tm, Xap(i, :));
end

% Primerjava dveh signalov, kjer se Filtriranje najbolj opazi
figure
tiledlayout(2,1)
ax1 = nexttile;
plot(tm, eeg(:, 23))
ax2 = nexttile;
plot(tm, Xap(23, :))
title(ax1, 'Pred obdelavo')
title(ax2, 'Po obdelavi')