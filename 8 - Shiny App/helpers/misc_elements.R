#Read in Model for prediction 
spotify_fit <- readRDS("data/old_new_model.rds")

#Read in track IDs to check if entered link was part of training data set
track_ids <- readRDS('data/track_ids.rds')

# Access Spotify API 
Sys.setenv(SPOTIFY_CLIENT_ID = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
access_token <- get_spotify_access_token()

