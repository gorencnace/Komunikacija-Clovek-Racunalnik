% pogledali si bomo metodo, ki pretvatja signale v njigove sestavne dele
% (neodvisne komponente)
% metoda predvideva, da se da ve? signalou zapisat kot produkt neke mesalne
% matrike ter neodvisnih komponent
% X(n) = A * Y(n)

% generirajmo nekaj sinteti?nih signalov - OSNOVNI SIGNALI
[sig, mix] = demosig();
% plot(sig); ne lepo, transponiramo:
% plot(sig'); dobimo lepse
% plot(sig(1,:)); dobimo vsak signal posebaj
% smiselno je, da usak posamezni signal prikazemo posebaj
for i= 1:size(sig,1)
    subplot(size(sig, 1), 1, i);
    plot(sig(i, :));
end

% sedaj kreirajmo MESANE signale na podlagi osnovnih signalov neodvisnih
% komponent
figure
for i = 1:size(mix, 1)
    subplot(size(mix, 1), 1, i);
    plot(mix(i, :));
end

% ali se da dobit osnovne iz mesanih?? Da - z uporabo analize neodvisnih
% komponent

% bodi pozoren, ko bos delal iz baze, kaj predstavljajo vrstice in kaj
% stolpci
% priporocilo: skaci iz direktorija v direktorij, da bos hitreje bral
% posnetke (cd <dir>, cd ..)

% dobimo mesalno matriko A, inverz mesalne matrike W in neodvisne
% komponente
[icasig, A, W] = fastica(mix);
%  prikazimo dobljene neodvisne komponente
figure
for i = 1:size(icasig, 1)
    subplot(size(icasig, 1), 1, i);
    plot(icasig(i, :));
end
% ta metoda nam dobro razbije signale na osnovne komponente (lahko se zmoti
% -> permiki, inverz, ...)

% pokazimo, da smo dejansko dobili iste signale - to se vidi, ker je napaka
% zelo majhna (e-15)
% comp = W\icasig;
% figure
% for i = 1:size(comp, 1)
%     subplot(size(comp, 1), 1, i);
%     plot(comp(i, :)-mix(i, :));
% end

% odstranti hocemo misicno aktivnost, ki jo zaznavamo
% ideja: Ce imamo dovolj signalov, lahko na podlagi signalov dobimo veliko
% neodvisnih komponent
% -> misicna aktivnost se odraza v nekaj neodvisnih komponent
% te komponente enostavno odstranimo iz samih signalov
% KAKO: X(n) = A * Y(n)
% -> te neodvisne komponente v mesalni matriki in Y odstranimo (zanemarimo
% stolpce)
W1 = inv(W); % nekaj, kar je blizu mesalne matrike A
Wap = W1(:, 1:3); % vzamemo vse komponente razn zadjega stolpca (ker se zadnjega hocmo znebit)

%pri signalih vzamemo vse stolpce in samo nekaj vrstic
sigs = icasig([1,2,3], :);
% da dobimo izhodni signal brez misicnih motenj pomnozimo matriko s signali
Xap = Wap * sigs;
figure
for i = 1:size(Xap, 1)
    subplot(size(Xap, 1), 1, i);
    plot(Xap(i, :));
end
% te signali so podobni figure2, kjer pa je odstranjena nezeljena fizicna
% aktivnost





