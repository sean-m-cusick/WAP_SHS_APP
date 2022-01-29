ui <- fluidPage(
  theme = shinytheme("darkly"),
  
  
  # Application title
  titlePanel(tags$h2("Whisky of Scotland")),
  
  # Sidebar with alt. map, region, distillery, timescale
  sidebarLayout(
    
    sidebarPanel(position = "left",
                 # select all, doesn't work
                 # actionLink("selectall","Select All"),
                 checkboxGroupInput("region_input",
                                    "Region",
                                    choices = all_regions,
                                    selected = all_regions
                 ),
                 
                 br(),
                 
                 selectInput("distillery_input",
                             tags$b("Which Distillery?"),
                             choices = all_distilleries
                 ),
    ),
    
    tabsetPanel(
      tabPanel("Map",
               plotOutput("map_plot")
      ),
      tabPanel("Distilleries",
               textOutput("selected_distillery"),
               plotOutput("output_table")
      ),
      
      # tabPanel("Histogram",
      #          sliderInput("time_input",
      #                 "Year range",
      #                 min = 1775,
      #                 max = 1993,
      #                 value = c(1780, 1990),
      #                 width = 500),
      #          plotOutput("histogram_plot")
      #         ),
      tabPanel("Whisky Notes",
               plotOutput("flavour_plot")
      ),
      tabPanel("About",
               tags$a("Author: Seàn M. Cusick",
                      href = "http://riomhach.co.uk//")
      ),
      # tabPanel("Map",
      #          checkboxInput("map_type",
      #                        "Interactive map",
      #                        value = FALSE),
      #          plotOutput("map_plot")
      #          #leafletOutput("map_plot")
      #          ),
      # tabPanel("Interactive Map",
      #          checkboxInput("map_type",
      #                        "Interactive map",
      #                        value = TRUE),
      #          leafletOutput("map_plot")
      # ),
    )
  )
)
