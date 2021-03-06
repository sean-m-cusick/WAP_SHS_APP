


ui <- dashboardPage(
                    # ShinyDashboard tabs
                    dashboardHeader(title = "PHS Project"),
                    dashboardSidebar(
                      sidebarMenu(
                        
                        menuItem("General Stats", tabName = "overview"),
                        br(),
                        menuItem("Covid", tabName = "life_covid"),
                        br(),
                        menuItem("Winter", tabName = "winter")
                      
                       # menuItem("Hypothesis Test", tabName = "hypo_test")
                         
                      )
                    ),
                    
                    dashboardBody(
                      tabItems(
                        # OVERVIEW PANEL ---------------------------------------
                        tabItem("overview",
                                fluidPage(
                                  fluidRow(
                                    column(width = 10, offset = 1, align = "center", style = "border: 1px dashed black;",
                                           tags$b("Overview", style = "font-size: 40px"),
                                           br(),  
                                           p("Winter Affectations Post-2020 on Scottish Health Service Application", 
                                             style = "font-family: 'arial'; font-size: 18pt;"
                                             )
                                    )
                                  ),
                                  br(),
 
                                  fluidRow(
                                    column(width = 9, align = "center",
                                           box(width = NULL, solidHeader = TRUE, background = "purple",
                                               tags$b("Location of hospitals in Scotland", style = "font-size: 30px")
                                               
                                               
                                           ),
                                           leafletOutput("general_map", height = 500)
                                    ),
                                    
                                    column(width = 3, align = "center",
                                           fluidRow(
                                             box(width = NULL, solidHeader = TRUE, background = "purple",
                                                 tags$b("Covid Summary", style = "font-size: 30px")
                                             )
                                           ),
                                           fluidRow(
                                             column(width = 12, align = "center",
                                             # valueBoxOutput("date")
                                             #############
                                             selectInput("ca_input",
                                                         "Hospital List",
                                                         choices = df_ca_name_list))
                                             #############
                                           ),
                                           fluidRow(column(width = 12, align = "center",
                                              valueBoxOutput("daily_positive"))
                                           ),
                                           fluidRow(column(width = 12, align = "center",
                                             valueBoxOutput("cumulative_positive"))
                                           ),
                                           fluidRow(column(width = 12, align = "center",
                                             valueBoxOutput("cumulative_deaths"))
                                           )
                                           )
                                           # fluidRow(
                                           #   
                                           #   box(width = NULL, solidHeader = TRUE, background = "purple",
                                           #       tags$b("All General Stat", style = "font-size: 30px")
                                           #       
                                           #       
                                           #   ),
                                           #   tableOutput("table_output")
                                           #   
                                           # #  plotlyOutput("time_series_general_plot", height = 300, reportTheme = TRUE)
                                           #   
                                           # )
                                    
                                  ),
                                  # fluidRow(
                                  #   column(width = 10, offset = 1, align = "center", style = "border: 4px double black;",
                                  #          tags$b("Key Stats/", br() , "Infographics", style = "font-size: 40px"),
                                  #          br(), br(),
                                  #          p("infographics",
                                  #            style = "font-family: 'arial'; font-size: 12pt;"
                                  #          )
                                  #   )
                                  # )
                                  
                                )
                        ),
                        
                        # Winter PANEL ---------------------------------------
                        # tabItem(tabName = "winter",
                        #         fluidRow(
                        #           column(width = 12, offset = 2,align = "center",
                        #                  box(width = 5, solidHeader = TRUE, background = "blue",
                        #                      tags$b("winter page", style = "font-size: 30px")
                        #                  )
                        #           ),
                        #           
                        #           fluidRow(
                        #             column(width = 12,
                        #                    plotlyOutput("winter_plot", height = 600)
                        #             )
                        #           )
                        #         )
                        #         
                        # ),
                        # LIFE Covid PANEL ---------------------------------------
                        tabItem(tabName = "life_covid",
                                
                                fluidRow(
                                  column(width = 12,
                                         tags$b("Covid", style = "font-size: 30px")
                                         
                                  )
                                ),
                                
                                #tabsetPanel(
                                #  tabPanel("Overview",
                                br(),
                                fluidRow(
                                  column(width = 10, offset = 1, align = "center", style = "border: 1px dashed black;",
                                         tags$b("Summary", style = "font-size: 25px"),
                                         br(), br(),
                                         p("Each Wednesday we publish a COVID-19 weekly report.
                                                      It provides information about the spread of the disease and the activity in NHS Scotland to tackle it.
                                                      There are two key points that we have learnt from the vaccine effectiveness analysis of omicron so far:
                                                      
                                                      Vaccine effectiveness wanes over time for all doses, so it is important to get your next dose as soon as 
                                                      possible after it becomes due, particularly if you are elderly and vulnerable, as your risk of a severe outcome will increase when the vaccine protection wanes.
                                                      
                                                      You can still get infected even if you are vaccinated - the biggest benefit of the vaccine is protection against severe disease. Therefore, even when you have been boosted you should be vigilant for symptoms and test yourself regularly with LFDs – 
                                                      especially before visiting those who are vulnerable.", 
                                           style = "font-family: 'arial'; font-size: 12pt;"
                                         )
                                  )
                                ),
                                br(),
                                br(),
                                
                                fluidRow(
                                  column(width = 6, align = "center",
                                         box(width = NULL, solidHeader = TRUE, background = "blue",
                                             tags$b("2 weeks Moving Average Hospital Admission", style = "font-size: 24px")
                                             
                                             
                                         ),
                                         
                                         
                                         plotlyOutput("life_covid_plot_1", height = 500)
                                         
                                  ),
                                  
                                  
                                  column(width = 6, align = "center",
                                         box(width = NULL, solidHeader = TRUE, background = "blue",
                                             tags$b("2 weeks Moving Average Hospital Admission Per Age Group in 2020 - 2021", style = "font-size: 24px")
                                             
                                             
                                         ),
                                         
                                         plotlyOutput("life_covid_plot_2", height = 500)
                                  )
                                  
                                  
                                  
                                ),
                                
                                
                                #  ),
                                
                                
                                
                                
                                # )
                        ),
                        
                        
                        # Winter PANEL -------------------------------------------------------------
                        tabItem(tabName = "winter",
                                
                                fluidRow(
                                  column(width = 10,
                                         tags$b("Winter", style = "font-size: 30px"),
                                         br(), br(), 
                                  )
                                ),
                                
                                fluidRow(
                                  column(width = 6,offset = 0.7,
                                         fluidRow(
                                         box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                             tags$b("Media Hype", style = "font-size: 30px")
 
                                         ),
                                        
                        img(src = "bbc_news.png", height = 600)
                                         
                                 ),
                        fluidRow(
                          fluidRow(
                            br(),
                            br(),
                            br(),
                          ),
                          img(src = "bbc_news2.png", height = 450)
                        )
                        ),
                                 
                                  column(width = 6,
                                         fluidRow(   
                                         box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                             tags$b("2 Weeks Moving Average Hospital A&E attendance", style = "font-size: 30px")
                                             
                                         ),
                                         
                                         plotlyOutput("winter_plot_1", height = 550, reportTheme = TRUE)
                                         
                                  ),
                                  fluidRow(
                                    
                                    box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                        tags$b("Hospital Admissions by Quarter", style = "font-size: 30px")
                                        
                                        
                                    ),
                                    
                                    plotlyOutput("winter_plot_2", height = 500, reportTheme = TRUE)
                                  
                                  )
                                  )
                                  
                                )),
                        # -hypothesis test panel------------------------------
                        tabItem(tabName = "hypo_test",
                                
                                fluidRow(
                                  column(width = 10,
                                         tags$b("winter", style = "font-size: 30px"),
                                         br(), br(), 
                                  )
                                ),
                                
                                fluidRow(
                                  column(width = 6,
                                         fluidRow(   
                                           box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                               tags$b("hypothesis test", style = "font-size: 30px")
                                               
                                           ),
                                           
                                           plotlyOutput("hypo_test_plot_1", height = 300, reportTheme = TRUE)
                                           
                                         ),
                                         fluidRow(
                                           
                                           box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                               tags$b("Hhypothesis test", style = "font-size: 30px")
                                               
                                               
                                           ),
                                           
                                           plotlyOutput("hypo_test_plot_2", height = 300, reportTheme = TRUE)
                                           
                                         )
                                  ),
                                  
                                  column(width = 6,
                                         fluidRow(   
                                           box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                               tags$b("hypothesis test", style = "font-size: 30px")
                                               
                                           ),
                                           
                                           plotlyOutput("hypo_test_plot_3", height = 300, reportTheme = TRUE)
                                           
                                         ),
                                         fluidRow(
                                           
                                           box(width = NULL, solidHeader = TRUE, background = "purple", align = "center",
                                               tags$b("Hhypothesis test", style = "font-size: 30px")
                                               
                                               
                                           ),
                                           
                                           plotlyOutput("hypo_test_plot_4", height = 300, reportTheme = TRUE)
                                           
                                         )
                                  )
                                  
                                )),
                        
                        # extention PANEL -------------------------------------------------------------
                        
                        tabItem(tabName = "extention",
                                fluidRow( ),
                                fluidRow( )
                        )
                      )
                    )
)



