# server ------------------------------------------------------------------


server <- function(input, output, session) {
  
  # OVERVIEW PANEL --------------------
  output$value <- renderText({input$about })
  
  
  # output$avg_m <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(life_expectancy_data %>%
  #                filter(date_code == "2017-2019",
  #                       gender == "Male",
  #                       measurement == "Count") %>%
  #                summarise(mean = round(mean(value), 1)) %>%
  #                pull(mean),
  #              style = "font-size: 80%;"),
  #     subtitle = "Average Life Expectancy of Men in Scotland in 2019",
  #     icon = icon("heart"),
  #     color = "blue"
  #   )
  # })
  
  # output$avg_f <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(life_expectancy_data %>%
  #                filter(date_code == "2017-2019",
  #                       gender == "Female",
  #                       measurement == "Count") %>%
  #                summarise(mean = round(mean(value), 1)) %>%
  #                pull(mean),
  #              style = "font-size: 80%;"),
  #     subtitle = "Average Life Expectancy of Women in Scotland in 2019",
  #     icon = icon("heart"),
  #     color = "blue"
  #   )
  # })
  
  # output$life_exp_area <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(life_expectancy_data %>%
  #                filter(date_code == "2017-2019",
  #                       measurement == "Count") %>%
  #                group_by(local_authority) %>%
  #                summarise(mean = mean(value)) %>%
  #                slice_min(mean) %>%
  #                pull(local_authority),
  #              style = "font-size: 80%;"),
  #     subtitle = "Council Area with the Lowest Life Expectancy in 2019",
  #     icon = icon("home"),
  #     color = "blue"
  #   )
  # })
  
  # output$most_drug_death <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(drug_deaths %>% 
  #                filter(drug_name != "All drug-related deaths" & year == 2019) %>% 
  #                slice_max(num_deaths) %>% 
  #                pull(drug_name),
  #              style = "font-size: 80%;"),
  #     subtitle = "Most Reported Cause of Drug-related Deaths in 2019",
  #     icon = icon("pills"),
  #     color = "purple"
  #   )
  # })
  # 
  # output$total_drug_death <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(drug_deaths %>% 
  #                filter(council_area == "Scotland" &
  #                         drug_name == "All drug-related deaths" &
  #                         year == 2019) %>%
  #                pull(num_deaths),
  #              style = "font-size: 80%;"),
  #     subtitle = "Total Drug-related Deaths in 2019",
  #     icon = icon("pills"),
  #     color = "purple"
  #   )
  # })
  # 
  # output$worst_drug_area <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(drug_deaths %>% 
  #                filter(drug_name == "All drug-related deaths" &
  #                         year == 2019 &
  #                         council_area != "Scotland") %>%
  #                slice_max(num_deaths) %>% 
  #                pull(council_area),
  #              style = "font-size: 80%;"),
  #     subtitle = "Council Area with Most Drug-related Deaths in 2019",
  #     icon = icon("home"),
  #     color = "purple"
  #   )
  # })
  # 
  # output$alcohol_age <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(alcohol_deaths %>% 
  #                drop_na(age_group) %>% 
  #                filter(year_of_death == 2019) %>% 
  #                slice_max(count, n = 1, with_ties = FALSE) %>% 
  #                pull(age_group),
  #              style = "font-size: 80%;"),
  #     subtitle = "Age Group with Most Alcohol-specific Deaths in 2019",
  #     icon = icon("wine-glass"),
  #     color = "green"
  #   )
  # })
  # 
  # output$total_alc_death <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(alcohol_deaths %>% 
  #                drop_na(age_group) %>% 
  #                filter(year_of_death == 2019) %>% 
  #                summarise(count = sum(count)) %>% 
  #                pull(count),
  #              style = "font-size: 80%;"),
  #     subtitle = "Total Alcohol-specific Deaths in 2019",
  #     icon = icon("wine-glass"),
  #     color = "green"
  #   )
  # })
  # 
  # output$worst_alcohol_area <- renderValueBox({
  #   
  #   valueBox(
  #     value = 
  #       tags$p(alcohol_area %>% 
  #                filter(area != "All Scotland" &
  #                         year_of_death == 2009) %>% 
  #                slice_max(count, n = 1) %>% 
  #                pull(area),
  #              style = "font-size: 80%;"),
  #     subtitle = "Council Area with Most Alcohol-specific Deaths in 2019",
  #     icon = icon("home"),
  #     color = "green"
  #   )
  # })
  # 
  # LIFE EXPECTANCY TAB ---------------------------------------------------------------
  
  # LIFE EXPECTANCY MAP DATA FILTER
  life_exp_map_filtered <- reactive({
    
    if (input$year_input == "All") {
      life_exp_year <- unique(life_expectancy_data$date_code)
    } else {
      life_exp_year <- input$year_input
    }
    
    if (input$gender_input == "All") {
      life_exp_gender <- unique(life_expectancy_data$gender)
    } else {
      life_exp_gender <- input$gender_input
    }
    
    life_expectancy_data %>%
      filter(gender %in% life_exp_gender,
             measurement == "Count",
             date_code %in% life_exp_year) %>%
      group_by(local_authority) %>%
      summarise(value = round(mean(value), 1)) %>%
      left_join(scotland_shape, by = c("local_authority" = "local_auth")) %>%
      st_as_sf()
  })
  
  
  # LIFE EXPECTANCY MAP PLOT
  output$life_exp_map <- renderLeaflet({
    
    #life_exp_map_filtered <- life_exp_map_filtered()
    life_expectancy_data %>% 
      leaflet() %>% 
      addTiles() %>% 
      addCircleMarkers(lng = ~longitude, 
                       lat = ~latitude)
    # bins <- c(70, 72, 74, 76, 78, 80, 82, 84, 86)
    # pal <- colorBin("Blues", domain = life_exp_map_filtered$value, bins = bins)
    # 
    # life_exp_labels <- sprintf(
    #   "<strong>%s</strong><br/>%g years",
    #   life_exp_map_filtered$local_authority, life_exp_map_filtered$value
    # ) %>%
    #   lapply(htmltools::HTML)
    # 
    # 
    # life_exp_map_filtered %>%
    #   leaflet() %>%
    #   setView(lng = -4.2026, lat = 57.8, zoom = 5.5, options = list()) %>%
    #   addProviderTiles(providers$CartoDB.Positron)%>%
    #   addPolygons(fillColor = ~pal(value),
    #               weight = 0.5,
    #               opacity = 0.9,
    #               color = "black",
    #               fillOpacity = 0.8,
    #               highlightOptions = highlightOptions(color = "white", weight = 2,
    #                                                   bringToFront = TRUE),
    #               label = life_exp_labels,
    #               labelOptions = labelOptions(
    #                 style = list("font-weight" = "normal", padding = "3px 8px"),
    #                 textsize = "15px",
    #                 direction = "auto")) %>%
    #   addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
    #             position = "bottomright")
    
  })
  
  # LIFE EXPECTANCY PLOT DATA FILTER
  life_exp_plot_filtered <- reactive({
    
    if (input$area_input == "All") {
      life_exp_area<- unique(life_expectancy_data$local_authority)
    } else {
      life_exp_area <- input$area_input
    }
    
    life_expectancy_data %>%
      filter(local_authority %in% life_exp_area) %>%
      pivot_wider(names_from = measurement,
                  values_from = value) %>%
      rename(lower = "95% Lower Confidence Limit", upper = "95% Upper Confidence Limit", value = "Count") %>%
      mutate(date_code = as.numeric(str_extract(date_code, "^20[0-9]{2}"))) %>%
      group_by(date_code, gender) %>%
      summarise(upper = mean(upper), lower = mean(lower), value = mean(value))
    
  })
  
  
  # LIFE EXPECTANCY PLOT
  output$life_expectancy_plot <- renderPlotly({
    
    # load filtered data
    life_exp_plot_filtered <- life_exp_plot_filtered()
    
    # plotly wrapper for ggplot graph
    ggplotly(
      ggplot(life_exp_plot_filtered) +
        aes(x = date_code,
            y = value,
            fill = gender
        ) +
        # add points and text for hover box
        geom_point(aes(text = sprintf("Year: %g<br>Life Expectancy: %g<br>
                                      Gender: %s<br>Upper: %g<br>Lower: %g", 
                                      date_code, value, gender, upper, lower))) +
        # add lines and ribbon with confidence intervals
        geom_ribbon(aes(ymin = lower, ymax = upper, alpha = 0.2)) +
        geom_line(colour = "black", alpha = 0.5) +
        # set axis limits
        scale_y_continuous(breaks = c(70:85), limits = c(70, 85)) +
        scale_x_continuous(n.breaks = 10) +
        scale_fill_manual(values=c("aquamarine", "cornflowerblue")) +
        theme_minimal()+
        theme(panel.grid.major = element_line(colour = "grey"),
              plot.background = element_rect(fill = "#ecf0f6"),
              panel.background = element_rect(fill = "#ecf0f6")),
      tooltip = c("text")
    ) %>%
      # plotly configuration and axis labels
      config(displayModeBar = FALSE) %>%
      layout(legend = list(orientation = 'h',
                           yanchor="bottom",
                           y=0.99,
                           xanchor="right",
                           x=1),
             xaxis = list(title = "Year"),
             yaxis = list(title = "Life Expectancy in Years"),
             title = list(text = paste0(
               input$area_input, ' - Life Expectancy from 2009-2017',
               '<br>',
               '<sup>',
               'Value shown with 95% Confidence Intervals',
               '</sup>',
               '<br>')),
             # Adjust plot margins so labels are visible
             margin = list(t = 50, b = 50, l = 50)
      )
  })
  
  
  # LIFE EXPECTANCY ALL AREAS PLOT DATA
  all_life_exp_filtered <- reactive({
    
    if (input$all_year_input == "All Years (average)") {
      life_exp_all<- unique(life_expectancy_data$date_code)
    } else {
      life_exp_all <- input$all_year_input
    }
    
    life_expectancy_data %>%
      filter(measurement == "Count",
             date_code %in% life_exp_all) %>%
      group_by(local_authority, gender) %>%
      summarise(value = round(mean(value), 2))
  })
  
  
  # LIFE EXPECTANCY ALL AREAS PLOT
  output$all_life_expectancy_plot <- renderPlotly({
    
    # load filtered data
    all_life_exp_filtered <- all_life_exp_filtered()
    
    # plotly wrapper for ggplot graph
    ggplotly(
      ggplot(all_life_exp_filtered) +
        aes(x = reorder(local_authority, -value),
            y = value,
            fill = gender,
            # Text output for plotly hover box
            text = sprintf("Area: %s<br>Life Expectancy: %g<br>Gender: %s", local_authority, value, gender)) +
        geom_bar(stat = "identity", color = "black", width = 0.5, position = position_dodge(width=0.7)) +
        # Set Y axis  limits at 70 and 85
        coord_cartesian(ylim = c(70,85)) +
        scale_fill_manual(values=c("aquamarine", "cornflowerblue")) +
        theme_minimal()+
        theme(axis.text.x = element_text(angle = 60),
              panel.grid.major = element_line(colour = "grey"),
              plot.background = element_rect(fill = "#ecf0f6"),
              panel.background = element_rect(fill = "#ecf0f6")),
      tooltip = c("text")
    ) %>%
      # Plotly configuration and axis labels
      config(displayModeBar = FALSE) %>%
      layout(legend = list(orientation = 'h',
                           yanchor="bottom",
                           y=0.99,
                           xanchor="right",
                           x=1),
             xaxis = list(title = ""),
             yaxis = list(title = "Life Expectancy in Years"),
             title = list(text = paste0(
               'All Areas - Life Expectancy from ', input$all_year_input,
               '<br>')),
             # Adjust plot margins so labels are visible
             margin = list(t = 50, b = 50, l = 50)
      )
  })
  
  # DRUGS TAB -------------------------------------------------------------
  
  # DRUG MAP SELECTINPUT CHANGES
  observe({
    # Update drug map selections based on year input
    if (input$drug_map_year != "All") {
      drug_choice_selection <- drug_deaths %>%
        filter(year == input$drug_map_year) %>%
        select(drug_name) %>%
        arrange(drug_name) %>%
        pull(drug_name)
      
      updateSelectInput(session,
                        "drug_map_name",
                        label = "Select Drug:",
                        choices = drug_choice_selection,
                        selected = "All drug-related deaths")
    } else {
      drug_choice_selection <- sort(unique(drug_deaths$drug_name))
      
      updateSelectInput(session,
                        "drug_map_name",
                        label = "Select Drug:",
                        choices = drug_choice_selection,
                        selected = "All drug-related deaths")
    }
  })
  
  # DRUG MAP DATA
  drugs_map_data <- reactive({
    
    # If all years is selected, filter for all years
    if(input$drug_map_year == "All") {
      drugs_map_year_selection <- sort(unique(drug_deaths$year))
    } else {
      drugs_map_year_selection <- input$drug_map_year
    }
    
    # Filter data for leaflet plot
    drugs_map_data <- drug_deaths %>%
      filter(council_area != "Scotland",
             drug_name %in% input$drug_map_name,
             year %in% drugs_map_year_selection) %>%
      group_by(council_area) %>%
      summarise(drug_name = drug_name, num_deaths = sum(num_deaths)) %>%
      # Join with shape data
      left_join(scotland_shape, by = c("council_area" = "local_auth")) %>%
      # Convert to shape data from data frame
      st_as_sf()
  })
 ################### ------------------------------------------------------------
 # General MAP OUTPUT
 output$general_map <- renderLeaflet({

   life_expectancy_data %>%
     leaflet() %>%
     addTiles() %>%
     addCircleMarkers(lng = ~longitude,
                      lat = ~latitude)

   #drugs_map_data <- drugs_map_data()

   # Labels variable for leaflet plot
   # drugs_map_labels <- sprintf(
   #   "<strong>%s</strong><br/>%g deaths",
   #   drugs_map_data$council_area,
   #   drugs_map_data$num_deaths) %>%
   #   lapply(htmltools::HTML)

   # if (input$drug_map_year == "All" & input$drug_map_name == "All drug-related deaths"){
   #   drugs_map_bins <- c(0, 50, 100, 200, 500, 1000, 2000, Inf)
   # } else {
   #   drugs_map_bins <- c(0, 5, 15, 30, 50, 100, 250, Inf)
   # }
   #
   # pal <- colorBin("Purples", domain = drugs_map_data$num_deaths, bins = drugs_map_bins)
   #
   #
   # Initialise plot
   # drugs_map_data %>%
   #   leaflet() %>%
   #   setView(lng = -4.2026, lat = 57.8, zoom = 6, options = list()) %>%
   #   addProviderTiles(providers$CartoDB.Positron) %>%
   #   addPolygons(fillColor = ~pal(num_deaths),
   #               weight = 0.75,
   #               opacity = 1,
   #               color = "black",
   #               dashArray = "2",
   #               fillOpacity = 0.9,
   #               highlightOptions = highlightOptions(color = "white", weight = 2,
   #                                                   bringToFront = TRUE),
   #               label = drugs_map_labels,
   #               labelOptions = labelOptions(
   #                 style = list("font-weight" = "normal", padding = "3px 8px"),
   #                 textsize = "15px",
   #                 direction = "auto")) %>%
   #   addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
   #             position = "bottomright")
   #
 })
  
  # general PLOT OUTPUT
  output$general_plot <- renderPlotly({
    
    # min_year <- drug_plot_data() %>%
    #   slice_min(year) %>%
    #   pull(year)
    # 
    # max_year <- drug_plot_data() %>%
    #   slice_max(year) %>%
    #   pull(year)
    
    
    ggplotly(
      hospital_activty_dep  %>% 
        mutate(quarter = case_when(
          quarter == "1" ~ "Winter",
          quarter == "2"  ~ "Spring",
          quarter == "3" ~ "Summer",
          quarter == "4"  ~ "Autumn"
          
        )) %>% 
        group_by(year,quarter) %>% 
        summarise(average_length_of_stay = mean(length_of_stay)) %>% 
        ggplot() +
        aes(x = year, y = average_length_of_stay, group = quarter, color = quarter) +
        geom_point() +
        geom_line() +
        labs(
          x = "Winter",
          y = "average length of stay"
        )+
      # drug_plot_data() %>%
      #   ggplot() +
      #   aes(x = year, y = num_deaths) +
      #   geom_line(colour = "#605ca8", alpha = 0.75, size = 1.5) +
      #   geom_point(aes(text=sprintf("Year: %g<br>Deaths: %g", year, num_deaths)),
      #              colour = "black", size = 2, alpha = 0.9) +
      #   scale_x_continuous(breaks = c(min_year:max_year)) +
      #   scale_y_continuous(n.breaks = 8) +
        theme_minimal() +
        theme(panel.grid.major = element_line(colour = "grey"),
              plot.background = element_rect(fill = "#ecf0f6"),
              panel.background = element_rect(fill = "#ecf0f6")),
      tooltip = c("text")
    ) %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = list(title = "Year"),
             yaxis = list(title = "Number of ----"),
             title = list(text = paste0(
               'Number of  in ',
               '<br>',
               '<sup>',
               "--",
               '</sup>',
               '<br>')),
             margin = list(t = 50, b = 50, l = 50) # to fully display the x and y axis labels
      )
  })
  
  ######################------------------------------------------------------------
  
  # DRUG MAP OUTPUT
  output$drug_map <- renderLeaflet({
    
    drugs_map_data <- drugs_map_data()
    
    # Labels variable for leaflet plot
    drugs_map_labels <- sprintf(
      "<strong>%s</strong><br/>%g deaths",
      drugs_map_data$council_area,
      drugs_map_data$num_deaths) %>%
      lapply(htmltools::HTML)
    
    if (input$drug_map_year == "All" & input$drug_map_name == "All drug-related deaths"){
      drugs_map_bins <- c(0, 50, 100, 200, 500, 1000, 2000, Inf)
    } else {
      drugs_map_bins <- c(0, 5, 15, 30, 50, 100, 250, Inf)
    }
    
    pal <- colorBin("Purples", domain = drugs_map_data$num_deaths, bins = drugs_map_bins)
    
    
    # Initialise plot
    drugs_map_data %>%
      leaflet() %>%
      setView(lng = -4.2026, lat = 57.8, zoom = 6, options = list()) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(fillColor = ~pal(num_deaths),
                  weight = 0.75,
                  opacity = 1,
                  color = "black",
                  dashArray = "2",
                  fillOpacity = 0.9,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  label = drugs_map_labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
                position = "bottomright")
    
  })
  
  # DRUG PLOT DATA
  drug_plot_data <- reactive({
    drug_plot_data <- drug_deaths %>%
      filter(drug_name %in% input$drug_plot_name,
             council_area %in% input$drug_plot_area)
  })
  
  # DRUG PLOT OUTPUT
  output$drug_plot <- renderPlotly({
    
    min_year <- drug_plot_data() %>%
      slice_min(year) %>%
      pull(year)
    
    max_year <- drug_plot_data() %>%
      slice_max(year) %>%
      pull(year)
    
    
    ggplotly(
      drug_plot_data() %>%
        ggplot() +
        aes(x = year, y = num_deaths) +
        geom_line(colour = "#605ca8", alpha = 0.75, size = 1.5) +
        geom_point(aes(text=sprintf("Year: %g<br>Deaths: %g", year, num_deaths)),
                   colour = "black", size = 2, alpha = 0.9) +
        scale_x_continuous(breaks = c(min_year:max_year)) +
        scale_y_continuous(n.breaks = 8) +
        theme_minimal() +
        theme(panel.grid.major = element_line(colour = "grey"),
              plot.background = element_rect(fill = "#ecf0f6"),
              panel.background = element_rect(fill = "#ecf0f6")),
      tooltip = c("text")
    ) %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = list(title = "Year"),
             yaxis = list(title = "Number of Deaths"),
             title = list(text = paste0(
               'Number of deaths in ', input$drug_plot_area, ' from ', min_year, '-', max_year,
               '<br>',
               '<sup>',
               input$drug_plot_name,
               '</sup>',
               '<br>')),
             margin = list(t = 50, b = 50, l = 50) # to fully display the x and y axis labels
      )
  })
  
  # Time series OUTPUT
  output$time_series_Depr_plot <- renderPlotly({
    
    min_year <- drug_plot_data() %>%
      slice_min(year) %>%
      pull(year)
    
    max_year <- drug_plot_data() %>%
      slice_max(year) %>%
      pull(year)
    
    
    ggplotly(
      drug_plot_data() %>%
        ggplot() +
        aes(x = year, y = num_deaths) +
        geom_line(colour = "#605ca8", alpha = 0.75, size = 1.5) +
        geom_point(aes(text=sprintf("Year: %g<br>Deaths: %g", year, num_deaths)),
                   colour = "black", size = 2, alpha = 0.9) +
        scale_x_continuous(breaks = c(min_year:max_year)) +
        scale_y_continuous(n.breaks = 8) +
        theme_minimal() +
        theme(panel.grid.major = element_line(colour = "grey"),
              plot.background = element_rect(fill = "#ecf0f6"),
              panel.background = element_rect(fill = "#ecf0f6")),
      tooltip = c("text")
    ) %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = list(title = "Year"),
             yaxis = list(title = "Number of Deaths"),
             title = list(text = paste0(
               'Number of deaths in ', input$drug_plot_area, ' from ', min_year, '-', max_year,
               '<br>',
               '<sup>',
               input$drug_plot_name,
               '</sup>',
               '<br>')),
             margin = list(t = 50, b = 50, l = 50) # to fully display the x and y axis labels
      )
  })
  
  # ALCOHOL TAB -------------------------------------------------------------
  
  # ALCOHOL DEATHS PLOT DATA FILTER
  alcohol_deaths_filtered <- reactive({
    
    if(input$alc_gender_input == "All") {
      alcohol_plot_gender_selection <- unique(alcohol_deaths$gender)
    } else {
      alcohol_plot_gender_selection <- input$alc_gender_input
    }
    
    
    if(input$age_input == "All") {
      alcohol_plot_age_selection <- unique(alcohol_deaths$age_group)
    } else {
      alcohol_plot_age_selection <- input$age_input
    }
    
    
    alcohol_deaths %>%
      filter(age_group != "all_ages" & age_group != "average_age") %>%
      #mutate(gender = factor(gender, levels = c("Male", "Female"))) %>%
      filter(gender %in% alcohol_plot_gender_selection,
             age_group %in% alcohol_plot_age_selection) %>%
      group_by(gender, year_of_death) %>%
      summarise(count = sum(count))
    
    
  })
  
  # ALCOHOL MAP DATA FILTER
  alcohol_area_filtered <- reactive({
    
    if(input$alc_year_input == "All") {
      alcohol_map_year_selection <- sort(unique(alcohol_area$year_of_death))
    } else {
      alcohol_map_year_selection <- input$alc_year_input
    }
    
    alcohol_area %>%
      select(-1) %>%
      filter(area != "All Scotland",
             year_of_death %in% alcohol_map_year_selection) %>%
      group_by(area) %>%
      summarise(area, count) %>%
      left_join(scotland_shape, by = c("area" = "local_auth")) %>%
      st_as_sf()
    
  })
  
  # ALCOHOL DEATHS MAP PLOT OUTPUT
  output$alcohol_map <- renderLeaflet({
    
    alcohol_area_filtered <- alcohol_area_filtered()
    
    bins <- c(0, 25, 50, 100, 150, 200)
    pal <- colorBin("Greens", domain = alcohol_area_filtered$count, bins = bins)
    
    alcohol_map_labels <- sprintf(
      "<strong>%s</strong><br/>%g deaths",
      alcohol_area_filtered$area, alcohol_area_filtered$count
    ) %>%
      lapply(htmltools::HTML)
    
    alcohol_area_filtered %>%
      leaflet() %>%
      setView(lng = -4.2026, lat = 57.8, zoom = 6, options = list()) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(fillColor = ~pal(count),
                  weight = 0.5,
                  opacity = 0.5,
                  color = "black",
                  fillOpacity = 0.5,
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE),
                  label = alcohol_map_labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
                position = "bottomright")
  })
  
  # ALCOHOL DEATHS PLOT OUTPUT
  
  output$alcohol_plot <- renderPlotly({
    
    alcohol_deaths_filtered <- alcohol_deaths_filtered()
    
    ggplotly(
      alcohol_deaths_filtered() %>%
        ggplot() +
        aes(x = year_of_death, y = count, fill = gender, 
            text=sprintf("Year: %g<br>Deaths: %g<br>Gender: %s", year_of_death, count, gender)) +
        geom_col() +
        scale_x_continuous(breaks = c(2009:2019)) +
        scale_fill_manual(values = c("Female" = "#bae3b5",
                                     "Male" = "#73c375")) +
        theme_minimal()+
        theme(panel.grid.major = element_line(colour = "grey"),
              plot.background = element_rect(fill = "#ecf0f6"),
              panel.background = element_rect(fill = "#ecf0f6")),
      tooltip = c("text")
    ) %>%
      config(displayModeBar = FALSE) %>%
      layout(legend = list(orientation = 'h',
                           yanchor="bottom",
                           y=0.99,
                           xanchor="right",
                           x=1),
             xaxis = list(title = "Year"),
             yaxis = list(title = "Number of Deaths"),
             title = list(text = paste0(
               'Number of Alcohol Deaths per Year',
               '<br>',
               '<sup>',
               'Gender: ', input$alc_gender_input, '  -  Age Group: ', input$age_input,
               '</sup>',
               '<br>')),
             margin = list(t = 50, b = 50, l = 50) # to fully display the x and y axis labels
      )
    
  })
  
  
}
