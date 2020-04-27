VAR_COL_1 <- "cyan"
VAR_COL_2 <- "cyan" 
feature_discovery <- '
    <div id="discover" class="tap-target-wrapper" 
         style="border-bottom-right-radius: 90%; background-color: rgb(0,188,212, 0.8); 
                left:-20px; top:-20px; height:399px; width:399px; position: fixed;">
    <div class="tap-target-wave" style="top: 0px; left: 0px; width: 112px; height: 112px;">
      <a class="btn btn-floating btn-large cyan tap-target-origin"><i class="material-icons">menu</i></a>
    </div>
    <h5 style="top:99px; left:109px; position:absolute; color:white"> 
      Change language/style<br />切换语言/风格<br />vaihda kieltä ja tyyliä
    </p>
    </div>
'

material_page(
 
  title = "Using Science, Data and Innovation to Make a Difference",
  nav_bar_color = VAR_COL_1,
  nav_bar_fixed = FALSE,
  useShinyjs(),
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
            tags$title("Yan - Using Science, Data and Innovation to Make a Difference")),
  

  # side nav ----------------------------------------------------------------

  material_side_nav(
    fixed = FALSE,
    image_source = "theme.png",
    material_side_nav_tabs(
      side_nav_tabs = c("Main" = "tab1", "Timelines" = "tab2", 
                        "Source" = "tab4", "IamYan"="tab3"),
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
    tags$p(class="center-align", tags$small("Copyright Yan PAN 2020"))
  ),
  

  # other HTML --------------------------------------------------------------
  HTML(feature_discovery),
  
  # 1st ---------------------------------------------------------------------
  
  material_side_nav_tab_content(
    side_nav_tab_id = "tab1",

    material_row(
      tags$div(
        class = "col s12 m7", 
        material_card(id = "timeline_title", "Kokemukset | Expereinces"), 
        tags$div(class = "timeline",uiOutput("vTimeline"))
      ),
      tags$div( 
        class = "col s12 m5 leftmod", 
        material_card(
          "Yan PAN",
          "M.Sc. Statistics + M.Sc. Economics",tags$br(), tags$br(),
          tags$i(class = "tiny material-icons", "email"), tags$a(href = "mailto:yan@yan.fi", "yan@yan.fi  "),
          tags$br(),
          tags$i(class = "tiny material-icons", "phone_in_talk"),  tags$a(href = "tel:+358449199857", "+358 44 919 9857  "),
          tags$br(),
          tags$i(class = "tiny material-icons", "phonelink"),  tags$a(href = "https://yan.fi", "https://yan.fi   ")
        ),
        material_card( 
          uiOutput("strTitle"),
          uiOutput("strDetail")
        ),
        material_card("",uiOutput("strA")),
        material_card("",uiOutput("strB")),
        material_card("", id = "more_info",
                      tags$p(style = "font-style: italic; text-align: center", 
                             tags$img(src = "qr.png", width = '99px'),
                             tags$br(),
                             tags$a(href = "http://cv.yan.fi", 
                                    "lisätiedot/details at https://cv.yan.fi"))),
      )
    )
  ),
  
  
  # 2nd ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab2",
    material_row(
      id = "timevis_title_row",
      material_column(width = 10, offset = 2, uiOutput("title"))
    ),
    material_row(
      material_column(width = 12, material_card("", timevisOutput("myExp"), tags$i("click to view detalis")))
    ),
    material_row( 
      id    = "outOnClickFrame",
      class = "scale-transition scale-in center-align", # pop-up on click timevis
      material_column(width = 8, offset = 2, 
                      material_card("", uiOutput("outOnClick"),
                                    material_button("dismissPop", "Dismiss")))
    ),
    material_row(
      tags$div(
        class="col s12 m8",
        material_card(textOutput("expt"), DTOutput("myExpDT"))
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
        tags$p(tags$i(class = "tiny material-icons", "email"), tags$a(href = "mailto:yan@yan.fi", "yan@yan.fi  ")),
        tags$p(tags$i(class = "tiny material-icons", "phone_in_talk"),  tags$a(href = "tel:+358449199857", "+358 44 919 9857  ")),
        tags$p(tags$i(class = "tiny material-icons", "phonelink"),  tags$a(href = "https://yan.fi", "https://yan.fi  (general)")),
        tags$br(), tags$div(class = "divider"), tags$br(),
        tags$i(class = "tiny material-icons", "dvr"),  
        tags$span("Powered by "),
        tags$a(href = "https://datatables.net/", "datatables "),
        tags$a(href = "https://materializecss.com/", "Materialize "),
        tags$a(href = "https://shiny.rstudio.com/", "shiny "),
        tags$a(href = "https://visjs.org/", "vis.js "),
        tags$span(" and R-package "),
        tags$a(href = "https://cran.r-project.org/package=DT", "DT "),
        tags$a(href = "https://cran.r-project.org/package=shinyjs", "shinyjs "),
        tags$a(href = "https://cran.r-project.org/package=shinymaterial", "shinymaterial "),
        tags$a(href = "https://cran.r-project.org/packages=timevis", "timevis "),
        tags$span(" with customized CSS and jQuery. Programmed mainly in R.")
      )
    )
  )
)
