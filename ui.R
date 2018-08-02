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
        class = "col s12 m4", 
        material_card(
          "Yan PAN",
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
      ),
      tags$div(
        class = "col s12 m7", 
        material_card("Experiences"), 
        tags$div(class = "timeline",uiOutput("vTimeline"))
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
  

  

  # 4th ---------------------------------------------------------------------
  
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
  
  # 3rd ---------------------------------------------------------------------
  
  material_side_nav_tab_content(
    side_nav_tab_id = "tab3",
    tags$div(class = "col s12 m12",
             #material_card("", "This brief letter seeks to deliver my application for credit risk analyst in Ikano Bank by elaborating relevant details about my strengths and experiences."),
             
             #material_card("Analytical-Minded Solution Maker", "In my working and studying, the task is always to find the solution despite limitation of systems and tools. Strong background in Economics, Finance and Statistics provides me with a analytics-driven mind that searches for the possibly best solutions and even push ahead in a highly organised manner. The recent project in my current position features for the innovative, reliable and cost-efficient cumulative data analysis/business intelligence, where self-learning in multiple programming language API is utilised. Similar to my previous full-time work in Bank of Shanghai, except for accuracy, emphasis is laid to beyond-numeric analysis that focuses on the implication, and thereafter, deliver the solutions, improvements and advancements. In addition, learning capability with eagerness for new knowledge continuously extends my skills."),
             
             #material_card("Competence and Experiences in both Finance and Statistics", "Since bachelor's study, corporate finance(incl. management accounting, risk management) has greatly attracted my interests. 3-year experience in a major regional branch of a large bank provided me further practical knowledge in financial markets. During both full-time work experiences, I have been actively dealing with accounting and financing affairs in an self-organised systematic manner that seeks for accuracy and efficient.  Empowered by modern stochastic models and statistical tools, such financial knowledge can be materialised into practical skills in insightful financial statement analysis, risk and liquidity modelling etc."),
             
             #material_card("Data Science Enthusiast and Finance Insider", "The meaning of data science is much more than study and work; it is a joyful entertainment for me. Whenever I explore some interesting information, financial statements are also first consulted, as I believe such audited information is unbiased and most reliable among public information. During the past few year, I have succeeded in pursuing academic competence without compromising full-time work"),
             
             #material_card("Team Intelligence", "Artificial Intelligence and Business Intelligence may shape the modern world; however, I firmly believe that Team Intelligence that promotes team efforts and smooth communication is the key to the success. For credit risk analysis, it is critical to communicate in depth to ensure the accurate understanding of the backgrounds, needs and objectives in addition to active learning."),
                          
      material_card(
        "Yan Pan",
        #tags$p("Salary wish: 2550 EUR/month (acceptable level 2250 EUR/month)"),
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
