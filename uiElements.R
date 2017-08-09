#uiElements.R


# The hider function creates a collapsable fluidRow with 4 widgets arranged horizontally.
#
# The parameters are:
#   title = The title of the hidden panel
#   ID = the stub of the ID for the 2 containing divs
#   slide1 and slide 2 = sliderInput widgets, defined using the sliderInput function
#
# The output is a collapsed panel holding a fluidRow with the following 4 widgets:
#   slide1, as defined in the funtion call
#   slide1NA, a checkboxInput whose id is the same as slide1 with 'NA' appended
#   slide2, as defined in the funtion call
#   slide2NA, a checkboxInput whose id is the same as slide2 with 'NA' appended
hider = function(title, ID, slide1, slide2){
  togID = paste0("toggle", ID)
  hidID = paste0("filter", ID)
  tagList(
    h5(title, a(id = togID, "show/hide")),
    hidden(div(
      id = hidID, 
      fluidRow(
        column(4, slide1),
        column(1, h6("NAs?"), checkboxInput(paste0(slide1$children[[1]]$attribs$`for`, "NA"), label = NULL, value = T)),
        column(4, offset = 1, slide2),
        column(1, h6("NAs?"), checkboxInput(paste0(slide2$children[[1]]$attribs$`for`, "NA"), label = NULL, value = T)))))
  )
}




# br2 is a function that just inserts 2 breaks
br2 = function(){tagList(br(), br())}





# Some static data:
SchTyps = c("Doctoral Universities", "Master's Colleges", "Baccalaureate Colleges", "Associate's Colleges")
ColChoices = c("Type of ownership" = "ownership", "Level of instruction" = "type", "Testing" = "testing")
SizChoices = c("Constant" = "constant", 
               "Undergraduate size" = "size_trimmed", 
               "Selectivity" = "selectivity", 
               "Tuition and fees" = "CHG1AY3", 
               "Net Price" = "netprice", 
               "Med Salary (6yrs after)" = "salary", 
               "Graduation rate" = "gr", 
               "Retention rate" = "RET_PCF")