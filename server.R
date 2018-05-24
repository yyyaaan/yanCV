library(shinymaterial)
  

shinyServer(function(input, output, session) {
  
  observeEvent(input$lang, {
      # cache
    exp <- getExp(input$lang)
    fld <- getField(input$lang)
    
      #fill in with selected language
    output$myExp <- renderTimevis(timevis(exp$ts, groups = exp$grp,
                                          options= list(zoomKey = 'ctrlKey')))
    output$myExpDT <- renderDataTable(exp$dt,options = list(dom = 't'))
    output$title <- renderUI(tagList(h2(fld$main),h4(fld$title)))
    output$expt <- renderText(fld$expt)
    
    output$At <- renderUI(tags$h4(class = "center-align", fld$At))
    output$A <- renderText(fld$A)
    output$Bt <- renderUI(tags$h4(class = "center-align", fld$Bt))
    output$B <- renderText(fld$B)
    output$Ct <- renderUI(tags$h4(class = "center-align", fld$Ct))
    output$C <- renderText(fld$C)
    
    output$info <- renderUI(tagList('This is an interactive web application',
                                    tags$br(),
                                    tags$p('available interactively at cv.yan.fi'),
                                    #tags$img(src = "qr.png", width = "39%"),
                                    tags$p('Powered by Shiny | This new CV keeps updating')))
  
  })

  
    # modal dialog on click
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
