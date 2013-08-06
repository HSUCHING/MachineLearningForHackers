setwd("C:/Users/i068959/Documents/ML_for_Hackers-master")
ufo <- read.delim(file.path("01-Introduction", "data", "ufo", "ufo_awesome.tsv"),
                  sep = "\t",
                  stringsAsFactors = FALSE,
                  header = FALSE, 
                  na.strings = "")
# Inspect the data frame
summary(ufo)
head(ufo)


# From the data's description file, we will set the column names accordingly using 
# the 'names' function
names(ufo) <- c("DateOccurred", "DateReported",
                "Location", "ShortDescription",
                "Duration", "LongDescription")

good.rows <- ifelse(nchar(ufo$DateOccurred) != 8 |
                      nchar(ufo$DateReported) != 8,
                    FALSE,
                    TRUE)
length(which(!good.rows))      # While 731 rows may seem like a lot, out of over 60K
ufo <- ufo[good.rows, ]        # it is only about 0.6% of the total number of records.
# Now we can convert the strings to Date objects and work with them properly
ufo$DateOccurred <- as.Date(ufo$DateOccurred, format = "%Y%m%d")
ufo$DateReported <- as.Date(ufo$DateReported, format = "%Y%m%d")


get.location <- function(l)
{
  split.location <- tryCatch(strsplit(l, ",")[[1]],
                             error = function(e) return(c(NA, NA)))
  clean.location <- gsub("^ ","",split.location)
  if (length(clean.location) > 2)
  {
    return(c(NA,NA))
  }
  else
  {
    return(clean.location)
  }
}