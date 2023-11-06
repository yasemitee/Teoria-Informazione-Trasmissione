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

= Ottimalità del codice di Huffman
== Introduzione
Ricordiamo che un codice di Huffman è costruito con il seguente sistema (Algoritmo di Huffman):
+ i simboli sorgente vengono ordinati in base alle probabilità;
+ si crea un nuovo modello di sorgente in cui i $D$ simboli meno frequenti sono rimpiazzati da un nuovo simbolo con probabilità pari alla somma delle loro probabilità;
+ se la nuova sorgente contiene più di $D$ simboli si ricomincia dal passo 1.

#v(12pt)

#figure(
    image("assets/2023-10-13_huffman-compressione.svg", width: 65%)
)
$|Chi| = m$ 

$m = (D-1)K+1$, quindi è divisibile per $D-1$ con resto 1.
#v(12pt)

Procediamo ora a dimostrare l’ottimalità del codice di Huffman nell’ambito dei codici sorgente
istantanei. Prima di dimostrare il teorema, dobbiamo però fare una semplice osservazione preliminare. Ovvero: da un codice di Huffman _D-ario_ per una sorgente di $m − D + 1$ simboli possiamo ricavare un codice di Huffman D-ario per una sorgente di $m$ simboli semplicemente sostituendo un simbolo sorgente con D nuovi simboli cosicché le probabilità assegnate ad essi siano tutte più
piccole di quelle dei rimanenti m − D vecchi simboli.

== Lemma sulla generazione con giustapposizione

#lemma(numbering:none)[
Sia $c'$ un codice _D-ario_ di Huffman per la sorgente $Chi' = {x_1, dots, x_(m-D+1)}$ con probabilità $p_1 >= dots >= p_(m-D+1)$. Sia $Chi$ la sorgente di $m$ simboli ${x_1, dots, x_(k-1), x_(k+1), dots, x_(m+1)}$ ottenuta da $Chi'$ togliendo $x_k$ e aggiungendo $D$ nuovi simboli $x_(m-D+2), dots, x_(m+1)$ con probabilità $p_(m-D+2), dots, p_(m+1)$ tali che $0 < underbrace(p_(m-D+2)"," dots"," p_(m+1), "nuove prob") < p_(m-D+1)$ e $p_(m-D+2) + dots + p_(m+1) = p_k$. Allora il codice 
$ c(x) = cases(
  c'(x) "   se" x in {x_1, dots, x_(k-1), x_(k+1), dots, x_(m-D+1)},
  c'(x_k)i " se" x = x_(m-D+i+2) "per" i = 0"," dots "," D-1.
) $
è un codice di Huffman per la sorgente $Chi$.
]
<thm>

#v(12pt)

#figure(
    image("assets/2023-10-31 esempio-lemma-huffman.svg", width: 100%)
)

#v(12pt)

In sostanza sto dicendo che se $c(x)$ è uguale a $c'(x)$ fino a $x_k$ escluso e dopo aggiunge i nuovi simboli giustapponendoli a $x_k$ (nota che $p_k = p_"simbolo1" + p_"simbolo2" + dots "in base a" D$). In pratica è come fare Huffman al contrario, quindi srotolando i simboli "fantoccio" che costituivano la somma delle D probabilità più basse.
#proof()[
  La dimostrazione è ovvia considerando che dopo il primo passo nella costruzione del codice di Huffman per $Chi$ otteniamo $Chi'$ come nuova sorgente. Quindi i due codici differiscono solo per le codifiche ai $D$ simboli $x_(m-D+2), dots, x_(m+1)$ che sono quelli meno probabili in $Chi$. Per definizione dell'algoritmo di Huffman, le codifiche dei simboli meno probabili di $Chi$ sono definite in termini del codice di Huffman per $Chi'$ esattamente come descritto nel sistema precedente.
]<proof>

== Teorema sull'ottimalità del codice di Huffman

#theorem(name:"Ottimalità del codice di Huffman", numbering:none)[
Data una sorgente $angle.l Chi, p angle.r$ con $D > 1$, il codice _D-ario_ $c$ di Huffman minimizza $EE[l_c]$ fra tutti i codici _D-ari_ istantanei per la medesima sorgente.

Quindi: $EE[l_c] <= EE[l_(c', c'', dots)]$
]<thm>

#proof()[
La dimostrazione procede per induzione.

Passo base: (per facilità nei conti consideriamo D = 2 e si ricorda che $|Chi| = m$).
Nel caso base $m = 2$ Huffman è ottimo. Infatti, intuitivamente mi basta osservare che l'algoritmo di Huffman produce il codice $c(x_1) = 0$ e $c(x_2) = 1$ che è ottimale per ogni distribuzione di probabilità su $x_1, x_2$.
Passo induttivo: Assumendo quindi $m > 2$, grazie all'ipotesi induttiva abbiamo che Huffman è ottimo per $k <= m - 1$. Fissiamo una sorgente $angle.l Chi, p angle.r$ e siano $u, v in Chi$ tale che $p(u)$ e $p(v)$ sono minime (quindi le ultime che ordineremmo nell'algoritmo di Huffman). Definiamo la sorgente $angle.l Chi', p' angle.r$ dove $u,v in Chi$ sono rimpiazzati da $z in Chi'$ e dove
$ p'(x) = cases(
  p(x) "          se" x != z,
  p(u) + p(v) " se" x =z
) $
Sia $c'$ il codice di Huffman per la sorgente $angle.l Chi', p' angle.r$. Dato che $|Chi'| = m - 1$, $c'$ è ottimo per ipotesi induttiva (Huffman è ottimo per $k <= m - 1$).

