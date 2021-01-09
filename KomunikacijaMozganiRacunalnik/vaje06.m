% prenos podatkovne baze
% physionetdb('eegmmidb')
% prenos posnetkov (posnetek 102)
% [success,files] = wfdbdownload('mitdb/102')

% preberemo posnetek 100 z rdsamp
% [matrika_signalov, frekvenca_vzorcenja_signala,
% casovni_indeks_posameznega_vzorca]
% [sigs, freq, tm] = rdsamp('mitdb/100');
interval = 1:180;
% izrisemo svse (:) signale na nekem intervalu, v tem priemru sta to dva
% signala
% plot(tm(interval), sigs(interval, :))

% napisemo celotno pot do podatkovne baze
[sigs, freq, tm] = rdsamp('S010R01.edf');
plot(tm, sigs);
% boljsi izris
plot(tm, sigs(:, 1:64));
plot(tm(interval), sigs(interval, 1:64));
% seznam signalov
lst = [1,2,5:7];
plot(tm(interval), sigs(interval, lst));
legend;
% anotacija, tip, podtip oznake, kanal, numericna vrednost, komentar
[annot, atyp, sbtyp, chn, nm, cmt] = rdann('eegmmidb/S010/S010R03.edf', 'event');
%prikazimo te oznake na grafu
plot(tm, sigs(:, lst));
for i=1:length(annot)
    xline(tm(annot(i)), '--r', cmt(i))
end
