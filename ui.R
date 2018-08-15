library(shinymaterial)
library(timevis)

VAR_COL_1 <- "cyan"
VAR_COL_2 <- "cyan" 

material_page(
 
  title = "Using Science, Data and Innovation to Make a Difference",
  nav_bar_color = VAR_COL_1,
  nav_bar_fixed = FALSE,
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
  

  # side nav ----------------------------------------------------------------

  material_side_nav(
    fixed = FALSE,
    image_source = "theme.png",
    
    material_side_nav_tabs(
      side_nav_tabs = c("I am Yan" = "tab1", "Another CV" = "tab2", 
                        "Source" = "tab4", "..."="tab3"),
      icons = c("assignment_ind", "assessment", "code", "drafts")
    ),
    
    tags$hr(),
    tags$div(
      style = "padding-left:22px;",
      material_radio_button("lang", "Language Preference",
                            choices = c(" English" = "ENG", " Suomeksi" = "FIN"," 简体中文" = "CHN")),
      tags$br(),
      material_checkbox("showCard", "display hidden contents", F)
    ),
    
    tags$br(),
    tags$p(class="center-align", tags$small("Copyright Yan PAN 2018"))
  ),
  
  # 1st ---------------------------------------------------------------------
  
  material_side_nav_tab_content(
    side_nav_tab_id = "tab1",
    material_row(
      tags$div(
        class = "col s12 m7", 
        material_card("Yan's Experiences"), 
        tags$div(class = "timeline",uiOutput("vTimeline"))
      ),
      tags$div( 
        class = "col s12 m5 leftmod", 
        material_card(
          "Yan PAN",
          "M.Sc. Statistics + M.Sc. Economics",tags$br(), tags$br(),
          tags$i(class = "tiny material-icons", "email"), tags$a(href = "mailto:yan@yan.fi", "yan@yan.fi  "),
          tags$i(class = "tiny material-icons", "phone_in_talk"),  tags$a(href = "tel:+358449199857", "+358 44 919 9857  "),
          tags$br(),
          tags$i(class = "tiny material-icons", "dvr"),  tags$a(href = "https://boring.fi", "https://boring.fi (projects/data-server)  "),
          tags$br(),
          tags$i(class = "tiny material-icons", "phonelink"),  tags$a(href = "https://yan.fi", "https://yan.fi  (general)")
        ),
        material_card( 
          uiOutput("strTitle"),
          uiOutput("strDetail")
        ),
        material_card("",uiOutput("strA")),
        material_card("",uiOutput("strB")),
        tags$p(style = "font-style: italic; text-align: center", 
               tags$a(href = "http://cv.yan.fi", "more details at http://cv.yan.fi"))
      )
    )
  ),
  
  
  # 2nd ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab2",
    material_row(
      material_column(width = 10, offset = 2, uiOutput("title"))
    ),
    material_row(
      material_column(width = 12, material_card("", timevisOutput("myExp")))
    ),
    material_row(
      tags$div(
        class="col s12 m8",
        material_card(textOutput("expt"), dataTableOutput("myExpDT"))
      ),
      tags$div(
        class = "col s12 m4",
        tags$ul(
          class="collection",
           tags$li(class = "collection-item avatar",
                   tags$i(class = paste(VAR_COL_1, "circle material-icons"), "dashboard"),
                   uiOutput("At")),
           tags$li(class = "collection-item",uiOutput("A")),
           tags$li(class = "collection-item avatar",
                   tags$i(class = paste(VAR_COL_1, "circle material-icons"), "credit_card"),
                   uiOutput("Bt")),
           tags$li(class = "collection-item",uiOutput("B")),
           tags$li(class = "collection-item avatar",
                   tags$i(class = paste(VAR_COL_1, "circle material-icons"), "developer_mode"),
                   uiOutput("Ct")),
           tags$li(class = "collection-item",uiOutput("C"))
        )
      )
    )
  ),
  

  

  # 3rd ---------------------------------------------------------------------
  
  material_side_nav_tab_content(
    side_nav_tab_id = "tab4",
    material_row(
      tags$div(class="col s12 m6",
               material_card("ui.R", tags$pre(includeText("ui.R")))),
      tags$div(class="col s12 m6",
               material_card("server.R", tags$pre(includeText("server.R")))),
      tags$div(class="col s12 m6",
               material_card("global.R", tags$pre(includeText("global.R"))))
    )
  ),
  
  # 4th ---------------------------------------------------------------------
  
  material_side_nav_tab_content(
    side_nav_tab_id = "tab3",
    tags$div(class = "col s12 m12",
      material_card(
        "Yan Pan",
        tags$br(),
        tags$i(class = "tiny material-icons", "email"), tags$a(href = "mailto:yan@yan.fi", "yan@yan.fi  "),
        tags$i(class = "tiny material-icons", "phone_in_talk"),  tags$a(href = "tel:+358449199857", "+358 44 919 9857  "),
        tags$br(),
        tags$i(class = "tiny material-icons", "dvr"),  tags$a(href = "https://boring.fi", "https://boring.fi (projects/data-server)  "),
        tags$br(),
        tags$i(class = "tiny material-icons", "phonelink"),  tags$a(href = "https://yan.fi", "https://yan.fi  (general)")
      )
    )
  )
)

# nav{display:none} .timeline .timeline-event .timeline-content {margin-top:-179px} .timelinetop{margin-top:189px !important;}.grey.lighten-4 {background-color: transparent !important;}
