formulr
=======

This is a helper package used in rollply to handle formulas of the form a ~ b + c | d.

It converts this kind of formulas into a formulr object (actually a list) with three components, x,y and g (for *groups*) :

``` r
library(formulr)
form <- as.formulr(a ~ b + c | d)
str(form)
```

    ## List of 3
    ##  $ y:List of 1
    ##   ..$ a: symbol a
    ##   ..- attr(*, "env")=<environment: 0x3fa79d0> 
    ##   ..- attr(*, "class")= chr "quoted"
    ##  $ x:List of 2
    ##   ..$ b: symbol b
    ##   ..$ c: symbol c
    ##   ..- attr(*, "env")=<environment: 0x3fa79d0> 
    ##   ..- attr(*, "class")= chr "quoted"
    ##  $ g:List of 1
    ##   ..$ d: symbol d
    ##   ..- attr(*, "env")=<environment: 0x3fa79d0> 
    ##   ..- attr(*, "class")= chr "quoted"
    ##  - attr(*, "class")= chr "formulr"

This object can then be eval'ed given some data and optionally an enclosing environment:

``` r
.dat <- data.frame(a=rnorm(10), 
                   b=runif(10), 
                   c=rpois(10,10), 
                   d=rbeta(10, 1, .5))
result <- eval.formulr(as.formulr(a ~ b + c | d), envir=.dat)
str(result)
```

    ## List of 3
    ##  $ y:List of 1
    ##   ..$ a: num [1:10] -1.4616 -2.0211 -2.2356 0.0159 -0.3274 ...
    ##  $ x:List of 2
    ##   ..$ b: num [1:10] 0.69 0.648 0.726 0.626 0.181 ...
    ##   ..$ c: int [1:10] 12 22 9 13 9 11 11 12 11 12
    ##  $ g:List of 1
    ##   ..$ d: num [1:10] 0.874 0.554 0.966 0.768 0.974 ...
    ##  - attr(*, "class")= chr [1:2] "formulr" "eval.formulr"

This object can be then converted back to useful data structures:

``` r
df <- as.data.frame(result)
str(df)
```

    ## List of 3
    ##  $ y:'data.frame':   10 obs. of  1 variable:
    ##   ..$ a: num [1:10] -1.4616 -2.0211 -2.2356 0.0159 -0.3274 ...
    ##  $ x:'data.frame':   10 obs. of  2 variables:
    ##   ..$ b: num [1:10] 0.69 0.648 0.726 0.626 0.181 ...
    ##   ..$ c: int [1:10] 12 22 9 13 9 11 11 12 11 12
    ##  $ g:'data.frame':   10 obs. of  1 variable:
    ##   ..$ d: num [1:10] 0.874 0.554 0.966 0.768 0.974 ...

``` r
df <- as.data.frame(result, collapse=TRUE)
round(df,digits=2)
```

    ##        a    b  c    d
    ## 1  -1.46 0.69 12 0.87
    ## 2  -2.02 0.65 22 0.55
    ## 3  -2.24 0.73  9 0.97
    ## 4   0.02 0.63 13 0.77
    ## 5  -0.33 0.18  9 0.97
    ## 6  -0.22 0.20 11 0.94
    ## 7   1.97 0.26 11 0.26
    ## 8   0.07 0.28 12 0.94
    ## 9   0.06 0.90 11 0.99
    ## 10  0.26 0.65 12 0.90

Warning
-------

formulr is still under heavy development and is mainly an externalisation of some tools needed by rollply rather than a full-blown package. It might turn into something more official one day though.

Use at your own risk.
