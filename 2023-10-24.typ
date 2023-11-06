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

= Primo teorema di Shannon

Il prossimo risultato rivela che i codici di Shannon forniscono una descrizione delle realizzazioni di X di lunghezza media quasi ottimale rispetto a tutti i codici istantanei.


== Introduzione

#lemma(numbering: none)[Per ogni sorgente $angle.l Chi, p angle.r$ con $Chi = {x_1, dots, x_m}$ e $p = {p_1, dots, p_n}$. Dato il codice istantaneo di Shannon $c$ con lunghezze $l_i = l_c (x_i)$ tali che $l_i = ceil(log_D 1/p_i)$ per $i = 1,dots, m$, vale $ EE[l_c] < H_D (Chi) + 1 $
]<thm>
Quindi con questo teorema, Shannon capisce che il suo codice paga al più 1 bit in più di informazione aggiuntivo.

#proof[ 
$ EE[l_c] = sum_(i=1)^n p_i ceil(log_D 1/p_i) < sum_(i=1)^n p_i (log_D 1/p_i + 1) $ 
$ = H_D(Chi) + 1 $
]<proof>
Quindi, combinando questo risultato con $EE[l_i] >= H_D (Chi)$ _che vale per ogni codice istantaneo $c$_, otteniamo che il codice di Shannon utilizza un numero di bit che è compreso tra l'entropia e una variabile additiva di 1 bit, in altre parole si avvicina al codice teorico migliore (entropia) sprecando nel caso peggiore un simbolo in più del necessario.

Tuttavia sorge un problema, perché l'inefficienza dei codici di Shannon cresce linearmente con la lunghezza del messaggio da codificare. Infatti, la lunghezza della codifica di Shannon di un messaggio $(x_1,dots, x_n)$, generato con $n$ estrazioni da una sorgente $angle.l Chi, p angle.r$, è pari a $ sum_(i=1)^n ceil(log_D 1 / p(x_i)) $
Per risovere questa situazione possiamo usare una tecnica nota come *codifica a blocchi*
== Codifica a blocchi
=== Definizione
La codifica a blocchi suddivide ogni messaggio in blocchi di simboli sorgente dove ogni blocco ha
la stessa lunghezza. I blocchi vengono quindi codificati con un codice per la sorgente i cui simboli sono tutti i possibili blocchi di lunghezza data.
Quindi a partire dalla nostra sorgente $angle.l Chi, p angle.r$ avendo $C: Chi -> D^+$ _estensione del codice_, vale che $l_c (x_1,dots, x_n)$  = $sum_(i = 1)^n ceil(log_D 1/p_i) = log_D ceil(1/(product_(i = 1)^n p(x_i)))$ quindi in $l_c (x_1,dots, x_n) = log_D ceil(1 / P(x_i, dots, x_n))$, Questo definisce il modello $angle.l Chi^n, P_n angle.r$ con codice $C_n: Chi^n -> D^n$, dove $Chi^n$ è l'insieme di $n"-uple" (x_1,dots, x_n)$ di simboli di $Chi$ e $P_n$ è la distribuzione su $Chi^n$ associata a $n$ estrazioni identicamente distribuite secondo $p$. 

