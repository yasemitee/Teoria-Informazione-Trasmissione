#import "@preview/lemmify:0.1.4": *

#let (
  theorem, lemma, corollary,
  remark, proposition, example,
  proof, rules: thm-rules
) = default-theorems("thm-group", lang: "it")

#show: thm-rules

#show thm-selector("thm-group", subgroup: "proof"): it => block(
    it,
    stroke: green + 1pt,
    inset: 1em,
    breakable: true
)
= Codici per il rilevamento degli errori

Quando trasmettiamo dei dati su un canale reale è inevitabile riscontrare degli errori (dovuti soprattutto al rumore applicato sul canale). Nel messaggio l'errore può presentarsi in diversi punti e con omogeneità diverse, ad esempio

#v(12pt)

#figure(
    image("assets/2023-11-24 esempio-errore.svg", width: 75%)
)
#v(12pt)

Oppure può presentarsi il rumore bianco, ovvero un errore costante che ha la stessa influenza su tutti i bit della stringa (in altre parole ha la stessa probabilità $p$ di errore in ogni posizione).

== Probabilità di errore
- Probabilità di mandare $n$ simboli senza errore
$ (1 - p)^n $
- Probabilità di avere esattamente 1 errore
$ n dot p(1-p)^(n-1) $
- Probabilità di avere $l$ errori
$ binom(n,l) dot p^l (1 - p)^(n-l) $
- Probabilità di avere fino a $max$ errori (dove $max$ indica un numero massimo prefissato di errori)
$ sum_(l = 1)^max binom(n,l) dot p^l (1 - p)^(n-l) $
- Probabilità di avere un numero pari di errori
$ sum_(l = 0)^(n/2) binom(n,2l) dot p^(2l) (1 - p)^(n-2l) $

== Single parity check code


Il modo più semplice per codificare un messaggio binario al fine di renderlo rilevabile agli errori è contare il numero di 1 nel messaggio e quindi aggiungere un ultimo bit binario scelto in modo che l'intero messaggio abbia un numero pari di 1. L'intero messaggio è quindi di parità pari. Pertanto, alle $(n - 1)$ posizioni del messaggio, aggiungiamo una posizione di controllo di parità $n$. Alla fine del processo di ricezione, si conta il numero di 1 nel messaggio ricevuto, e un numero dispari di 1 in tutte le n posizioni indica che si è verificato almeno un errore. Formalmente:

Rilevare il bit di parità:
$ sum_(i = 1)^n x_i mod 2 "(se vogliamo è lo XOR)" $

Rilevare l'errore
$ sum_(i=1)^n y_i = 0 $
=== Esempio
Supponiamo di avere una sequenza di bit, ad esempio 101101. Per aggiungere il bit di parità, calcoliamo la somma (modulo 2) di tutti i bit della sequenza. Se il risultato è pari, il bit di parità aggiunto sarà 0; se è dispari, il bit di parità sarà 1. Quindi, nel nostro esempio:

1 ⊕ 0 ⊕ 1 ⊕ 1 ⊕ 0 ⊕ 1 ≡ 0

Poiché il risultato è pari, il bit di parità sarà 0. La sequenza con il bit di parità aggiunto sarà quindi 1011010.

Quando i dati vengono trasmessi o memorizzati, il ricevitore o il sistema di memorizzazione può calcolare nuovamente la somma (modulo 2) di tutti i bit, incluso il bit di parità. Se la somma è pari, il sistema assume che non ci siano errori. Se la somma è dispari, il sistema sa che si è verificato un errore durante la trasmissione.

Evidentemente, in questo codice non è possibile rilevare un doppio errore. Inoltre, non è possibile rilevare alcun numero pari di errori. Tuttavia, è possibile rilevare qualsiasi numero dispari di errori.

notiamo come abbiamo $n-1$ bit di informazione e 1 bit di parità, quindi sul canale vengono spediti $n$.

== Ridondanza 
È pratica comune suddividere un lungo messaggio nell'alfabeto binario in sequenze (blocchi) di (n - 1) cifre ciascuna e aggiungere una cifra binaria a ciascuna sequenza, rendendo così il blocco trasmesso lungo n cifre. Il blocco finale potrebbe richiedere un padding con zeri. Ciò produce la ridondanza di
$ n/(n-1) = 1 + underbrace(1/(n-1),"ridondanza \n aggiunta") $
Dove $n$ è il numero di bit spediti sul canale mentre $n-1$ è il numero di bit di informazione trasmessi.

