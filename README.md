Last updated 2025-01-02

# MDCSpatialData

MDCSpatialdData provides spatial data sets in tabular or other
R-compatible forms (sf, terra) for easy access by MDC staff or others.
All data objects are projected in NAD83 UTM15N unless otherwise noted.
Measurement attriubutes in spatial objects (e.g., sf, terra) may not be
based on the projected coordinate system. All tabular data calculations
have been performed on spatial data using NAD83 UTM15N.

## Installation

You can install the MDChelp from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tlyons253/MDCSpatialData")
#> Using GitHub PAT from the git credential store.
#> Downloading GitHub repo tlyons253/MDCSpatialData@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>          checking for file 'C:\Users\Lyonst\AppData\Local\Temp\Rtmpg33WRC\remotes1243c072242\tlyons253-MDCSpatialData-a124850/DESCRIPTION' ...  ✔  checking for file 'C:\Users\Lyonst\AppData\Local\Temp\Rtmpg33WRC\remotes1243c072242\tlyons253-MDCSpatialData-a124850/DESCRIPTION' (526ms)
#>       ─  preparing 'MDCSpatialData':
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts (388ms)
#>   ─  checking for empty or unneeded directories
#>       ─  building 'MDCSpatialData_0.0.0.9000.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/Lyonst/AppData/Local/Temp/RtmpCe0GPs/temp_libpath577468c33088'
#> (as 'lib' is unspecified)
```

## Examples

On advantage to having these spatial data sets in a separate package is
they do not need to be read into memory to be processed; they don’t need
to take up RAM in their raw format.

For example, if you wanted to clip flowlines to Boone County you might
normally try:

``` r
MDCSpatialData::nhd.flowline.mo->flowlines

MDCSpatialData::counties.mo->counties

sf::st_intersection(flowlines,counties)->boone.flow
#> Warning: attribute variables are assumed to be spatially constant throughout
#> all geometries
```

``` r

rm(flowlines) # remove the raw flowlines file
```

But that reads in all flowlines in the state. A more memory friendly
version that doesn’t keep the raw flowlines file in the environment is:

``` r
sf::st_intersection(MDCSpatialData::nhd.flowline.mo,
                    MDCSpatialData::counties.mo)->boone.flow
#> Warning: attribute variables are assumed to be spatially constant throughout
#> all geometries
```
