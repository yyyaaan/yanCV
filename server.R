library(shinymaterial)

shinyServer(function(input, output, session) {
  
  observeEvent({input$lang; input$showCard}, {
    
    # main object, cache ------------------------------------------------------
    main <- getField(input$lang)
    
    
    # strengths ---------------------------------------------------------------
    output$strTitle <- renderText(main$strMain)
    output$strDetail <- renderText(main$strDetail)
    output$strA <- renderUI(createCollection(main$strAtitle, main$strA))
    output$strB <- renderUI(createCollection(main$strBtitle, main$strB))


    # Vertical Timeline ------------------------------------------------------

    summary <- paste(main$expPosition, "|",
                         main$expStart %>% as.Date() %>% format("%b %Y"), "-", 
                         main$expEnd %>% as.Date() %>% format("%b %Y"))
    if(input$showCard) summary <- paste(summary, "| ", main$expDescription)

    timeEvents <- NULL
    for (i in 1:length(main$expStart)) {
      timeEvents[[i]] <- createEvent(title = main$expMain[i],
                                     summary = summary[i],
                                     detail = main$expDescription[i],
                                     main_icon = main$expIcon[i],
                                     labels = strsplit(main$expChips[i], " ")[[1]], 
                                     img_src = paste0("banner-", main$expImgsrc[i]))
    }
    output$vTimeline <- renderUI(
      tags$div(class = "timelinetop", style = "margin-top: 106px", timeEvents)
    )
  

    
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
    

    # titles in old -----------------------------------------------------------
    
    output$title <- renderUI(h4(main$title))
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
                                    tags$p('Powered by Shiny | This new CV keeps updating'))
                            )
    
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
