library(shinymaterial)


shinyServer(function(input, output, session) {
  
  observeEvent(input$lang, {
    # cache
    exp <- getExp(input$lang)
    fld <- getField(input$lang)
    
    
    # Vertical Timeline -------------------------------------------------------
    
    timeEvents <- NULL
    for (i in 1:nrow(exp$dt)) {
      timeEvents[[i]] <- createEvent(title = exp$dt[i,4],
                                     summary = paste(exp$dt[i,1], "-", exp$dt[i,2], exp$dt[i,5]),
                                     detail = exp$dt[i,6],
                                     labels = exp$dt[i,3], 
                                     img_src = paste0("banner_",exp$ts[i,6]))
    }
    output$vTimeline <- renderUI(tagList(timeEvents))
    
    
    
    output$myExp <- renderTimevis(timevis(data.frame(exp$ts, color = '#29ccb2'), groups = exp$grp, 
                                          options= list(zoomKey = 'ctrlKey')))
    output$myExpDT <- renderDataTable(exp$dt,options = list(dom = 't'))
    output$title <- renderUI(tagList(h2(fld$main),h4(fld$title)))
    output$expt <- renderText(fld$expt)
    
    
    
    # Skill boxes -------------------------------------------------------------
    
    output$At <- renderUI(tags$h4(fld$At))
    output$A <- renderText(fld$A)
    output$Bt <- renderUI(tags$h4(fld$Bt))
    output$B <- renderText(fld$B)
    output$Ct <- renderUI(tags$h4(fld$Ct))
    output$C <- renderText(fld$C)
    
    output$info <- renderUI(tagList('This is an interactive web application',
                                    tags$br(),
                                    tags$p('available interactively at cv.yan.fi'),
                                    tags$img(src = "qr.png", width = "39%"),
                                    tags$p('Powered by Shiny | This new CV keeps updating')))
    
  })
  
  
  # click modal in timeVis --------------------------------------------------
  
  observeEvent(input$myExp_selected, {
    # load data for improvded performance, must be reactive
    exp <- getExp(input$lang)
    sel <- input$myExp_selected
    
    showModal(modalDialog(
      easyClose = T, fade = F,
      footer = NULL,
      title = exp$dt[sel, 4],
      tagList(tags$img(src = exp$ts[sel,6], height = 80),
              p(exp$dt[sel,5]),
              p(exp$dt[sel,6]))
    ))
  })
})
