# AppGrafRelacaoLin
# server.r
library(shiny)



# --> Carregar o arquivo com os dados:
strArqDados <- "C:/Users/Eduardo/Desktop/Mestrado_UFU/Sem2_Disc2_MetodosQuant2/Seminario/Apresentacao_20161207/dadosSeminario_FINAL.csv"
dados <- read.csv2(file=strArqDados, stringsAsFactors = FALSE)
dados$AreaColhidaCana <- as.numeric(dados$AreaColhidaCana)
dados$ProdCana_ton <- as.numeric(dados$ProdCana_ton)
# --> Encolher o conjunto de dados "dados":
dados <- dados[, c(2, 4,5,6,7)]

nomes <- c("AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")



# --> Inicializar os vetores com os elementos dos gráficos:
arrTitEixoX <- c("Área (Ha)", "Produção (ton)", "Selic % a.a.", "Preço (US$/ton)")
arrParPch <- c(15, 16, 17, 18)
arrCoresPontos <- c("royalblue4", "magenta4", "red2", "seagreen4")
arrrCoresEixos <- c("royalblue1", "magenta", "red4", "seagreen1")
arrTitulosGraf <- c("VolExpAcucar_ton ~ AreaColhidaCana",
                    "VolExpAcucar_ton ~ ProdCana_ton",
                    "VolExpAcucar_ton ~ TaxaSELIC",
                    "VolExpAcucar_ton ~ PrecoAcucar")




# --> Gerar as 4 regressões e armazenar os coeficientes em dois vetores:
vetBeta0 <- as.numeric()
vetBeta1 <- as.numeric()
vetCorrel <- as.numeric()
vetStrRegs <- as.character()

for(i in 2:5){
        reg <- lm(dados[, 1] ~ dados[, i])
        vetCorrel[i-1] <- round(cor(dados[, 1], dados[, i]), digits=3)
        vetBeta0[i-1] <- round(reg$coefficients[1], digits=2)
        vetBeta1[i-1] <- round(reg$coefficients[2], digits=2)
        vetStrRegs[i-1] <- paste0("VolExpAcucar_ton = ", vetBeta0[i-1], 
                                  " + ", vetBeta1[i-1], "*", nomes[i-1], "+ ε")
}
rm(i, reg)





# --> Pegar os valores das coordenadas X e Y onde serão plotados os textos no gráfico:
# Posição no eixo-Y
posY <- max(dados$VolExpAcucar_ton)*0.9
# Posição no eixo-X
posX <- as.numeric()
posX[1] <- min(dados$AreaColhidaCana)
posX[2] <- min(dados$ProdCana_ton)
posX[3] <- min(dados$TaxaSELIC)
posX[4] <- min(dados$PrecoAcucar)


# --> Nomear os arrays criados acima:
names(arrTitEixoX) <- nomes
names(arrParPch) <- nomes
names(arrCoresPontos) <- nomes
names(arrrCoresEixos) <- nomes
names(arrTitulosGraf) <- nomes
names(vetCorrel) <- nomes
names(vetBeta0) <- nomes
names(vetBeta1) <- nomes
names(vetStrRegs) <- nomes
names(posX) <- nomes





# 
shinyServer(
        function(input, output) {
                output$grafPontos <- renderPlot({
                        # -->Plotar os pontos no gráfico:
                        plot(x=dados[,input$variavel], y=dados$VolExpAcucar_ton,
                             type="p",
                             pch=arrParPch[input$variavel],
                             col=arrCoresPontos[input$variavel],
                             main=arrTitulosGraf[input$variavel],
                             ylab="Volume Açúcar Exportando (ton)",
                             xlab=arrTitEixoX[input$variavel],
                             col.main=arrCoresPontos[input$variavel],
                             col.lab=arrrCoresEixos[input$variavel],
                             col.axis=arrrCoresEixos[input$variavel])
                        
                        # --> Plotar a reta de regressão no gráfico
                        abline(lm(dados$VolExpAcucar_ton~dados[,input$variavel]))
                        
                        # --> Escrever o texto da equação no gráfico:
                        text(posX[input$variavel], posY, vetStrRegs[input$variavel], pos=4)
                        
                        # --> Escrever em uma das margens do gráfico a correlaçaõ entre as duas variáveis:
                        texto <- paste0("ρ = ", vetCorrel[input$variavel])
                        mtext(text=texto, side=3)
                })
                
                # Texto com o modelo de regressão simples
                output$strModeloReg <- renderText({vetStrRegs[input$variavel]})
})