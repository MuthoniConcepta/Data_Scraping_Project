install.packages("dplyr")
install.packages("rvest")

library(dplyr)
library(rvest)

link = "https://www.imdb.com/search/title/?genres=Musical&ref_=nv_sr_srsg_0_tt_5_nm_1_q_mu"
page = read_html(link)

name= page%>% html_nodes(".lister-item-header a") %>% html_text()
year= page%>% html_nodes(".text-muted.unbold") %>% html_text()
genre= page%>% html_nodes(".genre") %>% html_text()
rating= page%>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
description= page%>% html_nodes(".text-muted+ .text-muted , .ratings-bar+ .text-muted") %>% html_text()

summary(rating)
summary(name)
summary(description)
summary(genre)
summary(year)

# Extracted ratings (some missing)
# Define the positions where you want to insert NA
#Identified the missing positions manually from the data source
positions_to_insert_na <- c(2, 4, 6, 8, 14)

# Create a copy of the rating vector with length 50 filled with NA
rating_modified <- rep(NA, 50)

# Fill in the non-empty values from the original rating vector
rating_modified[setdiff(1:50, positions_to_insert_na)] <- rating

# Now, the 'rating_modified' vector has NA values at specified positions, retaining a length of 50

summary(rating_modified)

movie_list<- data.frame(
  Title=name,
  ProductionYear= year,
  Genre= genre,
  Ratings= rating_modified,
  Description= description
)

View(movie_list)

