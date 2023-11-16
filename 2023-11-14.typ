= Codifica di canale
Nel contesto della teoria dell'informazione, un "canale" si riferisce a un concetto fondamentale che descrive il modo in cui l'informazione viene trasmessa da una sorgente a una destinazione attraverso un mezzo fisico o un processo di comunicazione su cui è applicato un rumore. Ricordiamo l’obiettivo generale della codifica canale: vogliamo trasmettere un messaggio attraverso un canale con rumore massimizzando la quantità di informazione trasmessa per uso del canale e simultaneamente minimizzando la probabilità di errore di decodifica. Un canale è così modellato:
$ angle.l Chi, Y, p(y | x) angle.r $
Dove $Chi$ è "cosa ha ricevuto il canale", $Y$ è "cosa ha trasmesso il canale" e $p(y | x)$ è la probabilità di ricevere $y in Y$ dato $x in X$ (quindi è la matrice stocastica che abbiamo definito nella prima lezione).

Se non viene specificato nulla, il canale a cui ci riferiamo è binario e senza memoria e dobbiamo tenere a mente che non necessariamente $X != Y$ (non è detto neanche che siano sottoinsiemi, diciamo che se non è un canale molto anomalo per lo meno sono correlati).

Un canale è *senza memoria* quando l’uscita ottenuta ad ogni uso del canale,
condizionata sull’ingresso, è indipendente dagli utilizzi passati e futuri. Ad esempio supponiamo che il canale venga usato $n$ volte per inviare un messaggio $x^n = (x_1, dots, x_n)$ ottenendo in uscita $y^n = (y_1, dots, y_n)$ Abbiamo che:
$ p(y^n | x^n) = p(y_n | y ^ (n-1), x^n) dot p(y_(n-1) | x^(n-2), x^n) times dots p(y_(n-1) | y^n-1, x^n) $
Ora se il canale è senza memoria vale che
$ p(y_n | p^(n-1), x^n) = p(y_n | x_n) $
$ p(y_(n-1) | p^(n-2), x^n) = p(y_(n-1) | x_(n-1)) $
$ dots.v $
$ p(y_1 | x^n) = p(y_1 | x_1) $
ovvero,
$ p(y^n | x^n) = product_(i=0)^n p(y_i | x_i) $

== Canale senza rumore
Un canale si dice senza rumore quando non introduce alcun rumore durante la trasmissione. In altre parole, la trasmissione di ciascun bit avviene senza errori, e il ricevitore riceve esattamente ciò che il trasmettitore ha inviato.
#v(12pt)

#figure(
    image("assets/2023-11-14 canale-senza-memoria.svg", width: 20%)
)

#v(12pt)
== Canale simmetrico
In un canale binario simmetrico, la probabilità di un errore di trasmissione è la stessa per entrambe le direzioni: dalla sorgente al destinatario e dal destinatario alla sorgente. Questo significa che la trasmissione errata di un bit è altrettanto probabile in entrambe le direzioni.
#v(12pt)

#figure(
    image("assets/2023-11-14 canale-simmetrico.svg", width: 20%)
)

#v(12pt)
== Capacità del canale
La capacità del canale $C$, è definita come il massimo dell'informazione mutua su tutte le distribuzioni di probabilità di $Chi$, ovvero
$ C = max_(p(x)) I(XX,YY) $
== Esempi
=== Capacità su un canale senza rumore
Supponiamo di voler calcolare la capacità del canale:
#v(12pt)

#figure(
    image("assets/2023-11-14 canale-senza-memoria.svg", width: 20%)
)

#v(12pt)

Noi sappiamo che $ 0<= I(XX,YY) := cases(
  H(XX) - H(XX | YY) <= log_2 |Chi|,
  H(YY) - H(YY | XX) <= log_2 |Y|
) $
$C = max_p(x) H(XX) - (H(XX | YY)=1$

$H(XX | YY) = 0$ perché sono su un canale senza rumore (Dato $YY$ conosco immediatemente $XX$).
#pagebreak()
=== Capacità su un canale rumoroso
Supponiamo di voler calcolare la capacità del canale:
#v(12pt)

#figure(
    image("assets/2023-11-14 canale-rumoroso.svg", width: 25%)
)

#v(12pt)

Quindi vogliamo trovare $C = max_p(x) H(XX) - (H(XX | YY)$

1)
$ H(YY | XX) = sum_x p(x) dot underbracket(H(YY | XX = x), sum_y p(YY|XX) dot log 1/p(YY | XX)) $
$ = underbrace(p(0), "probabilità \ndi spedire 0") dot H(YY | XX = 0) + p(1) dot H(YY | XX = 1) + p(2) dot H(YY | XX = 2) $
$ = (1/cancel(3) dot 3) dot cancel(3) = 1 $
$ p(0) = underbrace(1/3 dot 1/2, "probabilità di spedire 0\ne ricevere zero") + underbrace(1/3 dot 1/2,"probabilità di spedire 0\ne ricevere due") = 1/3 $
Per come è costruito il canale vediamo che $p(0) = p(1) = p(2)$

2)
$ H(YY) = (1/cancel(3) log_2 3) dot cancel(3) = log_2 3 $
*Quindi*
$C = max_p(x) underbrace(H(XX), log_2 3) - underbrace((H(XX | YY)),1) = (log_2 3) - 1 $
=== Capacità su un canale simetrico
Supponiamo di voler calcolare la capacità del canale:
#v(12pt)

#figure(
    image("assets/2023-11-14 canale-simmetrico.svg", width: 20%)
)

#v(12pt)
#pagebreak()
Riscriviamo 
$ C = max_p(x) H(YY) - [p(XX = 0) dot H(YY | XX = 0) + p(XX = 1) dot HH(YY | XX = 1)] $
$ H(YY | XX = 0) = underbrace(p(YY= 0 | XX = 0), 1-p) dot log_2 1/p(YY=0 | XX = 0) + underbrace(p(YY = 1 | XX = 0), p) dot log_2 1/p(YY = 1 | XX=0) $
Se notiamo bene quest'ultima mi ricorda la classica bernulliana, quindi posso scrivere
$ C = max_p(x) H(YY) - H(P) $
Adesso troviamo l'entropia di $YY$
$ H(YY) = sum_(y in Y) p(YY) log_2 1/p(YY) = p(YY= 0) log_2 1/p(YY = 0) + p(YY = 1) log_2 1/p(YY = 1) $
$ p(YY = 1) = 1/2 (1-p) + 1/2 p = 1/2 $
$ p(YY = 0) = 1/2 (1-p) + 1/2 p = 1/2 $

Adesso quindi $C = 1 - H(P)$


