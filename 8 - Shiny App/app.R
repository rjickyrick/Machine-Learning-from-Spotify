### LOAD HELPER FILES
source('helpers/load_packages.R', local = TRUE) #Load required R Packages
source('helpers/misc_elements.R', local = TRUE) #Access Spotify API, load Model and Training Data song IDs
source('helpers/predict_year.R', local = TRUE)  #Predict Year function
source('helpers/create_embed.R', local = TRUE)  #Song Embed code function

### UI SIDE ####
ui <- fluidPage(

### Set background colours
  setBackgroundColor(
    color = c("#1DB954", "#ffffff"),
    gradient = "linear",
    direction = "top"
  ),
### CSS  
tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "spotify_app_style.css")),

### Add title
  h2(img(src="spotify.png", height = 45, width = 45), "Is a song on Spotify from before or after 1995?"),
### Include explanatory text 
  includeMarkdown('app_markdown_files/spotify_model_app_text.md'),

### Inputs 
  fluidRow(
    column(12,
  textInput("text", "Enter Spotify Song Link:", value = "", width = "100%"),
  actionButton("runScript", "Run Prediction"),
  )),

### Outputs
  h3(textOutput("result")),
  htmlOutput("song_embed"),

### App footer text
h6(includeMarkdown('app_markdown_files/app_footer_text.md')),
)

### SERVER SIDE 
server <- function(input, output, session) {

### Create reactive element from user input of Spotify link
  link <- reactive({
    input$text
  })

### Observer 'Run Prediction' button click, process Spotify link, return result to outputs.
### See scripts in /helpers folder for create_embed and song_embed functions. 
  observeEvent(input$runScript, { 
    link <- link()
    result <- predict_year(link)
    song_link <- create_embed(link)
    output$result <- renderText(result)
    output$song_embed <- renderUI(HTML(song_link))
  })
  
}
### RUN APP
shinyApp(ui, server)
