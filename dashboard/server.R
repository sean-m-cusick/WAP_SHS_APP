server <- function(input, output) {
  

  
  output$selected_distillery <- renderText({
    paste("You selected", input$distillery_input)
  })
  
  distillery_input <- eventReactive(input$selected_distillery,{
    
    distillery_input <- filter(whisky_data_spatial, colnames(whisky_data_spatial=input$selected_distillery))
    return(distillery_input)
  })
  
  output$table <- renderDT({
    distillery_input()
  })
  

  output$map_plot <- renderPlot({
    
    
    whisky_data_spatial %>% 
      # filter(Distillery %in% Region) %>% 
      filter(whisky_data_spatial$Region == input$region_input)
    ggplot() +
      geom_sf(data = scotland, fill = NA, color = "gray45") + # borders of Scotland
      geom_sf(data = whisky_data_spatial, pch = 4, color = "red") + # the distilleries
      theme_void() +
      labs(title = "Whisky of Scotland") +
      theme(plot.title = element_text(hjust = 1/2))
    
    
  })
  
  
  output$flavour_plot <- renderPlot({
    
    whisky_data_spatial %>%
      filter(Distillery == input$distillery_input) %>%
      ggplot() +
      aes(x = intensity, y = note) +
      geom_segment(aes(x = x,
                       xend = x,
                       y = 0,
                       yend = y),
                   color = "gray",
                   lwd = 1.5) +
      geom_point(size = 4,
                 pch = 21,
                 bg = 4,
                 col = 1) +
      scale_x_discrete(labels = c("Capacity",
                                  "Body",
                                  "Sweetness",
                                  "Smoky",
                                  "Medicinal",
                                  "Tobacco",
                                  "Honey",
                                  "Spicy",
                                  "Winey",
                                  "Nutty",
                                  "Malty",
                                  "Fruity",
                                  "Floral"))
    coord_flip()
    
  })
  
}
