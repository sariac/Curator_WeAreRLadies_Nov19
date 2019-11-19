##Adapted from https://cran.r-project.org/web/packages/sqldf/sqldf.pdf
#Instructions: 
#install the package so that you can see the output, 
#run the first option and find as many alternatives as you can using your fav functions. ENJOY!
install.packages("sqldf")
library("sqldf")

# head
a1 <- sqldf("select * from warpbreaks limit 6")
a2 <- head(warpbreaks)

# subset
b1 <- sqldf("select * from CO2 where Plant like 'Qn%'")
b2 <- subset(CO2, grepl("^Qn", Plant))

c1 <- sqldf("select * from warpbreaks where breaks between 20 and 30")
c2 <- subset(warpbreaks, breaks >= 20 & breaks <= 30)

# rbind
d1 <- sqldf("select * from a1 union all select * from c1")
d2 <- rbind(a1, c1)

# aggregate - avg conc and uptake by Plant and Type
e1 <- sqldf('select Species, avg("Sepal.Length") `Sepal.Length`,
             avg("Sepal.Width") `Sepal.Width` from iris group by Species')
e2 <- aggregate(iris[1:2], iris[5], mean) # do the avg of the first two cols, group by col n5

# by - avg conc and total uptake by Plant and Type
f1 <- sqldf('select Species, avg("Sepal.Length") `mean.Sepal.Length`,
             avg("Sepal.Width") `mean.Sepal.Width`,
             avg("Sepal.Length"/"Sepal.Width") `mean.Sepal.ratio` from iris
             group by Species')
f2 <- do.call(rbind, by(iris, iris[5], function(x) with(x,
                                                         data.frame(Species = Species[1],
                                                                    mean.Sepal.Length = mean(Sepal.Length),
                                                                    mean.Sepal.Width = mean(Sepal.Width),
                                                                    mean.Sepal.ratio = mean(Sepal.Length/Sepal.Width)))))
