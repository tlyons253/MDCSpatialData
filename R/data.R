#' NHD Point data cropped to the state of Missouri
#'
#' NHD data obtained throught the FedData package in R
#'
#' see the NHD data dictionary for for further detail:
#' https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains
#'
#'
#'
"nhd.point.mo"

#' NHD Flowline data cropped to the state of Missouri
#'
#' NHD data obtained throught the FedData package in R
#'
#' see the NHD data dictionary for for further detail:
#' https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains
#'
#'
#'
"nhd.flowline.mo"


#' NHD Area data cropped to the state of Missouri
#'
#' NHD data obtained throught the FedData package in R
#'
#' see the NHD data dictionary for for further detail:
#' https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains
#'
#'
#'
"nhd.area.mo"


#' NHD Line data cropped to the state of Missouri
#'
#' NHD data obtained throught the FedData package in R
#'
#' see the NHD data dictionary for for further detail:
#' https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains
#'
#'
#'
"nhd.line.mo"


#' NHD Waterbody data cropped to the state of Missouri
#'
#' NHD data obtained throught the FedData package in R
#'
#' see the NHD data dictionary for for further detail:
#' https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains
#'
#'
#'
"nhd.waterbody.mo"


#' NLCD land cover by area for each county in MO odd numbered years 2001-2023.
#'
#' A dataset derived of Annual NLCD data- files were obtained via the FedData
#' package (NLCD) and tigir package (county boundaries). NLCD data was reprojected
#' to NAD83 UTM 15 N before areal calculations.
#'
#' See vignettes for examples on how to batch process
#'
#'  Cropping performed with terra::crop and the terra:mask
#'
#' Area converted to square km based on a 30x30m cell size and summing all
#' all pixels with in a given class. No other processing occurred.
#'
#'
#' @examples
#' \dontrun{
#' #data processed as follows:
#'
#'
#'
#' # list projected NLCD files in a folder
#'list.nlcd<-list.files(path='./prj_NLCD/',
#'                      pattern='.tif$',
#'                      full.names=TRUE)
#'
#'
#'
#' MDCSpatialData::counties.mo->co
#'
#'
#'
#'co%>%split(.$NAME)%>%
#'  map(.,~terra::vect(.x))->tmp
#'
#'nlcd.fxn<-function(nlcd,
#'                   county,year){
#'  terra::rast(nlcd)->Z
#'
#'  mo.co.list[[county]]->Q
#'
#'  terra::crop(Z,Q)->P
#'  terra::mask(P,Q)%>%
#'    terra::freq()%>%
#'    rename(LC=value)%>%
#'    select(LC,count)%>%
#'    group_by(LC)%>%
#'    summarize(n.cells=sum(count))%>%
#'    ungroup()%>%
#'    mutate(pct.area=n.cells/sum(n.cells),
#'           area.sqkm=(n.cells*(30*30)/1E6),
#'           cty=county,
#'           yr=year)
#'}
#'
#'
#'
#'
#'crossing(list.nlcd,names(mo.co.list))%>%
#'  rename(path=1,
#'         county=2)%>%
#'  mutate(year=str_extract(path,pattern='20\\d{2}'))%>%
#'  pmap(~nlcd.fxn(..1,..2,..3))->nlcd.tab
#'
#'
#' bind_rows(nlcd.tab)%>%
#'   select(-n.cells,-pct.area)%>%
#'   mutate(LC=paste0(LC,'.sqkm'))%>%
#'   pivot_wider(names_from=LC,
#'               values_from=area.sqkm)->nlcd.area.tab
#'}
#'
#'
#' @format
#' \describe{
#'    \item{cty}{county name}
#'    \item{yr}{4 digit year}
#'    \item{crop.sqkm}{area in km^2 of crop}
#'    \item{develop.sqkm}{area in km^2 of developed}
#'    \item{forest.sqkm}{area in km^2 of forest}
#'    \item{grass.sqkm}{area in km^2 of grass}
#'    \item{water.sqkm}{area in km^2 of water}
#'    \item{wetland.sqkm}{area in km^2 of wetland}
#'    \item{other.sqkm}{area in km^2 of all other landcover types present}
#' }
#'
"nlcd.area.tab"



