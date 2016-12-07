# AppGrafST
# server.r
library(shiny)

# Carregar o arquivo com os dados:
strArqDados <- "C:/Users/Eduardo/Desktop/Mestrado_UFU/Sem2_Disc2_MetodosQuant2/Seminario/Apresentacao_20161207/dadosSeminario_FINAL.csv"
dados <- read.csv2(file=strArqDados, stringsAsFactors = FALSE)
dados$AreaColhidaCana <- as.numeric(dados$AreaColhidaCana)
dados$ProdCana_ton <- as.numeric(dados$ProdCana_ton)


# --> Inicializar os vetores com os elementos dos gráficos:
arrCoresLinha <- c("chocolate4", "royalblue4", "magenta4", "red2", "seagreen4")
arrCoresEixos <- c("chocolate", "royalblue1", "magenta", "red4", "seagreen1")
arrTitulosGraf <- c("Volume Açúcar Exportando (ton)", 
                    "Área Colhida de Cana (Ha)", 
                    "Produção de Cana (ton)", 
                    "Taxa Selic (% a.a.)", 
                    "Preço do Açúcar (US$/ton)")
arrTitEixoY <- c("Toneladas", "Hectares", "Toneladas", "% a.a.", "Preço (US$/ton)")



# Nomear os elementos dos vetores:
names(arrCoresLinha) <- c("VolExpAcucar_ton", "AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")
names(arrTitulosGraf) <- c("VolExpAcucar_ton", "AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")
names(arrTitEixoY) <- c("VolExpAcucar_ton", "AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")
names(arrCoresEixos) <- c("VolExpAcucar_ton", "AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")





# 
shinyServer(function(input, output) {
        output$grafST <- renderPlot({
                plot(x=dados$Ano, y=dados[,input$variavel], 
                     type="l", lwd=2, col=arrCoresLinha[input$variavel],
                     main=arrTitulosGraf[input$variavel], 
                     ylab=arrTitEixoY[input$variavel],
                     xlab="Ano", 
                     col.main=arrCoresLinha[input$variavel],
                     col.lab=arrCoresEixos[input$variavel],
                     col.axis=arrCoresEixos[input$variavel])
                
                # Caso selecionada a opção de inserir a média
                if(input$insereMedia){
                        abline(h=mean(dados[,input$variavel]), lty=2)
                }
        })
        
        
})