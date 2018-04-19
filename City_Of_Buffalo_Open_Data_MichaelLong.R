library(ggplot2)
library(ggmap)
city_data <- read.csv(file="Crime_Incidents.csv")
city_data$incident_type_primary<-tolower(city_data$incident_type_primary)

#crime types 
sexual_incidents <-(city_data$incident_type_primary == "rape") | (city_data$incident_type_primary == "sexual assault")| (city_data$incident_type_primary == "other sexual offense")
# offence <- city_data$incident_type_primary == "assault" 
# offence<- city_data$incident_type_primary == "breaking & entering"
# offence<- city_data$incident_type_primary == "burglary"
# offence<- city_data$incident_type_primary == "crim negligent homicide"
# offence<- city_data$incident_type_primary == "homicide"
# offence<- city_data$incident_type_primary == "larceny/theft"
# offence<- city_data$incident_type_primary == "manslaughter"
# offence<- city_data$incident_type_primary == "murder"
# offence<- city_data$incident_type_primary == "rape"
# offence<- city_data$incident_type_primary == "other sexual offense"
#offence<- city_data$incident_type_primary == "robbery"
# offence<- city_data$incident_type_primary == "sexual abuse"
# offence<- city_data$incident_type_primary == "sexual assault"
# offence<- city_data$incident_type_primary == "theft"
# offence <- city_data$incident_type_primary == "theft of services"
offence <- city_data$incident_type_primary == "theft of vehicle"
# offence<- city_data$incident_type_primary == "uuv"
# offence<- city_data$incident_type_primary == "agg assault on p/officer"
# offence<- city_data$incident_type_primary == "aagr assault"

city_data<-subset(city_data, offence )
#city_data<-subset(city_data, sexual_incidents )

zoom_factor = 14
address = readline(prompt="Enter an address: ")
BuffaloMap <- qmap(address, zoom = zoom_factor, color = "bw", legend = "topleft")

BuffaloMap +
  stat_bin2d(
    aes(x = city_data$longitude, y = city_data$latitude, colour = city_data$incident_type_primary, fill = city_data$incident_type_primary),
    size = .5, bins = 30, alpha = 1/2,
    data = city_data
  ) #one visualization option

BuffaloMap +
  geom_point(aes(x = longitude, y = latitude, colour = incident_type_primary, size = incident_type_primary, alpha=.25),
             data = city_data)+ labs(title="Buffalo Car Thefts Map") #another option with points