Definiamo ora il codice $c(x)$ per $Chi$.
$ c(x) = cases(
  c'(x) "  se" x in.not {u,v},
  c'(x)0 " se" x = u,
  c'(x)1 " se" x = v,
) $ _nota che c'(x)0 e c'(x)1 sono costruiti con una giustapposizione_.

Per il lemma precedente sappiamo che $c$ è un codice istantaneo di Huffman. Ora vogliamo dimostrare che $c$ è ottimale (quindi che $EE$ <= di qualsiasi codice istantaneo).

Per fare ciò abbiamo bisogno di dimostrare tre relazioni, che in seguito ci permetteranno di trarre le dovute conclusioni.

$ EE[l_c] = sum_(x in Chi) l_c (x) p(x) = sum_(x in Chi) underbracket(l_c' (x) p'(x), "identico a c per ora") - underbracket(l_c' (z) p'(z), "tolgo z") + underbracket(l_c (u) p(u) + l_c(v) p(v),"aggiungo u e v") $
$ = EE[l_c'] - l_c' (z) p'(z) + (l_c'(z) + 1)p(u) + (l_c' (z)+1)p(v) $
$ = EE[l_c'] - l_c' (z) p'(z) + l_c'(z)p'(z) + p'(z) $
$ = EE[l_c'] + p'(z) $
$ underline("Quindi" EE[l_c] = EE[l_c'] + p'(z)) $

Ora consideriamo un altro codice istantaneo $c_2$ per la medesima sorgente $angle.l Chi, p angle.r$ e verifichiamo sempre che $EE[l_c] <= EE[l_c_2]$. Fissato $c_2$, siano $r, s in Chi$ tali che $l_c_2(r)$ e $l_c_2(s)$ sono massime.

#v(12pt)

#figure(
    image("assets/2023-10-31 nodi-lmax.svg", width: 75%)
)

#v(12pt)

Esaminando le foglie $r$ e $s$ nell'albero di codifica di $c_2$, osserviamo che che senza perdita di generalità, possiamo assumere che $c_2$ sia tale che $r$ e $s$ sono fratelli. Infatti se $r$ e $s$ sono fratelli, non facciamo nulla. Se $r$ o $s$ hanno un fatello (ad esempio il fratello di $r$ è $f$), allora possiamo scegliere $r$ e $f$ tali che $l_c_2(r)$ e $l_c_2(f)$ sono massime invece di $r$ e $s$ (tanto se $f$ è fratello di $s$ allora hanno la stessa $l_c_2$). Se invece né $r$ ne $s$ hanno un fratello nell'albero, allora possiamo sostituire alla codifica di ciascun la codifica del padre finché ci riportiamo nella situazione in cui $r$ e $s$ hanno entrambi un fratello. 
Ora trasformiamo $c_2$ in un codice 
$ tilde(c)_2(x) = cases(
    c_2(x) "  se" x in.not {u,v, r, s},
    c_2(u) " se" x = r,
    c_2(r) " se" x = u,
    c_2(v) " se" x = s,
    c_2(s) " se" x = v,
) $
In pratica quello che fa $tilde(c)_2$ è sostituire la codifica dei simboli di lunghezza massima ($r$ e $s$) con quella dei simboli di lunghezza minima ($u$ e $v$). Ora dobbiamo capire quele codice tra $c_2$ e $tilde(c)_2$ "sfida" meglio $c$ (sull'ottimalità) esaminando la differenza fra la lunghezza media di questi ultimi.
$ EE[l_tilde(c)_2] - EE[l_c_2] = sum_(x in Chi) p(x)(l_tilde(c)_2 (x) - l_c_2 (x)) $
$ = p(r) l_c_2 (u) + p(u) l_c_2(r) + p(s)l_c_2(v) + p(v) l_c_2 (s) - $
$ - p(u) l_c_2 (u) - p(r) l_c_2(r) - p(v) l_c_2 (v) - p(s) l_c_2 (s) $
$ = underbrace(underbrace((p(r) - p(u)), >=0) underbrace((l_c_2(u) - l_c_2(r)),<=0) + underbrace((p(s) - p(v)), >= 0)underbrace((l_c_2(v)-l_c_2(s)), <=0), <= 0) $
I segni delle differenze sono determinati dalla scelta di $u,v,r,s$ in quanto
$ max{p(u),p(v)} <= min{p(r), p(s)}," "min{l_c_2(r),l_c_2(s)} >= max{L_c_2(u), l_c_2(v)} $
Quindi abbiamo dimostrato che $underline(EE[l_tilde(c)_2] <= EE[l_c_2])$ (lo "sfidante" migliore è $tilde(c)_2$).
]<proof>

