shinyUI(pageWithSidebar(
    headerPanel("Distributions of Random Variables"),
    sidebarPanel(
	h5('Select and see various randomly generated data for various distributions'),
        radioButtons("dist","Distribution type:",
            list("Normal"="norm","Uniform"="unif","t"="t","F"="F","Gamma"="gam","Exponential"="exp","Chi-square"="chisq","Log-normal"="lnorm","Beta"="beta")),
        sliderInput("n","Sample size:",1,1000,500),
        uiOutput("dist1"),
        uiOutput("dist2"),
        checkboxInput("density","Show density curve",FALSE),
        conditionalPanel(
            condition="input.density==true",
            numericInput("bw","bandwidth:",1)
        ),
        downloadButton('dldat', 'Download Sample')
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Histogram",plotOutput("histo")),
            tabPanel("Density",plotOutput("dens")),
            tabPanel("Summary",verbatimTextOutput("summary"),plotOutput("boxp")),
            tabPanel("Table",tableOutput("table"))
        )
    )
))
