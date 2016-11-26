# orf_weather
## convert-to-package

### Intent of this branch
This branch is created to convert the ad-hoc code 
(created in the process of learning R) 
into a package.

### Intent of this convert-to-package.md
This file is intended to serve as ad-hoc documentation, 
recording intentions and decisions,
as well as linking to resources which will be helpful 
in the process of converting this code into a package.

This file is intended as a temporary document, 
which is not likely to ever be merged into the master branch. 
Some of the information initially included here may,
however,
be useful in documenting the package.

### Current status

A minimal package has been created. 
It currently only includes a small number of functions,
and was intended to make sure I had the process correct, 
before working to document and move the other functions currently in use.

### Decisions

#### readWeatherData function

The `readWeatherData` function is key to giving these functions the raw data 
they require. 
Other functions depend on it,
so a staged process for moving it
(and the functions that depend on it)
from the `orfwxfunctions.R` file
to the `orfwx` package
is necessary.

From my reading,
I believe that the 
`readWeatherData` function
may be properly part of a
`data-raw` directory,
at the top level.
It would then be used 
to create an Rdata file
to be installed with the package.

### Links

Started by finding Parker and Wickham, 
then Paulson (2016b), 
and a number of links from Paulson (2016b). 
This is currently more of a “links I have found” list, 
rather than links found to be helpful.

* Broman, K. (n.d.) _[R package primer](http://kbroman.org/pkg_primer/)._ Retrieved from http://kbroman.org/pkg_primer/
* Chan, F. C. (2015, July 26). [Making Your First R Package](http://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html). _Fong Chun Chan's Blog._ Retrieved from http://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html
* Kleinschmidt, D. F. (2016, May 18). [Taking your data to go with R packages](http://www.davekleinschmidt.com/r-packages/). Retrieved from http://www.davekleinschmidt.com/r-packages/
* Leisch, F. (2009, September 14). [Creating R Packages: A Tutorial](http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf). Retrieved from http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf
* Parker, H. (2014, April 29). [Writing an R package from scratch](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/). _Not So Standard Deviations._ Retrieved from https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
* Paulson, J. (2016a, April 21). [Package Development Prerequisites](https://support.rstudio.com/hc/en-us/articles/200486498-Package-Development-Prerequisites). _RStudio Support._ Retrieved from https://support.rstudio.com/hc/en-us/articles/200486498-Package-Development-Prerequisites
* Paulson, J. (2016b, November 8). [Developing Packages with RStudio](https://support.rstudio.com/hc/en-us/articles/200486488-Developing-Packages-with-RStudio). _RStudio Support._ Retrieved from https://support.rstudio.com/hc/en-us/articles/200486488-Developing-Packages-with-RStudio
* Peng, R. D., Kross, S., & Anderson, B. (2016, November 8). _[Mastering Software Development in R]._ Retrieved from https://bookdown.org/rdpeng/RProgDA/ (particularly section 3.5 "Data Within a Package").
* R Core Team (2016, October 31). _[Writing R Extensions](https://cran.r-project.org/doc/manuals/R-exts.pdf)._ Retrieved from https://cran.r-project.org/doc/manuals/R-exts.pdf
* Ripley, R. M. (2012/13). [Making an R package](http://portal.stats.ox.ac.uk/userdata/ruth/APTS2012/Rcourse10.pdf).  Retrieved from http://portal.stats.ox.ac.uk/userdata/ruth/APTS2012/Rcourse10.pdf
* _[roxygen2](https://github.com/klutometis/roxygen/blob/master/README.md)._ (2015, October 6). Retrieved from https://github.com/klutometis/roxygen/blob/master/README.md
* Wickham, H. (2015). _[R Packages: Organize, Test, Document, and Share Your Code](http://r-pkgs.had.co.nz/)._ Retrieved from http://r-pkgs.had.co.nz/
