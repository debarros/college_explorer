#college explorer UI file

source("uiElements.R")

# basically, I have one page filled with a leaflet map and one absolutePanel filled with rows and columns

shinyUI(bootstrapPage(
  theme="bootstrap.css",  useShinyjs(),  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),  tags$head(includeScript("google_analytics.js")),
  
  # The leadflet map (in the background) ####
  leafletOutput("map", width = "100%", height = "100%"),
  
  # The control panel (in the foreground) ####
  absolutePanel(
    id = "controls", class = "panel panel-default", fixed = T, draggable = T, top = 50, left = "auto", right = 20, bottom = "auto", width = 490, height = "auto",
    
    # check boxes to select types of schools ####
    fluidRow(column(7, div(style = "display:inline-block", h3("College Explorer v0.3"))),
             column(5, h6("(", textOutput("num_matching", inline = T), "schools selected)", style = "padding:20px 0 0 0;"))),
    
    fluidRow(column(4, checkboxGroupInput("ownershiptype", label = NULL, c("Public" = 1, "Private non-profit" = 2, "Private for-profit" = 3), selected = c(1, 2, 3))),
             column(5, checkboxGroupInput("type", label = NULL, SchTyps, selected = SchTyps)),
             column(3, checkboxInput("online", "Online Only", T))),
    
    # sliders to set various criteria ####
    fluidRow(column(6, sliderInput("selectivity", "Selectivity (rejection rate):", min = 0, max = 100, step = 1, value = c(0, 100), dragRange = F, ticks = F, post = "%")),
             column(2, checkboxInput("selectivityNA", label = "Include NAs?", T))),
    
    # the UI below uses shinyjs which allows the UI (sliders) to "unfold" when the title is clicked
    
    hider(title = "Filter on size", ID = "size",
          slide1 = sliderInput("size", "Undergrad size", min = 0, max = 35000, value = c(0, 35000), step = 1000, ticks = F),
          slide2 = sliderInput("totsize", "Total size", min = 0, max = 35000, value = c(0, 35000), step = 1000, ticks = F)),
    
    hider(title = "Filter on SAT scores", ID = "SAT",
          slide1 = sliderInput("satvr", "75th Pctile Verbal SAT", min = 300, max = 800, value = c(300, 800), step = 10, ticks = F),
          slide2 = sliderInput("satmt", "75th Pctile Math SAT", min = 300, max = 800, value = c(300, 800), step = 10, ticks = F)),
    
    hider(title = "Filter on price", ID = "price",
          slide1 = sliderInput("tuition", "Tuition and fees", min = 0, max = 60000, step = 1000, ticks = F, pre = "$", value = c(0, 60000)),
          slide2 = sliderInput("netprice", "Average Net Price", min = 0, max = 50000, step = 1000, value = c(0, 50000), ticks = F, pre = "$")),
    
    hider(title = "Filter on outcomes", ID = "outcomes", 
          slide1 = sliderInput("gr", "Graduation Rate", min = 0, max = 100, step = 1, ticks = F, post = "%", value = c(0, 100)),
          slide2 = sliderInput("retention", "Retention Rate", min = 0, max = 100, step = 1, value = c(0, 100), ticks = F, post = "%")),
    
    hider(title = "Filter on financial outcomes", ID = "finoutcomes", 
          slide1 = sliderInput("salary", "Med Salary (6yrs)", min = 5000, max = 125000, step = 5000, ticks = F, pre = "$", value = c(5000, 125000)),
          slide2 = sliderInput("default", "Default Rate", min = 0, max = 100, step = 1, value = c(0, 100), ticks = F, post = "%")),
    
    # graph controls ####
    tags$hr(),
    fluidRow(column(6, selectInput("sizevar",  "Size variable:",  choices = SizChoices)),
             column(6, selectInput("colorvar", "Color variable:", choices = ColChoices))),
    
    # about this app ####
    h6(a(id = "toggleabout", "About this app")),
    hidden(div(
      id = "about", 
      tags$div(h6(
        "This app is inspired by ", a("ZipExplorer", href = "https://shiny.rstudio.com/gallery/superzip-example.html"),".",
        "It uses data from ",a("IPEDS", href='https://nces.ed.gov/ipeds/Home/UseTheData'), 
        " and ", a("College Scorecard", href='https://collegescorecard.ed.gov/data/'),
        "If you have any questions and suggestions email me at ", a("dvorakt@union.edu", href='mailto:dvorakt@union.edu'), br2(), 
        "- Clicking on a college will display more info and a link to the college's website.", br2(), 
        "- NA stands for 'not available.' If the 'Include NA?' box is checked,", 
        "colleges that do not provide info on a particular variable are ", strong("included"),"."))
    )) # /hidden div
    
  ) # /absolutePanel
  
)) # /bootstrapPage /shinyUI