Quindi Shannon sta spostando il problema alla sorgente, da $angle.l Chi, p angle.r$ a $angle.l Chi^n, P_n angle.r$.
 === Entropia su $P_n$
 Sia $Chi$ una variabile casuale con distribuzione $p$,lavorando con la codifica a blocchi abbiamo $Chi_1,dots, Chi_n$ variabili casuali anch'esse con distribuzione $p$.

 Abbiamo che $P_n (x_1, dots, x_n) = product_(i = 1)^n p(x_i)$ definiamo l'entropia 
 $ H(Chi_1, dots, Chi_n) = sum_(x_1, dots, x_n) P_n (x_1,dots, x_n)log_2 1/(P_n (x_1, dots, x_n)) $ _notiamo che il primo termine della moltiplicazione è un produttoria e il secondo possiamo ridurlo a $sum_(i = 1)^n log_2 1/(p(x_i))$_, quindi ricavo che 
 $ H(Chi_1, dots, Chi_n) = sum_x_1, dots, sum_x_n (product_(i=1)^n p(x_i))sum_(i=1)^n log_2 1/(p(x_i)) $ $ = sum_(i=1)^n sum_x_i p(x_i) log_2 1/p(x_i) $
 $ = n H(Chi) $
 Quindi sto sommando la stessa entropia, cioè l'entropia della sorgente a blocchi di $n$ simboli è $n$ volte l'entropia della sorgente base. 
 
 Siamo ora pronti per enunciare e dimostrare il vero primo teoreama di Shannon o _source coding_.

 == Teorema (Primo teorema di Shannon)
 #theorem(name: "Primo teorema di Shannon", numbering: none)[
 Sia $C_n: Chi^n -> D^+$ un codice di Shannon D-ario a blocchi per la sorgente $angle.l Chi, p angle.r$, ossia $l_c (x_1, dots, x_n) = ceil(log 1/P(x_1, dots, x_n))$ allora 
 $ lim_(n->oo) 1/n EE[l_C_n] = H_D (Chi) $
 ]<thm>
 Questo risultato dimostra che se codifichiamo con Shannon a blocchi, allora la lunghezza media della parola di codice per simbolo sorgente è asintotica all'entropia quando la lunghezza del blocco cresce all'infinito, _in altre parole il codice di Shannon diventa asintoticamente ottimo_.

#proof[
 Osserviamo che vale
 $  H_D (x_1, dots, x_n) <= EE[l_c] <= H_D (x_1, dots, x_n) + 1 $
 $ = n H_D (x) <= EE[l_c] <= n H_D (x) + 1 $
 _Dividendo entrambi i mebri per n otteniamo_
 $ H_D (x) <= EE[l_c] <= H_D (x) + 1/n $
 Da quest'ultima relazione ricaviamo l'enunciato del teorema. 
]<proof>
 Quindi Shannon dimostra che in assenza di rumore, codificando a blocchi $EE$ si "schiaccia" verso l'entropia, _quindi più grande è il blocco più grande è il vantaggio_.

 == Significato operativo all'entropia relativa
 Un fatto che per ora non abbiamo mai considerato è che in realtà il modello teorico di Shannon $angle.l Chi, p angle.r$ è un modello (troppo) ideale, nella realtà $p$ non la conosciamo (nella maggior parte dei casi), quindi è necessario fare una stima usando un altro modello $angle.l Y, q angle.r$ che simula il modello $Chi$. Quindi ora che abbiamo associato l’entropia alla lunghezza minima media di codici istantanei, diamo un analogo significato operativo all’entropia relativa, mostrando che essa corrisponde alla differenza fra la lunghezza media di un codice di Shannon costruito sul modello di sorgente $Chi$ e quello di un codice di Shannon costruito su un diverso modello di sorgente $Y$.

#theorem()[
 Dato un modello sorgente $angle.l Chi, p angle.r$, se $c: Chi -> D^+$ è un codice di Shannon con lunghezze $l_c (x) = ceil(1/q(x))$, dove $q$ è una distribuzione arbitraria su $Chi$, allora
 $ EE [l_c] < H_D (Chi) + D(X||Y) + 1 $
 dove $Chi$ ha distribuzione $p$ e $Y$ ha distribuzione $q$.
]<thm>

 #proof[
 Osserviamo che 
 $ EE[l_c] = sum_(x in Chi) p(x) ceil(log_D 1/q(x)) < sum_(x in Chi) p(x) log_D 1/q(x) + 1 $
 $ = sum_(x in Chi) p(x) log_D (1/q(x) p(x)/p(x)) +1 = sum_(x in Chi) p(x) log_D (p(x)/p(x) 1/p(x)) + 1 $
 $ = sum_(x in Chi) p(x) log_D p(x)/q(x) + sum_(x in Chi) p(x) log_D 1/p(x)+1 $
 $ = D(Chi || Y) + H_D (Chi)+1 $
 ]<proof>