== Codice ASCII

Inizialmente è stato pensato con 7 bit, quindi con $2^7$ caratteri, con il bit di parità diventano 8
$ [x_1, x_2, x_3, x_4, x_5, x_6, x_7 | "parity"] $
Supponiamo di trasmettere la parola "hello$b$nctun" dove $b$ è il carattere blank/spazio e l'n finale è il bit di parità

$110_8 = $ h $=01001000$

$145_8 = $ e $=01100101$

$154_8 = $ l $=01101100$

$154_8 = $ l $=01101100$

$157_8 = $ o $=01101111$

$" "40_8 = $ $b$ $=00100000$

$116_8 = $ n $=01001110$

$103_8 = $ c $=01000011$

$124_8 = $ t $=01010100$

$125_8 = $ u $=underbracket(01010101,10010110)$

Quindi il messaggio spedito è 1001011|1

In questo codice è facile riconoscere gli errori burst, ma lo svantaggio è che non riconosce gli errori pari

== Codici pesati

I codici che di cui abbiamo discusso finora hanno generalmente assunto una forma di rumore bianco semplice. Questo è molto adatto per molti tipi di macchine, anche se nella trasmissione seriale la perdita di un simbolo (o l'inserimento di uno in più) è un errore comune in alcuni sistemi e non viene rilevato da tali codici, causando così una perdita di sincronizzazione.

Quando si tratta di interagire con gli esseri umani, un altro tipo di rumore è più appropriato. Le persone hanno la tendenza a scambiare le cifre adiacenti dei numeri; ad esempio, 67 diventa 76. Un secondo errore comune è raddoppiare la cifra sbagliata di un triplo di cifre, due delle quali adiacenti sono uguali; ad esempio, 667 diventa 677, semplicemente cambiando una cifra. Questi sono i due errori umani più comuni nell'aritmetica. In un sistema combinato di alfabeto/numeri, la confusione tra "o" e "zero" è molto comune.

Una situazione piuttosto frequente è avere un alfabeto, uno spazio e i 10 decimali come l'insieme completo di simboli da utilizzare. Ciò equivale a $26 + 1 + 10 = 37$ simboli nell'alfabeto di trasmissione. Fortunatamente, 37 è un numero primo e possiamo utilizzare il seguente metodo per il controllo degli errori. Assegniamo pesi ai simboli con valori $1, 2, 3, dots$ a partire dal simbolo di controllo del messaggio. Riduciamo la somma modulo 37 (dividiamo per 37 e prendiamo il resto) in modo che sia possibile selezionare un simbolo di controllo che renda la somma 0 modulo 37. Nota che uno "spazio vuoto" alla fine, come simbolo di controllo, non è la stessa cosa di nulla.
=== Esempio
Vogliamo codificare il messaggio 3B 82, dove 2 è il bit di controllo e lo spazio va codificato
#table(
  columns: (1fr, 2fr, 2fr),
  inset: 10pt,
  align: horizon,
  [msg], [$sum$], [$sum sum$],
  [ $w$\
    $x$\
    $y$\
    $z$
  ],
    [ $w$\
    $w + x$\
    $w + x + y$\
    $w+ x+ y+ z$
  ],
    [ $w$\
    $2w + x$\
    $3w + 2x + y$\
    $4w+ 3x+ 2y+ z$
  ]
)

Procediamo a codificare il messaggio

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  inset: 10pt,
  align: horizon,
  [da codificare],[msg], [$sum$], [$sum sum$],
  [ $3$\
    B\
    blank\
    $8$
  ],
    [ $3$\
    $11$\
    $36$\
    $8$
  ],
    [ $3$\
    $14$\
    $50$\
    $58$
  ],
    [ $3$\
    $17$\
    $67$\
    $125$
  ]
)
Adesso mi controllo se ho degli errori

3 x 5 = 15, 11 x 4 = 44, 36 x 3 = 108, 8 x 2 = 16, 2 x 1 = 2

15 + 44 + 108 + 16 + 2 = 185

*185 mod 37 = 0, quindi non ho errori*

