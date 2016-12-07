# AppGrafRelacaoLin
# ui.r


library(shiny)

# Nomes das colunas:
arrNomesCols <- c("AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")

shinyUI(fluidPage(
        sidebarPanel(
                selectInput("variavel", "Selecione a Variavel:", choices=arrNomesCols)
        ),
        mainPanel(
                plotOutput("grafPontos"),
                h3("Modelo de regressão:"),
                textOutput("strModeloReg")
        )
)
)