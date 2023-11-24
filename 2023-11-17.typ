== Canale BEC - Canale Binario ERASER
Si tratta di un canale binario a cancellazione con $Chi = {0,1}$ e $Y = {0,1,e}$, dove $e$ indica la perdita di un simbolo o meglio la cancellazione di un simbolo (eraser). Il canale BEC è definito nel seguente modo:
#v(12pt)

#figure(
    image("assets/2023-11-17 canale-eraser.png", width: 15%)
)

#v(12pt)
Proviamo ora come negli altri casi a ricavare la _capacità di canale_, vogliamo quindi $C = max_p(x) H(YY) - H(YY | XX)$.

1) $H(YY | XX) = P(x=0) dot H(YY | XX = 0) + P(XX=1) dot H(YY | XX = 1)$

Notiamo subito che $P(XX=0) + p(XX=1)=1$ quindi per simmetria $H(YY | XX = 0) = H(YY | XX = 1) = H(alpha)$

Quindi abbiamo che $C = max_p(x) H(YY) - H(YY | XX)$

2) Per trovare $H(YY)$ abbiamo bisogno di introdurre un bernoulliana
$ ZZ = cases(
  1 " se" YY = e,
  0 " altrimenti"
) $
Ora notiamo che 
$ H(YY,ZZ) = H(YY) + H(ZZ | YY) = H(YY) $
$ "questo perché" $
$ H(YY,ZZ) = H(YY) + underbrace(H(ZZ | XX),0) $
Quindi ora per ricavare $H(YY)$ dobbiamo trovare $H(ZZ)$ e per fare ciò basta osservare che
$ H(ZZ = 1) = underbracket(P(XX=0) dot H(ZZ = 1 | XX = 0),alpha) + underbracket(P(XX=1) dot H(ZZ = 1 | XX = 1),alpha) = alpha $
$ H(ZZ = 0) = 1 - alpha $

$ ZZ = cases(
  alpha "       se" YY = e,
  1-alpha "  altrimenti"
) $
Ora possiamo concludere
$ H(YY | ZZ) = underbracket(P(ZZ = 0), 1- alpha) dot underbracket(H(YY | ZZ = 0), H(XX)) + underbracket(underbracket(P(ZZ = 1), alpha) dot underbracket(H(YY | ZZ = 1),0),0) $
$ H(YY | ZZ) = (1 - alpha) dot H(XX) $
$ H(YY) = H(alpha) + (1-alpha) H(XX) $
$ =  $
Quindi 
$ C= max_p(x) ((1-alpha) dot H(XX)) - H(alpha) $
$ = (1-alpha) max_p(x) H(XX) = 1- alpha $
