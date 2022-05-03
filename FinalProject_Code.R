rm(list=ls())

#read in NYC Airbnb Kaggle
Airbnb<-read.csv("~/Desktop/DataWrangling/Final Project Files/NYC_Airbnb_Data.csv",
                 header = TRUE,na.strings = c(""))
View(Airbnb)

#scrape and crawl data
library(xml2)

url<-paste('https://guides.newman.baruch.cuny.edu/nyc_data/nbhoods')
page<-read_html(url)

#get hyper links
links<-xml_attr(xml_find_all(page, ".//div[@id='s-lg-content-7151850']/ul/li/a"),"href")
links

#filter economics in hyperlinks
neighborhoods_econ<-links[c(2,6,10,14,18,22)]
neighborhoods_econ

#for loop to read in NYC, Bronx, Brooklyn, Manhattan, Queens, & Staten Island scraped data
totalHouseholds<-character(0)
highIncomeHouseholds<-character(0)
medianIncome<-character(0)
meanIncome<-character(0)
for (i in neighborhoods_econ){
  Sys.sleep(5)
  page<-read_html(i)
  households<-xml_text(xml_find_all(page,".//tr/td[2]")[1])
  totalHouseholds<-c(totalHouseholds,households)
  highIncome<-xml_text(xml_find_all(page,".//tr/td[2]")[11])
  highIncomeHouseholds<-c(highIncomeHouseholds,highIncome)
  income<-xml_text(xml_find_all(page,".//tr/td[2]")[18])
  medianIncome<-c(medianIncome,income)
  meanInc<-xml_text(xml_find_all(page,".//tr/td[2]")[19])
  meanIncome<-c(meanIncome,meanInc)
}
totalHouseholds
highIncomeHouseholds
medianIncome
meanIncome

#creating vector with each neighborhood data scraped for
Neighborhood<-c("New York City","Bronx","Brooklyn","Manhattan","Queens","Staten Island")

#creating data frame with neighborhood and related information
scraped_nyc<-data.frame(Neighborhood,totalHouseholds,highIncomeHouseholds,medianIncome,meanIncome)
colnames(scraped_nyc)<-c("Neighborhood","Total Households","High Income Households","Median Income","Mean Income")
View(scraped_nyc)

#Horizontally integrate both data sets
all_nyc<-merge(Airbnb,scraped_nyc,by.x = "neighbourhood_group",by.y = "Neighborhood",all.x = TRUE)
View(all_nyc)


### Analysis #1



### Analysis #2




### Analysis #3



### Analysis #4



### Analysis #5
