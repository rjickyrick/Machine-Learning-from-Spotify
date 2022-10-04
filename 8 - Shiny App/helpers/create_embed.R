create_embed <- function(link) {
  spotify_url_start <- "https://open.spotify.com/track/"
  if (str_detect(link, spotify_url_start) == FALSE) {
    code <- "" 
  }
  else {
    link <- str_remove(link, "https://open.spotify.com/track/")
    link <- gsub("?si.*", "", link)
    link <- substr(link,1,nchar(link)-1)
    code <- paste0("<iframe width='100%' height='75' src='https://open.spotify.com/embed/track/", link ,"' frameborder='0' allowfullscreen></iframe>")
  }
}