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

= Disuguaglianza di Kraft-McMillan
== Introduzione
Nelle scorse lezioni abbiamo visto prima il codice di Shannon che in media si comporta bene e in seguito i codici di Huffman, che sono i migliori codici istantanei possibili, nel senso che minimizzano il valore atteso della lunghezza media delle parole di codice. D'altro canto abbiamo osservato nella gerarchia dei codici che riducendo l'insieme da cui andiamo a scegliere un codice, spesso guadagniamo una proprietà (ad esempio per i cod. inst. la decodifica istantanea) a discapito di una maggiore lunghezza media delle parole di codice, quindi ci chiediamo se esiste un codice univocamente decodificabile (che perde la proprietà di essere decodificabile istantaneamente) che si comporti meglio del codice di Huffman. Il prossimo risultato mostra invece che il miglior codice univocamente decodificabile non è meglio del codice di Huffman. 

Prima di procedere, introduciamo l'estensione _k-esima_ di un codice $c:Chi -> D^+$ come $C_k: Chi^k ->D^+$ definita come
$ C_k(x_1, dots, x_k) = c(x_1), dots, c(k) $
$ "avente" $
$ l_C_k (x_1, dots, x_k) = l_c(x_1)+ dots +l_c(x_k) $
Chiaramente se $c$ è univocamente decodificabile, la sua estensione _k-esima_ è non singolare per ogni $k >= 1$.
== Definizione
#theorem(name: "Disuguaglianza di Kraft-McMillan", numbering: none)[
$l_1, dots, l_m in NN$ sono le lunghezze di un codice _D-ario_ univocamente decodificabile per una sorgente di $m$ simboli se e solo se
$ sum_(i=1)^m D^(-l_i) <= 1 $
]<thm>
#proof[
Valendo la disuguaglianza di kraft per le lunghezze sappiamo che sono le lunghezze di un codice istantaneo (come abbiamo già dimostrato).

Ora dobbiamo dimostrare che se $c:Chi -> D^+$ è univocamente decodificabile allora le sue lunghezze $l_c (x_1), dots, l_c (x_m)$ soddisfano la disuguaglianza di Kraft. Quindi per ogni $k >= 1$ vale che
$ (sum_(x in Chi) D^(-l_c (x)))^k = sum_(x_1 in Chi) dots sum_(x_k in Chi)  D^(-l_c (x_1)) times dots times D^(-l_c (x_k)) $
$ =  sum_((x_1, dots, x_k) in Chi) D^(-l_C_k (x_1,dots, x_k)) $
Ora introduciamo l'insieme $Chi_n ^ k subset.eq Chi^k$ di tutti i messaggi che vengono codificati in parole di codice di lunghezza $n$, così definito
$ Chi_n ^ k = {(x_1, dots, x_k) in Chi^k : l_C_k (x_1, dots,x_k) = n} $
Quindi ad esempio per $n = 1$
$ Chi_n ^ k = (x_1, dots, x_k) = 1 $
Possiamo allora scrivere
$ sum_((x_1, dots, x_k) in Chi^k) D^-l_C_k (x_1, dots,x_k) = sum_(n = 1)^(k l_max) sum_((x_1, dots, x_k) in Chi_n ^ k) D^(-l_C_k)(x_1, dots, x_k) = sum_(n=1)^(k l_max) |Chi_n ^ k| D^(-n) $ dove $l_max = max( l_c (x_i))$ con $i = 1, dots, m.$

Ora, siccome $c$ è univocamente decodificabile, $C_k$ è non singolare per ogni $k >= 1$. Ciò implica che $Chi_n^k$ non può contenere più elementi di $D^n$, altrimenti verrebbe violata l'ipotesi di iniettività. Quindi $|Chi_n ^k| <= |D^n| = D^n$. Questo ci permette di scrivere
$ underbrace((sum_(x in Chi) D^(-l_c)(x))^k, M >= 0) <= sum_(n=1)^(k l_max) |Chi_n ^ k| D^(-n) <= sum_(n=1)^(k l_max) cancel(D^n) cancel(D^(-n)) = k l_max $
$ "può essere riscritta come" M^k <= k l_max $
Quindi la relazione sopra vale per ogni $k >= 1$, se $M > $1 ci sarebbe un $k_0$ tale che per ogni $k >= k_0$ si avrebbe $M^k >= k l_max$. Qundi $M <= 1$
]<proof>
Graficamente:
#v(12pt)

#figure(
    image("assets/2023-11-03 dimostrazione-McMillan.svg", width: 100%)
)

#v(12pt)

Quindi non cambia la situazione prendendo un codice univocamente decodificabile anziché usare un codice istantaneo, di conseguenza è meglio usare un codice istantaneo dato che sono decodificabili istantaneamente.
