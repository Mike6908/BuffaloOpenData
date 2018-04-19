library(ggplot2)
library(ggmap)
city_data <- read.csv(file="Crime_Incidents.csv")
city_data$incident_type_primary<-tolower(city_data$incident_type_primary)
#crime types 
sexual_incidents <-(city_data$incident_type_primary == "rape") | (city_data$incident_type_primary == "sexual assault")| (city_data$incident_type_primary == "other sexual offense")
# officer_attack<- city_data$incident_type_primary == "assault" 
# officer_attack<- city_data$incident_type_primary == "breaking & entering"
# officer_attack<- city_data$incident_type_primary == "burglary"
# officer_attack<- city_data$incident_type_primary == "crim negligent homicide"
# officer_attack<- city_data$incident_type_primary == "homicide"
# officer_attack<- city_data$incident_type_primary == "larceny/theft"
# officer_attack<- city_data$incident_type_primary == "manslaughter"
# officer_attack<- city_data$incident_type_primary == "murder"
# officer_attack<- city_data$incident_type_primary == "rape"
# officer_attack<- city_data$incident_type_primary == "other sexual offense"
#officer_attack<- city_data$incident_type_primary == "robbery"
# officer_attack<- city_data$incident_type_primary == "sexual abuse"
# officer_attack<- city_data$incident_type_primary == "sexual assault"
# officer_attack<- city_data$incident_type_primary == "theft"
# officer_attack<- city_data$incident_type_primary == "theft of services"
 officer_attack<- city_data$incident_type_primary == "theft of vehicle"
# officer_attack<- city_data$incident_type_primary == "uuv"
# officer_attack<- city_data$incident_type_primary == "agg assault on p/officer"
# officer_attack<- city_data$incident_type_primary == "aagr assault"

city_data<-subset(city_data, officer_attack )
city_data<-subset(city_data, sexual_incidents )

zoom_factor = 14
address = readline(prompt="Enter an address: ")
BuffaloMap <- qmap(address, zoom = zoom_factor, color = "bw", legend = "topleft")

BuffaloMap +
  stat_bin2d(
    aes(x = city_data$longitude, y = city_data$latitude, colour = city_data$incident_type_primary, fill = city_data$incident_type_primary),
    size = .5, bins = 30, alpha = 1/2,
    data = city_data
  )

BuffaloMap +
  geom_point(aes(x = longitude, y = latitude, colour = incident_type_primary, size = incident_type_primary, alpha=.25),
             data = city_data)+ labs(title="Buffalo Car Thefts Map")
