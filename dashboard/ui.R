
ui <- dashboardPage(
                    # ShinyDashboard tabs
                    dashboardHeader(title = "Affect of Winter on the Scottish Health Service"),
                    dashboardSidebar(
                      sidebarMenu(
                        
                        menuItem("General Stats", tabName = "overview", icon = icon("table")),
                        menuItem("A&E Activity", tabName = "life_expectancy"),
                        menuItem("Deprivation", tabName = "drug_deaths"),
                        menuItem("Covid", tabName = "alcohol_deaths"),
                        selectInput("list",
                                    "List of Health Boards",
                                    choices = c("The Golden Jubilee National Hospital",
                                                   "Scottish Ambulance Service",
                                                   "NHS24",
                                                   "NHS National Services Scotland"),
                                    selected = "NHS24")
                      )
                    ),
                    
                    dashboardBody(
                      tabItems(
                        # OVERVIEW PANEL ---------------------------------------
                        tabItem("overview",
                                fluidPage(
                                  fluidRow(
                                    column(width = 8, offset = 2, align = "center", style = "border: 1px dashed black;",
                                           tags$b("Overview", style = "font-size: 40px"),
                                           br(), br(),
                                           p("Here we might write a short sammuaray", 
                                             style = "font-family: 'arial'; font-size: 12pt;"
                                             )
                                    )
                                  ),
                                  br(),
                                  br(),
                                  br(),
                                  br(),
                                  br(),
                                  br(),
                                  br(),
                                  br(),
                                  fluidRow(),
                                  fluidRow(
                                    column(width = 10, offset = 1, align = "center", style = "border: 4px double black;",
                                           tags$b("Key Stats/", br() , "Infographics", style = "font-size: 40px"),
                                           br(), br(),
                                           p("infographics",
                                             style = "font-family: 'arial'; font-size: 12pt;"
                                           )
                                    )
                                  )
                                  
                                )
                        ),
                        # Accident & Emergency Activity PANEL ---------------------------------------
                        tabItem(tabName = "ae_activity",
                                
                                fluidRow(
                                  column(width = 12,
                                         tags$b("A&E Activity", style = "font-size: 30px"),
                                         
                                  )
                                ),
                                
                                tabsetPanel(
                                  tabPanel("By Area",
                                           fluidRow(
                                             column(width = 6,
                                                    
                                                    box(width = NULL, solidHeader = TRUE, background = "blue",  
                                                        
                                                        column(width = 6, align = "center",
                                                               
                                                               selectInput("year_input",
                                                                           label = "Year Group",
                                                                           choices = c("All (average)" = "All",
                                                                                       unique(life_expectancy_data$date_code)),
                                                                           selected = "All (average)")
                                                               
                                                        ),
                                                        
                                                        
                                                        column(width = 6, align = "center",
                                                               
                                                               selectInput("gender_input",
                                                                           label = "Gender",
                                                                           choices = c("All (average)" = "All",
                                                                                       unique(life_expectancy_data$gender)),
                                                                           selected = "All (average)")
                                                               
                                                        )
                                                    ),
                                                    leafletOutput("life_exp_map", height = 600)
                                                    
                                             ),
                                             
                                             
                                             column(width = 6, align = "center",
                                                    
                                                    box(width = NULL, solidHeader = TRUE, background = "blue", 
                                                        
                                                        column(width = 6, offset = 3, align = "center",
                                                               
                                                               selectInput("area_input",
                                                                           label = "Council Area",
                                                                           choices = c("All (average)" = "All",
                                                                                       unique(life_expectancy_data$local_authority)),
                                                                           selected = "All (average)")
                                                        )
                                                    ),
                                                    plotlyOutput("life_expectancy_plot", height = 600)
                                             )
                                             
                                             
                                             
                                           ),
                                           
                                           
                                  ),
                                  
                                  
                                  tabPanel("Overview",
                                           
                                           fluidRow(
                                             column(width = 12, offset = 4,
                                                    box(width = 4, solidHeader = TRUE, background = "blue", 
                                                        column(width = 8, offset = 2, align = "center",
                                                               selectInput("all_year_input",
                                                                           label = "Year Group",
                                                                           choices = c("All Years (average)" = "All Years (average)",
                                                                                       unique(life_expectancy_data$date_code)),
                                                                           selected = "All Years (average)")
                                                        ),
                                                    ),
                                             ),
                                             
                                             fluidRow(
                                               column(width = 12,
                                                      plotlyOutput("all_life_expectancy_plot", height = 600)
                                               )
                                             )
                                           )
                                  )
                                )
                        ),
                        
                        
                        # Deprivation PANEL -------------------------------------------------------------
                        tabItem(tabName = "deprivation",
                                
                                fluidRow(
                                  column(width = 10,
                                         tags$b("Deprivation", style = "font-size: 30px"),
                                         br(), br(), 
                                  )
                                ),
                                
                                fluidRow(
                                  column(width = 6,
                                         box(width = NULL, solidHeader = TRUE, background = "purple",
                                             column(width = 6, align = "center",
                                                    selectInput("drug_map_year",
                                                                label = "Year:",
                                                                choices = c("All",
                                                                            sort(unique(drug_deaths$year))),
                                                                selected = "All")
                                             ),
                                             
                                             column(width = 6, align = "center",
                                                    selectInput("drug_map_name",
                                                                label = "Select Drug:",
                                                                choices = sort(unique(drug_deaths$drug_name)),
                                                                selected = "All drug-related deaths")
                                             )
                                         ),
                                         
                                         leafletOutput("drug_map", height = 600)
                                         
                                  ),
                                 
                                  column(width = 6,
                                         fluidRow(   
                                         box(width = NULL, solidHeader = TRUE, background = "purple",
                                             column(width = 6, align = "center",
                                                    selectInput("drug_plot_area",
                                                                label = "Select Area:",
                                                                choices = c(unique(drug_deaths$council_area)))
                                             ),
                                             column(width = 6, align = "center",
                                                    selectInput("drug_plot_name",
                                                                label = "Select Drug:",
                                                                choices = sort(unique(drug_deaths$drug_name)),
                                                                selected = "All drug-related deaths")
                                             )
                                             
                                         ),
                                         
                                         plotlyOutput("drug_plot", height = 300, reportTheme = TRUE)
                                         
                                  ),
                                  fluidRow(
                                    
                                    box(width = NULL, solidHeader = TRUE, background = "purple",
                                        tags$b("Time series plots", style = "font-size: 30px")
                                        
                                        
                                    ),
                                    
                                    plotlyOutput("time_series_Depr_plot", height = 300, reportTheme = TRUE)
                                  
                                  )
                                  )
                                  
                                )),
                        
                        # COVID PANEL -------------------------------------------------------------
                        
                        tabItem(tabName = "covid",
                                fluidRow(
                                  column(width = 10,
                                         tags$b("Covid in Scotland", style = "font-size: 30px"),
                                         br(), br(), 
                                  )
                                ),
                                fluidRow(
                                  column(width = 6,
                                         box(width = NULL, solidHeader = TRUE, background = "green",
                                             column(width = 12, align = "center",
                                                    selectInput("alc_year_input",
                                                                label = "Year:",
                                                                choices = c("All",
                                                                            sort(unique(alcohol_area$year_of_death))),
                                                                selected = "All",
                                                                width = "50%"))),
                                         
                                         
                                         
                                         leafletOutput("alcohol_map", height = 600)
                                         
                                         
                                  ),
                                  
                                  
                                  column(width = 6, align = "center",
                                         fluidRow(
                                           box(width = 12, solidHeader = TRUE, background = "green",
                                               column(width = 6,
                                                      selectInput("alc_gender_input",
                                                                  label = "Gender:",
                                                                  choices = c("All",
                                                                              unique(alcohol_deaths$gender)),
                                                                  selected = "All")),
                                               column(width = 6,
                                                      selectInput("age_input",
                                                                  label = "Age Group:",
                                                                  choices = c("All",
                                                                              unique(alcohol_deaths$age_group)),
                                                                  selected = "All")))),
                                         fluidRow(
                                           plotlyOutput("alcohol_plot",  height = 300)
                                         ),
                                         fluidRow(
                                           
                                           box(width = NULL, solidHeader = TRUE, background = "green",
                                               tags$b("Time series plots", style = "font-size: 30px")
                                               
                                               
                                           ),
                                           
                                           plotlyOutput("time_series_covid_plot", height = 300, reportTheme = TRUE)
                                           
                                         )
                                  )
                                )
                        )
                      )
                    )
)



