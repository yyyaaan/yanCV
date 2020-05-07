
shinyServer(function(input, output, session) {
  

  # UI finetouching ---------------------------------------------------------
  
  delay(5000, toggleClass(id = "discover", class = "open"))
  delay(8000, toggleClass(id = "discover", class = "open"))
  addClass(class = "hide-on-small-only", selector = ".brand-logo")
  delay(1999, addClass(class = "hoverable", selector = ".timeline-content"))
  hide(id = "outOnClickFrame")
  hide(id = "timevis_title_row")
  hide(id = "more_info")

  observeEvent({input$lang; input$showCard}, {
    
    # main object, cache ------------------------------------------------------
    main <- getField(input$lang)
    
    # strengths ---------------------------------------------------------------
    
    output$strTitle  <- renderText(main$strMain)
    output$strDetail <- renderText(main$strDetail)
    output$strA <- renderUI(createCollection(main$strAtitle, main$strA))
    output$strB <- renderUI(createCollection(main$strBtitle, main$strB))


    # Vertical Timeline ------------------------------------------------------

    summary <- paste(main$expPosition, "|",
                     main$expStart %>% as.Date() %>% format("%b %Y"), "-", 
                     ifelse(difftime(main$expEnd, Sys.Date()) > 0, "Current", 
                            main$expEnd %>% as.Date() %>% format("%b %Y")))
    if(input$showCard) summary <- paste(summary, "| ", main$expDescription)
    

    # special layout (printting) ----------------------------------------------

    if(input$showCard){
      hide(id = "timeline_title")
      show(id = "more_info")
      addClass(class = "special", selector = ".timeline")
      delay(1999, addClass(class = "specialx", selector = ".timeline-content"))
    } 
    if(!input$showCard) {
      show(id = "timeline_title")
      hide(id = "more_info")
      removeClass(class = "special", selector = ".timeline")
      delay(1999, removeClass(class = "specialx", selector = ".timeline-content"))
    } 

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
    
    output$myExp <- renderTimevis(timevis(
      data = data.frame(id = 1:length(main$expStart),
                        start = main$expStart,
                        end = main$expEnd,
                        content = paste0('<b>', main$expMain,'</b><br />', main$expPosition),
                        group = main$expGroupNo), 
      groups = data.frame(id = unique(main$expGroupNo), 
                          content = unique(main$expType)), 
      options= list(zoomKey = 'ctrlKey')))
    

    # data table --------------------------------------------------------------
    
    expDf <- data.frame(start       = main$expStart,
                        company     = main$expMain,
                        position    = main$expPosition,
                        description = main$expDescription)
    output$myExpDT <- renderDT(datatable(expDf,options = list(dom = 't')))
  
    

    # titles in old -----------------------------------------------------------
    
    output$title <- renderUI(h4(main$title))
    output$expt  <- renderText(main$expFieldTitle)
    
    
    
    # Skill boxes -------------------------------------------------------------
    
    output$At <- renderUI(tags$h4(main$skillAtitle))
    output$A  <- renderText(main$skillA)
    output$Bt <- renderUI(tags$h4(main$skillBtitle))
    output$B  <- renderText(main$skillB)
    output$Ct <- renderUI(tags$h4(main$skillCtitle))
    output$C  <- renderText(main$skillC)
    
    output$info <- renderUI(
      tagList('This is an interactive web application',
              tags$br(),
              tags$p('available interactively at cv.yan.fi'),
              tags$img(src = "qr.png", width = "39%"),
              tags$p('Powered by Shiny | This new CV keeps updating')))
    
  })
  

  # Gallery: certification (no language dependence)--------------------------
  certGallery <- NULL
  coursera <- readRDS("coursera.rds")
  for (i in 1:nrow(coursera)) {
    certGallery[[i]] <- tags$div(class = "col s12 m4",
                                 material_card(coursera$name[i],
                                               tags$p(coursera$detail[i]),
                                               tags$img(src = coursera$img[i], width = "100%"),
                                               HTML(coursera$link[i])))
  }
  output$out_coursera <- renderUI(tagList(certGallery))
  
  
  # click modal in timeVis --------------------------------------------------
  
  observeEvent(input$myExp_selected, {
    # load data for improvded performance, must be reactive
    main <- getField(input$lang)
    i    <- as.numeric(input$myExp_selected)

    output$outOnClick  <- renderUI(tagList(
      tags$img(src = main$expImgsrc[i], height = 80),
      tags$p(tags$b(main$expMain[i])),
      tags$p(main$expPosition[i]),
      tags$p(main$expDescription[i])))
  
    show(id = "outOnClickFrame")
  })
  
  observeEvent(input$dismissPop, {
    hide(id = "outOnClickFrame")
  })
})