= Secondo Teorema di shannon
== Estensione _n-esima_
Come nel caso della codifica sorgente, anche nel caso della codifica canale utilizziamo più simboli di ingresso per codificare un messaggio da trasmettere. Per far ciò, estendiamo il modello di canale in modo da considerare la trasmissione di sequenze di simboli.

Dato il canale $angle.l Chi, Y, p(y|x) angle.r$ definiamo l'estensione _n-esima_ $angle.l Chi^n, Y^n, p(y^n|x^n) angle.r$ dove la quantità $ p(y^n|x^n)$ indica la probabilità di ottenere in uscita la sequenza $y^n in Y^n$ quando è stata trasmessa
la sequenza $x^n in X^n$. Ricordiamo che essendo il canale senza memoria vale $product_(t=1)^n (y_t | x_t)$.

Ora dobbiamo costruire un codice per il nostra canale, che sarà di tipo $(M,n)$, dove:
- M = è il numero di messaggi che voglio trasmettere (ovvero il numero di simboli che voglio codificare), quindi ${1, dots, M}$ è l'insieme dei messaggi
- n = numumero di volte che utilizzo il canale
Definiamo anche due funzioni:
- Funzione di codifica $x^n: {1, dots, M} -> Chi^n$ che prende un messaggio e lo codifica in una stringa da immmettere nel canale.
- Funzione di decodifica $g: Y^n -> {1, dots, M}$ che prende una stringa ricevuta dal canale e la decodifica in un messaggio.
== Probabilità di errore di decodifica
Dato un codice canale, la probabilità di errore di decodifica del messaggio $i$ è definita come
$ lambda_i = P(g(YY^n) != i | XX^n = x^n (i)) $
In sostanza ci chiediamo qual'è la probabilità che la stringa ricevuta sia diversa da $i$ sapendo che la codifica della stringa $i$

dove $XX^n$ e $YY^n$ sono variabili casuali che indicano i simboli trasmessi e quelli ricevuti. Possiamo aggregare le probabilità di errore di singoli messaggi in due modi:
$ lambda^((n)) = max_(i = 1, dots, M) lambda_i -> "probabilità massima di errore" $
$ P_e^((n)) = 1/M sum_(i=1)^M lambda_i -> "probabilità media di errore" $
Dove ovviamente $P_e^((n)) <= lambda^((n))$
== Tasso di trasmissione (di un cod. (M,n))
Il tasso di trasmissione $R$ di un codice (M,n) è dato dal rapporto 
$ R = (log_2 M)/n $
Su un canale senza errore ho un tasso di trasmissione massimo, quindi
$ M= 2^n \ R=(log_2 2^n)/n = 1 $
#pagebreak()
== Teorema
#theorem(numbering: none, name: "Secondo teorema di shannon")[
  Sia $angle.l Chi, Y, p(y|x) angle.r$ un canale di capacità $C$. $forall R < C, "esiste una sequenza" k_1, dots k_2  $ di codici dove $k_n$ è di tipo $(2^(n R n),n)$ tale che:
$ lim_(n -> infinity) R_n = R \ e \ lim_(n-> infinity) lambda^((n)) (k_n) = 0 $
]

Possiamo interpretare il teorema nel modo seguente. Per codificare $M$ messaggi (senza assumere nulla circa la loro distribuzione) ci servono $n = ceil(log_2 M)$ bit. Quindi, se il canale non avesse rumore, trasmetteremmo al tasso massimo di $R =
1/n log_2 M = 1$ bit per uso di canale. In altritermini, senza rumore riusciamo a trasmettere senza errori fino a $2n$ messaggi diversi usando $n$ volte il canale per ogni messaggio. Se c'è rumore, il teorema ci dice che, per ogni $δ > 0$ e per ogni n abbastanza grande, usando n volte il canale riusciamo a trasmettere uno qualunque fra $2^(n(C−δ))$ messaggi con probabilità di errore che tende a zero al crescere di $n$.

In sostanza, anche se hai rumore nel canale, puoi ancora trasmettere un gran numero di messaggi con una bassa probabilità di errore, purché la velocità di trasmissione sia inferiore alla capacità del canale. La quantità δ rappresenta una piccola deviazione dalla capacità massima del canale.

