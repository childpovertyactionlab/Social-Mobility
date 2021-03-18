# NTX Social Mobility Hub
This is CPAL's workspace for all data and content related to the NTX Social Mobility Hub, created to support the UNT-Dallas Center for Socioeconomic Mobility Through Learning. You can access the code and data used to generate content for the sites *Explorer* feature, as well as accessing the full list of resources made available on the site. 

As of February 2020, this site is still a work in progress. Frequent changes are occurring, and any bookmarks to content in this repository may change at any time.

## Data Dictionary
The Data Dictionary is structured to provide directions for how to population different elements of the NTX Social Mobility Hub. If you wish to understand the different types of data available in the various folders within this repository, you should start here. 

* **variable -** The variable name used in the referenced data locations.
* **display_name -** A shortened, human readable name for the given variable.
* **display_variable -** A binary field, where a *1* indicates a variable that should be rendered on the Explorer application.
* **type -** A field used to denote the different formats the data may take. This helps segment data based on how it is used in the site.
  * point: Feature set data with latitude/longitude coordinates to plot on map tool.
  * estimate: Raw data variable without any transformations applied. 
  * sd: Assignment column of 0-4 to indicate how many standard deviations away from the mean a datapoint in a geography is.
  * percent: A variable that has been transformed into a percent.
  * point_category: A category grouping for point data, indicating what topic area a feature belongs to.
  * point_subcategory: Subcategories for grouping point features nested within point_category type.
  * percentchange: Type containing the percent change from 2019 to 2014 for variable.
* **category -** A field used to help classify point features represented on the Explorer.
* **subcategory -** A field used to help classify features withing specific categories on the Explorer.
* **category order -** A field to note the order in which feature categories should be ordered on the Explorer.
* **subcategory order-** A field to not the order in which feature subcategories should be ordered on the Explorer.
* **description -** A short description of specific variables or features.
* **indicator_order -** Used to manage the order that indicators appear in the side bar of the Explorer application.
* **tooltip -** A binary field used to denote if a variable should be included in the tooltip on the Explorer's map component.
* **tooltip_order -** Used to manage the order that indicators appear in the tooltip hover of the Explorer application.
* **currency -** A binary field used to identify variables that need to be formatted as currency.
* **decimals -** A field used to identify the number of significant digits to be generated for the specified variable.
* **percent -** A binary field used to identify variables that need to be formatted as percentages.
* **source -** This field identifies the source for the variable in question.
* **years -** This field identifies the year that the data is relevant to.
* **place -** A field that tracts the geographic scales that the data is available for. This field controls the places where indicators will render in the sidebar of the Explorer. 
* **highisgood -** A binary field to signify variables where a higher value is good (**1**) or where lower values are good (**0**). 
* **min -** For quantitative variables, this field shows the lowest value in the dataset.
* **max -** For quantitative variables, this field shows the maximum value in the dataset.
* **range -** For quantitative variables, this field shows the range of the data (max - min). 
* **mean -** For quantitataive variables, this field shows the mean value of the data. 
* **median -** For quantitative variables, this field shows the median value of the data.
* **stdev -** For quantitative variables, this field shows the standard deviation of the data.

## Files
* **Data -** Folder housing all Explorer application data. 
*** **Reference Geographies -** Folder containing files with the GEOIDs and shapefiles of selected geographies included in the NTX Social Mobility Hub. 
*** **ACS -** Export folder of raw American Communities Survey (ACS) data pulled from TidyCensus in R. 
*** **Intermediate -** Export folder for intermediate steps within scripting process.
*** **geojson -** Folder containing finalized versions of geographies and data for the NTX Social Mobility Hub Explorer.
* **Scripts -** Folder containing all scripts related to processing data and preparing it for Explorer application.
*** **Step01_ACSPull.Rmd -** Script which connects to and pulls data from the US Census Bureau API for various geographies of interest. 
*** **Step02_DatatogeoJSON.Rmd -** Imports all files from the "Step01" script and merges with appropriate shapefiles then exports to a geoJSON format.
*** **Step03_FeaturestogeoJSON.Rmd -** Import point feature data from various location in the CPAL Dropbox then transforms as necessary to include necessary variable information. Script is also necessary to perform geography selections on data, selecting only points that are within geographies of interest.
*** **Step04_DataCalculation.Rmd -** Script which imports all ACS data along with data from other sources and transforms data into necessary formats before exporting into geoJSON once more.
* **DataDictionary.csv -** File containing definitions of data included in the Explorer application. This file is tied into the explorer website and controls how various data is displayed.
* **SocialMobility_Literature_Links.csv -** File containing links to research relevant to the NTX Social Mobility Hub
* **README.md -**

## License
## Other Info
