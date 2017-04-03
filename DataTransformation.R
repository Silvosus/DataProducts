download.file("https://data.cityofchicago.org/api/views/ijzp-q8t2/rows.csv?accessType=DOWNLOAD", destfile = "Crimes_2001_to_present.csv")
crime <- read.csv("Crimes_2001_to_present.csv")

# Gathers the counts of criminal offenses into one row for each District/Year
# pairing.
DistYr = function(x,y) {
    charges = crime[crime$Year == y & crime$District == x,6]
    data.frame( Year = y,
        District = paste("District", x),
        Trespass = length(which(charges == "CRIMINAL TRESPASS")),
        Theft = length(which(charges == "THEFT")),
        Battery = length(which(charges == "BATTERY")),
        Narcotics = length(which(charges == "NARCOTICS")),
        Assualt = length(which(charges == "ASSAULT")),
        Robbery = length(which(charges == "ROBBERY")),
        OtherOffense = length(which(charges == "OTHER OFFENSE")),
        Deceptive = length(which(charges == "DECEPTIVE PRACTICE")),
        CriminalDmg = length(which(charges == "CRIMINAL DAMAGE")),
        Burglary = length(which(charges == "BURGLARY")),
        SexOffense = length(which(charges == "SEX OFFENSE")),
        Weapons = length(which(charges == "WEAPONS VIOLATION")),
        Kidnapping = length(which(charges == "KIDNAPPING")),
        Interference = length(which(charges == "INTERFERENCE WITH PUBLIC OFFICER")),
        SexAssualt = length(which(charges == "CRIM SEXUAL ASSAULT")),
        VehicleTheft = length(which(charges == "MOTOR VEHICLE THEFT")),
        Prostitution = length(which(charges == "PROSTITUTION")),
        Arson = length(which(charges == "ARSON")),
        PublicPeace = length(which(charges == "PUBLIC PEACE VIOLATION")),
        ChildrenOffense = length(which(charges == "OFFENSE INVOLVING CHILDREN")),
        Liquor = length(which(charges == "LIQUOR LAW VIOLATION")),
        Intimidation = length(which(charges == "INTIMIDATION")),
        Stalking = length(which(charges == "STALKING")),
        Gambling = length(which(charges == "GAMBLING")),
        NonCriminal = length(which(charges == "NON-CRIMINAL" | charges == "NON - CRIMINAL" | charges == "NON-CRIMINAL (SUBJECT SPECIFIED)")),
        Obscenity = length(which(charges == "OBSCENITY")),
        PublicIndecency = length(which(charges == "PUBLIC INDECENCY")),
        Narcotic = length(which(charges == "OTHER NARCOTIC VIOLATION")),
        Homicide = length(which(charges == "HOMICIDE")),
        CCViolation = length(which(charges == "CONCEALED CARRY LICENSE VIOLATION")),
        Trafficking = length(which(charges == "HUMAN TRAFFICKING")),
        Ritualism = length(which(charges == "RITUALISM")),
        Domestic = length(which(charges == "DOMESTIC VIOLENCE"))
    )
}

# Use the above function to create the data by counting the occurance of each
# crime for each district and year pair.
crCount = data.frame()
for(y in unique(crime$Year)) {
    for(d in unique(crime$District)) {
        # for some reason there are NA entries in the District field
        # removing those to preserve geographic bindings
        if(!is.na(d)) {
            crCount = rbind(crCount, DistYr(d, y))
            print(paste("Processed", d, "for year", y))
        }
    }
}

# add one last variable, the total number of crimes reported
crCount$Total = rowSums(crCount[3:35], na.rm = TRUE)

# now write it out
write.csv(crCount, "Crime_Counts.csv", row.names = FALSE)