#' NLCD land cover by percent of county area for each county in MO
#' odd numbered years 2001-2023.
#'
#' A dataset derived of Annual NLCD data- files were obtained via the FedData
#' package (NLCD) and tigir package (county boundaries). NLCD data was
#' reprojected to NAD83 UTM 15 N before areal calculations.
#'
#'  Cropping performed with terra::crop
#'
#' Area converted to square km based on a 30x30m cell size and summing all
#' all pixels with in a given class. No other processing occurred.
#'
#'
#' @examples
#' \dontrun{
#' #' #data processed as follows:
#'
#'
#'
#' # list projected NLCD files in a folder
#'list.nlcd<-list.files(path='./prj_NLCD/',
#'                      pattern='.tif$',
#'                      full.names=TRUE)
#'
#'
#'
#' MDCSpatialData::counties.mo->co
#'
#'
#'
#'co%>%split(.$NAME)%>%
#'  map(.,~terra::vect(.x))->tmp
#'
#'nlcd.fxn<-function(nlcd,
#'                   county,year){
#'  terra::rast(nlcd)->Z
#'
#'  mo.co.list[[county]]->Q
#'
#'  terra::crop(Z,Q)->P
#'  terra::mask(P,Q)%>%
#'    terra::freq()%>%
#'    rename(LC=value)%>%
#'    select(LC,count)%>%
#'    group_by(LC)%>%
#'    summarize(n.cells=sum(count))%>%
#'    ungroup()%>%
#'    mutate(pct.area=n.cells/sum(n.cells),
#'           area.sqkm=(n.cells*(30*30)/1E6),
#'           cty=county,
#'           yr=year)
#'}
#'
#'
#'
#'
#'crossing(list.nlcd,names(mo.co.list))%>%
#'  rename(path=1,
#'         county=2)%>%
#'  mutate(year=str_extract(path,pattern='20\\d{2}'))%>%
#'  pmap(~nlcd.fxn(..1,..2,..3))->nlcd.tab
#'
#'  bind_rows(nlcd.tab)%>%
#'  select(-n.cells,-area.sqkm)%>%
#'    mutate(LC=paste0(LC,'.pct'))%>%
#'    pivot_wider(names_from=LC,
#'                values_from=pct.area)->nlcd.pct.tab
#'
#'                    }
#'
#' @format
#' \describe{
#'    \item{cty}{county name}
#'    \item{yr}{4 digit year}
#'    \item{crop.pct}{percent area of crop}
#'    \item{develop.pct}{percent area of developed}
#'    \item{forest.pct}{percent area of forest}
#'    \item{grass.pct}{percent area of grass}
#'    \item{water.pct}{percent area of water}
#'    \item{wetland.pct}{percent area of wetland}
#'    \item{other.pct}{percent area  of all other landcover types present}
#' }
#'
"nlcd.pct.tab"



#' Missouri state boundary
#'
#' A sf object containing a single polygon representing the border of Missouri.
#' The boundary was derived by dissolving the county boundaries from the tigris
#' county data layer. It is in NAD83 UTM 15N (meters) coordinate system.
#'
#'
#'
#' @examples
#' \dontrun{
#' tigris::counties(state='MO')%>%
#' sf::st_transform(., crs=26915)%>% # reproject to NAD83 UTM 15N
#'  select(STATEFP,
#'         COUNTYFP,GEOID,
#'         NAME,
#'         NAMELSAD,
#'         LSAD)->counties.mo
#'
#'  counties.mo%>%
#'  group_by(STATEFP)%>%
#'  summarize()->state.mo
#'}
#'
#'
"state.mo"


#' Missouri county boundaries
#'
#' A sf object containing  polygons representing the border of each county
#'  of Missouri. The boundary was derived by dissolving the county boundaries
#'  from the tigris, county data layer. It is in NAD83 UTM 15N (meters)
#'  coordinate system. Per the tigris package, it is 1:500k resolution (default)
#'
#'
#'
#' @examples
#' \dontrun{
#' tigris::counties(state='MO')%>%
#' sf::st_transform(., crs=26915)%>% # reproject to NAD83 UTM 15N
#'  select(STATEFP,
#'         COUNTYFP,GEOID,
#'         NAME,
#'         NAMELSAD,
#'         LSAD)->counties.mo
#' }
"counties.mo"

