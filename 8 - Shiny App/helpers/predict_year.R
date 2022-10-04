predict_year <- function(link) {
  spotify_url_start <- "https://open.spotify.com/track/"
  if (str_detect(link, spotify_url_start) == FALSE)
  {print("The link you have entered is not a valid Spotify URL")}
  else {
    link <- str_remove(link, "https://open.spotify.com/track/")
    link <- gsub("?si.*", "", link)
    link <- substr(link,1,nchar(link)-1)
    track <- get_track(link)
    features <- get_track_audio_features(link)
    track_id <- features$id
    features$decade <- NA
    features$playlist_year_id <- NA
    features$artist <- track$artists$name[[1]]
    features$track.name <- track$name[[1]]
    features <- features[, c(19:22, 1:2, 4, 6:11, 17)]
    features$when <- NA 
    features <- features %>%
      rename(track.duration_ms = duration_ms)
    #result <- predict(spotify_fit, features)
    result <- 
      augment(spotify_fit, features)
    if (track_id %in% track_ids) {
      print(paste(features$track.name, "by", features$artist, "was part of the original set data set used to train this model. No results to show.", sep = " "))
    } else if (result$.pred_class == "old")
    {
      print(paste("The model suggests there is a", paste(round(sum(result$.pred_old * 100), digits =2), "%", sep = ""), "likelihood that", features$track.name, 
                  "by", features$artist, "is from before 1995", sep = " "))
    } else 
    {
      print(paste("The model suggests there is a", paste(round(sum(result$.pred_new * 100), digits =2), "%", sep = ""),"likelihood that", features$track.name, 
                  "by", features$artist, "is from after 1995", sep = " "))  
    }
  }
}