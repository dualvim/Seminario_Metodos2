# AppGrafST
# ui.r

library(shiny)

# Nomes das colunas:
arrNomesCols <- c("VolExpAcucar_ton", "AreaColhidaCana", "ProdCana_ton", "TaxaSELIC", "PrecoAcucar")

shinyUI(fluidPage(
        sidebarPanel(
                selectInput("variavel", "Selecione a Variavel:", choices=arrNomesCols),
                checkboxInput(inputId="insereMedia",
                              label="Inserir linha com a média:",
                              value=FALSE)
        ),
        mainPanel(
                plotOutput("grafST")
        )
)
)