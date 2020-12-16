# Grid
## Resumo
### Parede
  [Parede](/Parede.pas) é um algoritmo que cria um mapa prenchido de parede, e possibilita que o jogador se mova pelos locais, onde não tem parede, funcinonando basicamente assim:
  
  Primeiro e gerado um mapa de tamanho aleatorio (entre 9 e 40) e é prenchido de paredes aleatoriamente, depois e definido uma posicao aleatoria para o jogador, logo apos imprimido o mapa e o jogador, e começa um loop que fica recebendo a tecla digitada até que seja `R` ou `escape`, mas caso a tecla seja uma das setas do teclado, o jogador e depois movido na direção do seta. caso seja apertado `R`, tudo se reinicia.
### Linha 
[Linha](/Linha.pas) é um programa, que "desenha" linhas num mapa a partir de dois pontos selecionados pelo usuario, feito para demonstrar como funciona a função `Aproximacao`, funcinonando basicamente assim: 

O começo e semelhante a [Parede](/Parede.pas), primeiro gera o mapa de tamanho aleatorio com paredes nas laterais, depois inicia o pincel e os pontos em posição aleatoria, e imprime tudo isso, e começa um loop  fica recebendo a tecla digitada até que seja `R` ou `escape`, caso a tecla digitada for um das setas do teclado, o pincel se move,  Se for 1/2, a posição do 1º ou o 2º ponto e definida como a do pincel, e `enter` cria uma linha no mapa entre os dois pontos e o mapa e imprimido novamente.

O processo de criar a linha entre os dois pontos é ficar definindo um ponto auxiliar cada vez mais proximo do 1º ponto e mais longe do 2º ponto, e cada vez que se aproxima do 2º ponto, a cordenada onde esta localizado e definida como uma parede. 

**Exemplo:**  `P1 = (0,0)` e `P2 = (0,4)`, portanto na primeira volta `aux = (0,1)` e essa cordenada e definida uma parede, na segunda volta `aux=(0,2)` que tambem sera definida uma parede e assim em diante ate auxiliar ser igual ao 2º ponto.

 [Aproximação](https://www.geogebra.org/m/f6bcprsw)

### Perseguição
O programa [Perseguição](/Perseguição.pas) e basicamente a junção das duas anteriores para criar uma especie de perseguidor que segue jogador (na verdade e o contrario, eu criei esse depois criei os outros para ficar mais simples de entender(eu acho)) por isso vou resumir e explicar so a funcionalidade do perseguidor.

 O perseguidor funcona assim: toda vez que o jogador aperta uma tecla, ele se move para a cordenada a 1 bloco de dintancia que esteja mais proxima do player, e como criar uma linha reta entre os dois toda vez que for  mover e seguir nessa linha ate o player, e possivel ver isso apagando a linha que apaga o perseguidor/`stalker` (o apagador sera apagado hua hua hua hua (Se bem que ele não apaga e sim pinta de verde)):
 ```Pascal 
 Pintar(Stalker,green);
 ```
 Então sera visivel o rastro do perseguidor, e se o player ficar parado, ia fazer uma linha, se se locomover a linha vai entortando.
 
