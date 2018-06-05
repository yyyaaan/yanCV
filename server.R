library(shinymaterial)

shinyServer(function(input, output, session) {
  
  observeEvent(input$lang, {
    # cache
    main <- getField(input$lang)
    
    

    # maintitle ---------------------------------------------------------------
    output$mainTitle <- renderText(main$main)
    
    # Vertical Timeline -------------------------------------------------------
    
    timeEvents <- NULL
    for (i in 1:length(main$expStart)) {
      timeEvents[[i]] <- createEvent(title = main$expMain[i],
                                     summary = main$expPosition[i],
                                     detail = main$expDescription[i],
                                     labels = strsplit(main$expType[i], " ")[[1]], 
                                     img_src = paste0("banner_", main$expImgsrc[i]))
    }
    output$vTimeline <- renderUI(tagList(timeEvents))
    

    
    
    
    
    # timevis -----------------------------------------------------------------
    output$myExp <- renderTimevis(timevis(data = data.frame(id = 1:length(main$expStart),
                                                            start = main$expStart,
                                                            end = main$expEnd,
                                                            content = paste0('<b>', main$expMain,'</b><br />', main$expPosition),
                                                            group = main$expGroupNo), 
                                          groups = data.frame(id = unique(main$expGroupNo), 
                                                              content = unique(main$expType)), 
                                          options= list(zoomKey = 'ctrlKey')))
    

    # data table --------------------------------------------------------------
    
    expDf <- data.frame(start = main$expStart,
                        company = main$expMain,
                        position = main$expPosition,
                        description = main$expDescription)
    output$myExpDT <- renderDataTable(expDf,options = list(dom = 't'))
    output$title <- renderUI(tagList(h2(main$main),h4(main$title)))
    output$expt <- renderText(main$expFieldTitle)
    
    
    
    # Skill boxes -------------------------------------------------------------
    
    output$At <- renderUI(tags$h4(main$skillAtitle))
    output$A <- renderText(main$skillA)
    output$Bt <- renderUI(tags$h4(main$skillBtitle))
    output$B <- renderText(main$skillB)
    output$Ct <- renderUI(tags$h4(main$skillCtitle))
    output$C <- renderText(main$skillC)
    
    output$info <- renderUI(tagList('This is an interactive web application',
                                    tags$br(),
                                    tags$p('available interactively at cv.yan.fi'),
                                    tags$img(src = "qr.png", width = "39%"),
                                    tags$p('Powered by Shiny | This new CV keeps updating')))
    
  })
  
  
  # click modal in timeVis --------------------------------------------------
  
  observeEvent(input$myExp_selected, {
    # load data for improvded performance, must be reactive
    main <- getField(input$lang)
    i <- as.numeric(input$myExp_selected)
    
    material_modal(
      modal_id = "curModal",
      button_text = "x",
      display_button = FALSE,
      title = main$expMain[i],
      tagList(tags$img(src = main$expImgsrc[i], height = 80),
              tags$br(),
              tags$p(main$expPosition[i]),
              tags$p(main$expDescription[i]))
    )
    
    open_material_modal(session, "curModal")
  })
})
