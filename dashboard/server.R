# server ------------------------------------------------------------------


server <- function(input, output, session) {
  
  # OVERVIEW PANEL --------------------
  output$value <- renderText({input$about })
  
  general_stat_filtered <- reactive({
    
    df_general_stat %>% 
      select(date, ca, ca_name, daily_positive, cumulative_positive, daily_deaths, cumulative_deaths) %>% 
      arrange(date) %>% 
      group_by(ca) %>% 
      slice_tail(n  = 1) %>% 
      ungroup() %>% 
      group_by(date) %>% 
      summarise(daily_positive = sum(daily_positive),
                cumulative_positive = sum(cumulative_positive),
                daily_deaths = sum(daily_deaths),
                cumulative_deaths = sum(cumulative_deaths))
    
  })
  # daily postive box
  output$daily_positive <- renderValueBox({

    valueBox(
      value =
        tags$p( general_stat_filtered() %>% 
                 pull(daily_positive),
               style = "font-size: 70%;"),
      subtitle = "Daily Positive",
      color = "purple"
    )
  })
  # date box
  output$date <- renderValueBox({
    
    valueBox(
      value =
        tags$p( general_stat_filtered() %>% 
                  pull(date),
                style = "font-size: 70%;"),
      subtitle = "Date",
      color = "green"
    )
  })
  # cumulative_positive box
  output$cumulative_positive <- renderValueBox({
    
    valueBox(
      value =
        tags$p( general_stat_filtered() %>% 
                  pull(cumulative_positive),
                style = "font-size: 70%;"),
      subtitle = "cumulative positive",
      color = "blue"
    )
  })
 # daily_deaths box
  output$daily_deaths <- renderValueBox({

    valueBox(
      value =
        tags$p( general_stat_filtered() %>%
                  pull(daily_deaths),
                style = "font-size: 70%;"),
      subtitle = "Daily Deaths",
      color = "red"
    )
  })
  
  # cumulative_deaths box
  output$cumulative_deaths <- renderValueBox({
    
    valueBox(
      value =
        tags$p( general_stat_filtered() %>% 
                  pull(cumulative_deaths),
                style = "font-size: 70%;"),
      subtitle = "Cumulative Deaths",
      color = "red"
    )
  })
   
  
  # life covid plot_2
  ##########################################
  output$life_covid_plot_2 <- renderPlotly({
    
    age_group_trend_hb_ans <- cov_hb_ans %>% 
      filter(sex == "All" & age_group != "All ages") %>% 
      mutate(age_group = factor(age_group, levels = c("Under 5","5 - 14" ,"15 - 44", "45 - 64", "65 - 74", "75 - 84", "85 and over")
      )) %>%
      arrange(age_group) %>% 
      group_by(year, week_ending, age_group) %>% 
      summarise(number_admissions = sum(number_admissions)/1000) %>% 
      mutate(
        moving_avg_2021 = slide_dbl(
          .x = number_admissions,
          .f = ~mean(.,na.rm = TRUE),
          # 2 weeks moving average
          .before = 2
        )  ) %>% 
      mutate(quarter = quarter(week_ending))
    
    
    cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
    ggplotly(
    age_group_trend_hb_ans %>% 
      ggplot()+
      geom_line(aes(x = week_ending, y = moving_avg_2021, group = age_group, colour = age_group))+
      
      geom_rect(aes(xmin = week_ending, xmax = dplyr::lead(week_ending), ymin = 0, ymax = 6.5,
                    fill = factor(quarter)), alpha = .3, show.legend = FALSE) +
      scale_fill_manual(values = alpha(c("darkblue", "transparent" ,"transparent" ,"transparent"), 0.6))+
      geom_vline(xintercept = as.Date(ymd("2020-03-16")), linetype= 2, color = "black", size=0.6)+
      
      annotate(geom = "text",
               label = c("Lockdown"),
               x = c( as.Date(ymd("2020-03-16"))),
               y = c(6.1),
               vjust = 1,
               hjust = -.05) +
      
      labs(title = "2 weeks Moving Average Hospital Admission Per Age Group in 2020 - 2021")+
      xlab("Time (date)")+
      ylab("Average Admission Count (per 1'000)")+
      scale_colour_brewer(palette="Set1")+ 
      theme(panel.background = element_rect(fill = 'transparent'),
            panel.grid.minor = element_line(colour = 'lightgrey'),
            panel.grid.major = element_line(colour = 'lightgrey'),
            legend.position="top")+
      scale_x_date(date_breaks = "4 months",
                   date_minor_breaks = "1 months",
                   date_labels = "%b-%y")
    )
  })
  
  
  ######################
  # LIFE Covid PLOT_1
  output$life_covid_plot_1 <- renderPlotly({ 
    
    
    # covid_hospital_activity_age & sex dataset
    cov_hb_ans <- df_cov_hb_ans %>% 
      select(-percent_variation) %>% 
      filter(admission_type != "All") %>% 
      mutate(week = week(week_ending),
             year = as.character(year))
    
    # For all trend, maybe a slider
    # ALL GENERAL TREND, SEX = ALL, AGE = ALL
    all_trend_hb_ans <- cov_hb_ans %>% 
      filter(age_group == "All ages" & sex == "All") %>% 
      group_by(year, week_ending, admission_type) %>% 
      summarise(number_admissions = sum(number_admissions)/1000,
                average20182019  = sum(average20182019)/1000) %>% 
      mutate(
        moving_avg_2021 = slide_dbl(
          .x = number_admissions,
          .f = ~mean(.,na.rm = TRUE),
          # 2 weeks moving average
          .before = 2
        )  ) %>% 
      mutate(
        moving_avg_1819 = slide_dbl(
          .x = average20182019,
          .f = ~mean(.,na.rm = TRUE),
          # 2 weeks moving average = 7
          .before = 2
        )  ) %>%
      # Find the winter quarter
      mutate(quarter = quarter(week_ending),
             quarter = case_when(
               quarter == "1" ~ 1,
               quarter == "2" ~ 3,
               quarter == "3" ~ 3,
               quarter == "4" ~ 3
             ))
    
    ggplotly(
    all_trend_hb_ans %>% 
      ggplot()+
      geom_line(aes(x = week_ending, y = moving_avg_2021, colour = admission_type), size=1.0)+
      geom_line(aes(x = week_ending, y = moving_avg_1819, colour = admission_type), linetype = "dashed")+
      geom_rect(aes(xmin = week_ending, xmax = dplyr::lead(week_ending), ymin = 0, ymax = 30, fill = factor(quarter)), alpha = .3, show.legend = TRUE) +
      scale_fill_manual(labels = c("Winter", "Other"), values = alpha(c("darkblue","transparent"), 0.4))+
      
      geom_vline(xintercept = as.Date(ymd("2020-03-16")), linetype= 2, color = "black", size=0.6)+
      
      annotate(geom = "text",
               label = c("Lockdown"),
               x = c( as.Date(ymd("2020-03-16"))),
               y = c(26),
               vjust = 1,
               hjust = -.05) +
      
      theme(panel.background = element_rect(fill = 'transparent'),
            panel.grid.minor = element_line(colour = 'lightgrey'),
            panel.grid.major = element_line(colour = 'lightgrey'),
            legend.position="top")+
      scale_x_date(date_breaks = "4 months",
                   date_minor_breaks = "1 months",
                   date_labels = "%b-%y") +
      labs(title = "2 weeks Moving Average Hospital Admission",
           subtitle = "solid = 2020-2021 data | dash = 2018-2019 data",
           colour = "Admission Type",
           fill = "Seasons"
      )+
      xlab("Time (date)")+
      ylab("Average Admission Count (Per 1'000)")
    )
    })
  
  
 
  
  

  
 ################### ------------------------------------------------------------
 # General MAP OUTPUT
 output$general_map <- renderLeaflet({

   df_hospital_location %>%
     leaflet() %>%
     addTiles() %>%
     addCircleMarkers(lng = ~longitude,
                      lat = ~latitude)
 
   #
 })
  
  # general PLOT OUTPUT
  output$general_plot <- renderPlotly({
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
  # # winter PLOT DATA
   winter_plot_1 <- reactive({
   
  })
   
   # winter page link
   url <- a("BBC NEWS", href="https://www.bbc.co.uk/news/health-59909860")
   output$tab <- renderUI({
     tagList("URL link:", url)
   })
  # winter PLOT OUTPUT
  output$winter_plot_1 <- renderPlotly({
    
    ane_weekly <- ane_weekly_full %>% 
      filter(sex == "All" & age_group == "All ages")
    
    ane_weekly <- ane_weekly %>% 
      mutate(hb_name = case_when(
        hb == "S92000003" ~ "Scotland",
        hb == "S08000015" ~ "Ayrshire and Arran",
        hb == "S08000016" ~ "Borders",
        hb == "S08000017" ~ "Dumfries and Galloway",
        hb == "S08000019" ~ "Forth Valley",
        hb == "S08000020" ~ "Grampian",
        hb == "S08000022" ~ "Highland",
        hb == "S08000024" ~ "Lothian",
        hb == "S08000025" ~ "Orkney",
        hb == "S08000026" ~ "Shetland",
        hb == "S08000028" ~ "Western Isles",
        hb == "S08000029" ~ "Fife",
        hb == "S08000030" ~ "Tayside",
        hb == "S08000031" ~ "Greater Glasgow and Clyde",
        hb == "S08000032" ~ "Lanarkshire",
        TRUE ~ as.character(NA))) %>% 
      group_by(hb_name, year, week_ending, number_attendances) 
    
    ane_weekly <- ane_weekly %>% 
      filter(hb_name != "Scotland")
    ane_weekly_trend <- ane_weekly %>% 
      arrange(hb_name) %>% 
      group_by(year, week_ending, hb_name) %>% 
      summarise(number_attendances = sum(number_attendances)) %>%   
      mutate(
        moving_avg = slide_dbl(
          .x = number_attendances,
          .f = ~mean(.,na.rm = TRUE),
          # 2 weeks moving average
          .before = 2
        )  ) %>% 
      # Mutate back to quarter
      # Adjust Season
      mutate(quarter = quarter(week_ending),
             season = case_when(
               quarter == 1 ~ "winter",
               quarter == 2 ~ "other",
               quarter == 3 ~ "other",
               quarter == 4 ~ "other"
             )) 
    ggplotly(
    ane_weekly_trend %>% 
      ggplot() +
      geom_vline(xintercept = as.Date(ymd("2020-03-16")), linetype= 2, color = "black", size=0.75) +
      geom_line(  aes(x = week_ending, y = moving_avg, group = hb_name, colour = hb_name))+
      geom_rect(aes(xmin = week_ending, xmax = dplyr::lead(week_ending), ymin = 0, ymax = 4500,
                    fill = factor(season == "winter")), alpha = .3, show.legend = TRUE) +
      scale_fill_manual(labels = c("winter", "other"), values = alpha(c("transparent", "darkblue"), 0.4)) +
      
      annotate(geom = "text",
               label = c("Lockdown"),
               x = c( as.Date(ymd("2020-03-16"))),
               y = c(4300),
               vjust = 1,
               hjust = -.05) +
      
      labs(title = "",
           subtitle = "by Health Board\n",
           colour = " Health Board\n") +
      xlab("Time (date)")+
      ylab("Average Attendance Count") +
      # choose grid
      scale_x_date(date_breaks = "4 months",
                   date_minor_breaks = "1 months",
                   date_labels = "%b-%y") +
      theme(        legend.position = "bottom",
                    legend.justification = c("right", "top"),
                    legend.box.just = "right",
                    legend.margin = margin(6, 6, 6, 6),
                    legend.text = element_text(colour="slategray", size=8),
                    panel.background = element_rect(fill = 'transparent'),
                    panel.grid.minor = element_line(colour = 'lightgrey'),
                    panel.grid.major = element_line(colour = 'lightgrey')
      )
    )
  })
  
  # winter_plot_2 OUTPUT
  output$winter_plot_2 <- renderPlotly({
    
    hosp_act <- hospital_activty_dep %>% 
      mutate(q_year = str_c(year, " Q",quarter)) %>% 
      filter(admission_type %in% c("Emergency Inpatients","All Inpatients and Day cases" ))
    
    hosp_act_summary <-hosp_act %>% 
      mutate(q_year = factor
             (q_year, levels =
                 c("2016 Q2","2016 Q3","2016 Q4",
                   "2017 Q1", "2017 Q2","2017 Q3","2017 Q4",
                   "2018 Q1", "2018 Q2","2018 Q3","2018 Q4",             
                   "2019 Q1", "2019 Q2","2019 Q3","2019 Q4",            
                   "2020 Q1", "2020 Q2","2020 Q3","2020 Q4",           
                   "2021 Q1", "2021 Q2" ))) %>% 
      arrange(q_year) %>% 
      group_by(q_year, admission_type) %>% 
      summarise(tot_sum = (sum(episodes)/100000))
    
    hosp_act_summary <-hosp_act_summary %>% 
      mutate(year = (str_sub(q_year,1,4))) %>% 
      mutate(quarter = as.numeric(str_sub(q_year,-1,-1))) 
    
    
    ggplotly(hosp_act_summary %>% 
               ggplot() +
               geom_bar(aes(x = quarter, y = tot_sum, group = admission_type, 
                            fill = admission_type), 
                        stat = "identity", alpha = 0.7, position = "dodge") +
               labs(title = "\n",
                    fill = "")+
               xlab("Time (Year/Quarter)")+
               ylab("Admission Count (100,000s)\n")  +
               theme(legend.position = "bottom",
                     #      legend.justification = c("right", "top"),
                     legend.box.just = "right",
                     legend.margin = margin(6, 6, 6, 6),
                     legend.text = element_text(colour="slategray", size=8)
               ) +
               facet_wrap( ~year, )
             ) 
  })
  
  
  output$table_output <- renderTable({
    general_stat <- df_general_stat %>% 
      select(date, ca, ca_name, daily_positive, cumulative_positive, daily_deaths, cumulative_deaths) %>% 
      arrange(date) %>% 
      group_by(ca) %>% 
      slice_tail(n  = 1)
    
    all_general_stat <- general_stat %>% 
      ungroup() %>% 
      group_by(date) %>% 
      summarise(daily_positive = sum(daily_positive),
                cumulative_positive = sum(cumulative_positive),
                daily_deaths = sum(daily_deaths),
                cumulative_deaths = sum(cumulative_deaths))
  })
  
  
  
}
