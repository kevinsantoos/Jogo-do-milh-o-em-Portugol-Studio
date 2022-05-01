programa
{	
		
	// Kevin Sousa dos Santos RA: 1680482122002
	// Guilherme Vieira Pena RA: 1680482122037
	
	inclua biblioteca Sons --> s
	inclua biblioteca Tipos -->t
	inclua biblioteca Util --> ut
	inclua biblioteca Arquivos --> arq
	inclua biblioteca Texto --> txt
	
	cadeia perguntas[100],tema[100],resposta_correta[100],alternativa1[100],sorteados[100]
	cadeia alternativa2[100],alternativa3[100],alternativa4[100],nomeArq,nome_musica
	inteiro temaJogo, qtdperguntas, cont, resposta_corretaI[100]
	inteiro resposta_jogador[10],sorteio=0, Contagem_sorteio[100],Numero_pergunta = 0
	inteiro numero_elementos,erros= 0,acertos=0
	real resposta_corretaR[100]
	caracter resp, modoJogo
	
	funcao inicio()
	{
		introducao()
		jogo()
	}
	
	funcao introducao(){
		
		inteiro posicaoP[100],posicaoT[100],posicaoR[100],posicaoA1[100]
		inteiro posicaoA2[100],posicaoA3[100],posicaoA4[100]
		inteiro refArq, refMus
		cadeia linha[100]


				nomeArq = "./quiz.txt"
				//Verificar se o arquivo existe
				se(nao arq.arquivo_existe(nomeArq)) 
				{
				escreva("O arquivo ", nomeArq, " não existe...")
				retorne 				
				}
				refArq = arq.abrir_arquivo(nomeArq, arq.MODO_LEITURA)	
								
				//Adicionar musica
				nome_musica = "./musica.mpeg"
				//Verificar se o arquivo musica existe
				se(nao arq.arquivo_existe(nome_musica)) 
				{
				escreva("O arquivo ", nome_musica, " não existe...")
				retorne 								
				}
				refMus = s.carregar_som(nome_musica)			
				s.reproduzir_som(refMus, verdadeiro)
				s.definir_volume(50)
							
			
			//faz um laço que irá ler o arquivo até o final e armazenar as perguntas e respostas em  vetores.		
			para( cont=0; cont<= 99; cont++){
			//lê a próxima linha
			linha[cont] = arq.ler_linha(refArq)
			//se linha lida for vazia, não imprime
			se(txt.numero_caracteres(linha[cont]) != 0){				
			//Encontrar posição do primeiro pipe
			posicaoP[cont] =  txt.posicao_texto("|", linha[cont], 0)
			//Encontrar posicao do segundo pipe
			posicaoT[cont] = txt.posicao_texto("|", linha[cont], posicaoP[cont]+1)
			//Armazenar a pergunta junto com o tema em um vetor
			perguntas[cont] = txt.extrair_subtexto(linha[cont], 0,posicaoT[cont])
			//Armazenar os temas em um vetor único
			tema[cont] = txt.extrair_subtexto(linha[cont], posicaoP[cont]+1, posicaoT[cont])
			//Encontrar posicao e Armazenar as respostas corretas
			posicaoR[cont] = txt.posicao_texto("|",linha[cont], posicaoT[cont]+1)
			resposta_correta[cont] = txt.extrair_subtexto(linha[cont], posicaoT[cont]+1, posicaoR[cont])
			//Trasformando a resposta correta de cadeia para inteiro		
			resposta_corretaR[cont] = t.cadeia_para_real(resposta_correta[cont])
			resposta_corretaI[cont] = t.real_para_inteiro(resposta_corretaR[cont])
			//Encontrar posicao e Armazenar a alternativa 1
			posicaoA1[cont] = txt.posicao_texto("|", linha[cont], posicaoR[cont]+1)
			alternativa1[cont] = txt.extrair_subtexto(linha[cont], posicaoR[cont]+1, posicaoA1[cont])
			//encontrar posicao e Armazenar a alternativa 2
			posicaoA2[cont] = txt.posicao_texto("|", linha[cont], posicaoA1[cont]+1)
			alternativa2[cont] = txt.extrair_subtexto(linha[cont], posicaoA1[cont]+1, posicaoA2[cont])
			//Encontrar posicao e Armazenar a alternativa 3
			posicaoA3[cont] = txt.posicao_texto("|", linha[cont], posicaoA2[cont]+1)
			alternativa3[cont] = txt.extrair_subtexto(linha[cont], posicaoA2[cont]+1, posicaoA3[cont])
			//Armazenar a alternativa 4
			posicaoA4[cont] = txt.numero_caracteres(linha[cont])
			alternativa4[cont] = txt.extrair_subtexto(linha[cont], posicaoA3[cont]+1, posicaoA4[cont])
			}
		}			
				//Depois de armazenar todo o arquivo, fechar ele
				arq.fechar_arquivo(refArq)
				
			faca{//Laço para so sair do "Bem vindo", caso digite 'S' ou 'N'			
			escreva("*--------------Bem Vindo----------------*\n")
        		escreva("|                                       |\n")
        		escreva("|                                       |\n") 
        		escreva("|         Voçê está preparado?          |\n")
        		escreva("|                                       |\n")
        		escreva("|                                       |\n")
        		escreva("|           (S)im  ou (N)ão             |\n")
       		escreva("|                                       |\n")
        		escreva("*---------------------------------------*")
        		escreva("\n")
        		leia(resp)
        		       	 			
			}enquanto(resp != 's' e resp != 'S'e resp != 'n' e resp != 'N' )
									
			//Escolher o tema que sera jogado, Caso o jogador esteja preparado
			escolha(resp){
			caso 's':
			caso 'S':	
					faca{
						limpa()
					//diferencial, modo de jogo misto 
					escreva("*------------------------*\n")
					escreva("|                        |\n")
					escreva("|  Deseja jogar o modo:  |\n")
					escreva("|                        |\n")
					escreva("|   [N]ormal  [M]isto    |\n")
					escreva("|                        |\n")
					escreva("*------------------------*\n")	
					leia(modoJogo)

					}enquanto(modoJogo != 'n' e modoJogo != 'N' e modoJogo != 'm' e modoJogo != 'M')
					
					se(modoJogo == 'n' ou modoJogo == 'N'){
						faca{//Laço para escolher o tema de 1 a 10					
							escreva("\nEscolha o tema desejado:")					
							escreva("\nCaso",tema[5],"digite 1:")
							escreva("\nCaso",tema[15],"digite 2:")
							escreva("\nCaso",tema[25],"digite 3:")
							escreva("\nCaso",tema[35],"digite 4:")
							escreva("\nCaso",tema[45],"digite 5:")	
							
							//Se o arquivo txt tiver menos que 5 temas, não mostrar as demais opções 
							se(tema[55] != ""){
								escreva("\nCaso",tema[55],"digite 6:")					
							}
							se(tema[65] != ""){
								escreva("\nCaso",tema[65],"digite 7:")													
							}
							se(tema[75] != ""){
								escreva("\nCaso",tema[75],"digite 8:")
							}
							se(tema[85] != ""){
								escreva("\nCaso",tema[85],"digite 9:")	
							}
							se(tema[95] != ""){
								escreva("\nCaso",tema[95],"digite 10:")	
							}
							escreva("\n")						
							leia(temaJogo)
									
					}enquanto (temaJogo <1 ou temaJogo>10)
				}			
						limpa()															
						mensagem("\n     Ótima escolha!!")
						ut.aguarde(900)
						pare							
					
				caso 'n':
				caso 'N':
					escreva("Poxa que pena!!")
					retorne 																			
				}	
			   	escreva("\n\n")
			   	limpa()
				faca{
					escreva("\nQuantas perguntas você deseja responder ? ")
					escreva("\nEscolha no mínimo 5 perguntas e no máximo 10\n")	
					leia(qtdperguntas)		
					}enquanto(qtdperguntas <5 ou qtdperguntas > 10)

					limpa()
					mensagem1("Muito bem, vamos iniciar!!")
					ut.aguarde(2000)
					limpa()
			}				

				funcao jogo(){	
						
				se(nao arq.arquivo_existe(nomeArq)){									
					retorne 
				}
				se(nao arq.arquivo_existe(nome_musica)){									
					retorne 
				}
				se(resp == 'n' ou resp == 'N'){
					retorne
				}
					
				//Modo misto
				para(cont=0 ;cont < qtdperguntas ; cont ++){
					se(modoJogo ==  'M' ou modoJogo == 'm'){
					temaJogo = 0
															
					//Sorteio que pode caior perguntas de qualquer tema
					faca{//Laço para não repetir sorteio e não cair em numero vazio do vetor				
							sorteio = ut.sorteia(0, 99)																						
							se(sorteados[sorteio] == "lidos"  ou perguntas[sorteio] == "")
								sorteio = ut.sorteia(0, 99)																										
					}enquanto(sorteados[sorteio] == "lidos" ou perguntas[sorteio] == "" )	
					Numero_pergunta ++									
					alternativas()		
				}												
			}							
			//Laço para mostrar as perguntas e alternativas de acordo com o tema
			para(cont=0 ;cont < qtdperguntas ; cont ++){
											
				escolha(temaJogo){
						
				caso 1:
					//Sortear as perguntas do tema 1	
					sorteio = ut.sorteia(0, 9)
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(0, 9)	
					}enquanto(sorteados[sorteio] == "lidos")	
					Numero_pergunta ++				
					alternativas()					
					pare
		
				caso 2:	
					//Sortear as perguntas do tema 2
					sorteio = ut.sorteia(10, 19)
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(10, 19)	
					}enquanto(sorteados[sorteio] == "lidos")
					Numero_pergunta ++																																						
					alternativas()
					pare
				
				caso 3:	
					//Sortear as perguntas do tema 1					
					sorteio = ut.sorteia(20, 29)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(20, 29)	
					}enquanto(sorteados[sorteio] == "lidos")
					Numero_pergunta ++	
					alternativas()																																												
					pare
				
				caso 4:
					//Sortear as perguntas do tema 4	
					sorteio = ut.sorteia(30, 39)
  					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(30, 39)	
					}enquanto(sorteados[sorteio] == "lidos")
					Numero_pergunta ++	
					alternativas()																																												
					pare
				
				caso 5:	
					//Sortear as perguntas do tema 5					
					sorteio = ut.sorteia(40, 49)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(40, 49)	
					}enquanto(sorteados[sorteio] == "lidos")
					Numero_pergunta ++																																							
					alternativas()					
					pare
				
				caso 6:	
					//Sortear as perguntas do tema 6					
					sorteio = ut.sorteia(50, 59)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(50, 59)	
					}enquanto(sorteados[sorteio] == "lidos")	
					Numero_pergunta ++																																						
					alternativas()					
					pare
				
				caso 7:
					//Sortear as perguntas do tema 7	
					sorteio = ut.sorteia(60, 69)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(60, 69)	
					}enquanto(sorteados[sorteio] == "lidos")	
					Numero_pergunta ++																					
					alternativas()																																										
					pare
				
				caso 8:	
					//Sortear as perguntas do tema 8
					sorteio = ut.sorteia(70, 79)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(70, 79)	
					}enquanto(sorteados[sorteio] == "lidos")	
					Numero_pergunta ++																																																						
					alternativas()																																						
					pare
					
				caso 9:	
					//Sortear as perguntas do tema 9
					sorteio = ut.sorteia(80, 89)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(80, 89)	
					}enquanto(sorteados[sorteio] == "lidos")
					Numero_pergunta ++					
					alternativas()																																										
					pare
					
				caso 10:					
					//Sortear as perguntas do tema 10
					sorteio = ut.sorteia(90, 99)	
					faca{//Laço para não repetir o sorteio
						se(sorteados[sorteio] == "lidos")
							sorteio = ut.sorteia(90,99)	
					}enquanto(sorteados[sorteio] == "lidos")	
					Numero_pergunta ++						
					alternativas()																																												
					pare						
				}									
			}	
				limpa()
				//Estatísticas finais				
				escreva("\nVamos agora ver as estatísticas\n")
				ut.aguarde(2000)
				//laço para mostrar as perguntas respondidas pelo jogador e as respostas certas
				para(cont=0;cont <qtdperguntas;cont++){	
					escreva("\n",perguntas[Contagem_sorteio[cont]],"\n",alternativa1[Contagem_sorteio[cont]],"-",alternativa2[Contagem_sorteio[cont]],"-",
					alternativa3[Contagem_sorteio[cont]],"-",alternativa4[Contagem_sorteio[cont]])
					//Verificar se a resposta dada está certa e mostrar 		
					se(resposta_jogador[cont] == resposta_corretaI[Contagem_sorteio[cont]]){
						escreva("\nVoce acertou, Sua resposta: ",resposta_jogador[cont]," - ","Resposta correta: ",resposta_corretaI[Contagem_sorteio[cont]])
								acertos ++		
						}
						senao{
						escreva("\nVoce não acertou, Sua resposta: ",resposta_jogador[cont]," - ","Resposta correta: ",resposta_corretaI[Contagem_sorteio[cont]])								
								erros ++	
						}	
							escreva("\n\n") 						
					}			
						escreva("\n╭━━┳━┳━┳╮ "," Você errou: ",erros)		
						escreva("\n━┫╱┓┣┳━━━╯"," Você acertou: ", acertos)
						escreva("\n╱╱╱┃┃╯    ")
						escreva("\n━┫╱╰┛╯    ")
						escreva("\n╱╰━━━╯    ")	
	
						caracter resp2
						
							//jogar novamente ou parar o jogo
							faca{
								escreva("Deseja jogar novamente? (S) ou (N): ")
								leia(resp2)
							escolha(resp2){
								caso 's':
								caso 'S':
									limpa()
									//Limpar dados para novo Jogo
									acertos = 0
									erros = 0
									Numero_pergunta = 0
										para(cont = 0; cont<100; cont++){
											sorteados[cont] = "limpo"
										}
									inicio()
									pare
								caso 'n':
								caso 'N':
									retorne
								}
							}enquanto(resp2 != 's' e resp2 != 'S' e resp2 != 'n' e resp2 != 'N')
				}	
			funcao alternativas(){
			//laço para so aceitar Alternativa de 1 a 4
				sorteados[sorteio] = "lidos"
				Contagem_sorteio[cont] = sorteio
				faca{					
				//Limpar questão anterior				
				limpa()
				escreva(Numero_pergunta,") ",perguntas[sorteio])
				escreva("\nAlternativa 1: ",alternativa1[sorteio])
				escreva("\nAlternativa 2: ",alternativa2[sorteio])
				escreva("\nAlternativa 3: ",alternativa3[sorteio])
				escreva("\nAlternativa 4: ",alternativa4[sorteio],"\n")
				leia(resposta_jogador[cont])			
				}enquanto(resposta_jogador[cont] < 1 ou resposta_jogador[cont] > 4)	
												
			}
			funcao mensagem(cadeia texto){		
				escreva("\n*======================*")
				escreva("",texto,         "\n")
				escreva("*=======================*\n")					
				}

			funcao mensagem1(cadeia texto1){
				escreva("*==========================*\n")
				escreva("|                          |\n")
				escreva("|", "", texto1,           "|\n")
				escreva("|                          |\n")
				escreva("*==========================*\n")
				}
		
			funcao mensagem2(cadeia texto2){
				escreva("*==============*\n")
				escreva("|", texto2,  "|\n")
				escreva("*==============*\n\n")  
				}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 267; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */