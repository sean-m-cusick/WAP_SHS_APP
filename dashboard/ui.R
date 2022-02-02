
ui <- dashboardPage(
                    # ShinyDashboard tabs
                    dashboardHeader(title = "Affect of Winter on the Scottish Health Service"),
                    dashboardSidebar(
                      sidebarMenu(

                        menuItem("General Stats", tabName = "overview"),
                        menuItem("Covid", tabName = "life_covid"),
                        menuItem("A&E Activity", tabName = "drug_deaths"),
                        menuItem("Extension Deprivation", tabName = "alcohol_deaths"),
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
                                    column(width = 10, offset = 1, align = "center", style = "border: 1px dashed black;",
                                           tags$b("Overview", style = "font-size: 40px"),
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
                                    column(width = 6,
                                           box(width = NULL, solidHeader = TRUE, background = "purple",
                                               tags$b("General Map Of NHS", style = "font-size: 30px")


                                           ),
                                           # box(width = NULL, solidHeader = TRUE, background = "purple",
                                           #     column(width = 6, align = "center",
                                           #            selectInput("drug_map_year",
                                           #                        label = "Year:",
                                           #                        choices = c("All",
                                           #                                    sort(unique(drug_deaths$year))),
                                           #                        selected = "All")
                                           #     ),
                                           #
                                           #     column(width = 6, align = "center",
                                           #            selectInput("drug_map_name",
                                           #                        label = "Select Drug:",
                                           #                        choices = sort(unique(drug_deaths$drug_name)),
                                           #                        selected = "All drug-related deaths")
                                           #     )
                                           # ),

                                           leafletOutput("general_map", height = 600)

                                    ),

                                    column(width = 6,
                                           fluidRow(
                                             box(width = NULL, solidHeader = TRUE, background = "purple",
                                                 tags$b("General Graphs", style = "font-size: 30px")


                                             ),

                                             plotlyOutput("general_plot", height = 300, reportTheme = TRUE)

                                           ),
                                           fluidRow(

                                             box(width = NULL, solidHeader = TRUE, background = "purple",
                                                 tags$b("Time series plots", style = "font-size: 30px")


                                             ),

                                             plotlyOutput("time_series_general_plot", height = 300, reportTheme = TRUE)

                                           )
                                    )

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
                        # LIFE Covid PANEL ---------------------------------------
                        tabItem(tabName = "life_covid",

                                fluidRow(
                                  column(width = 12,
                                         tags$b("Covid", style = "font-size: 30px"),

                                  )
                                ),

                                tabsetPanel(
                                  tabPanel("Overview",
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
                                                    # box(width = NULL, solidHeader = TRUE, background = "blue",
                                                    #
                                                    #     column(width = 6, align = "center",
                                                    #
                                                    #            selectInput("year_input",
                                                    #                        label = "Year Group",
                                                    #                        choices = c("All (average)" = "All",
                                                    #                                    unique(life_expectancy_data$date_code)),
                                                    #                        selected = "All (average)")
                                                    #
                                                    #     ),
                                                    #
                                                    #
                                                    #     column(width = 6, align = "center",
                                                    #
                                                    #            selectInput("gender_input",
                                                    #                        label = "Gender",
                                                    #                        choices = c("All (average)" = "All",
                                                    #                                    unique(life_expectancy_data$gender)),
                                                    #                        selected = "All (average)")
                                                    #
                                                    #     )
                                                    # ),
                                                    #leafletOutput("life_exp_map", height = 600)
                                                    plotlyOutput("life_covid_plot_1", height = 500)

                                             ),


                                             column(width = 6, align = "center",
                                                    box(width = NULL, solidHeader = TRUE, background = "blue",
                                                        tags$b("2 weeks Moving Average Hospital Admission Per Age Group in 2020 - 2021", style = "font-size: 24px")


                                                    ),
                                                    # box(width = NULL, solidHeader = TRUE, background = "blue",
                                                    #
                                                    #     column(width = 6, offset = 3, align = "center",
                                                    #
                                                    #            selectInput("area_input",
                                                    #                        label = "Council Area",
                                                    #                        choices = c("All (average)" = "All",
                                                    #                                    unique(life_expectancy_data$local_authority)),
                                                    #                        selected = "All (average)")
                                                    #     )
                                                    # ),
                                                    plotlyOutput("life_covid_plot_2", height = 500)
                                             )



                                           ),


                                  ),


                                  tabPanel("Specific Stat",

                                           fluidRow(
                                             column(width = 12, offset = 4,
                                                    box(width = 4, solidHeader = TRUE, background = "blue",
                                                        column(width = 8, offset = 2, align = "center",
                                                               selectInput("all_year_input",
                                                                           label = "Year Group123",
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
