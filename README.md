# NTX Social Mobility Hub
This is CPAL's workspace for all data and content related to the NTX Social Mobility Hub, created to support the UNT-Dallas Center for Socioeconomic Mobility Through Learning. You can access the code and data used to generate content for the sites *Explorer* feature, as well as accessing the full list of resources made available on the site. 

As of February 2020, this site is still a work in progress. Frequent changes are occurring, and any bookmarks to content in this repository may change at any time.

## Data Dictionary
The Data Dictionary is structured to provide directions for how to population different elements of the NTX Social Mobility Hub. If you wish to understand the different types of data available in the various folders within this repository, you should start here. 

* **variable -** The variable name used in the referenced data locations.
* **display_name -** A shortened, human readable name for the given variable.
* **display_variable -** A binary field, where a *YES* indicates a variable that shuold be rendered on the Explorer application.
* **type -** A field used to denote the different formats the data may take. This helps segment data based on how it is used in the site.
  * point
  * estimate
  * sd
  * percent
  * point_subcategory
  * point_category
  * percentchange
* **category -** A field used to help classify point features represented on the Explorer.
* **subcategory -** A field used to help classify features withing specific categories on the Explorer.
* **description -** A short description of specific variables or features.
* **indicator_order -** Used to manage the order that indicators appear in the side bar of the Explorer application.
* **tooltip -** A binary field used to denote if a variable should be included in the tooltip on the Explorer's map component.
* **currency -** A binary field used to identify variables that need to be formatted as currency.
* **decimals -** A field used to identify the number of significant digits to be generated for the specified variable.
* **percent -** A binary field used to identify variables that need to be formatted as percentages.
* **source -** This field identifies the source for the variable in question.
* **years -** This field identifies the year that the data is relevant to.
* **place -** A field that tracts the geographic scales that the data is available for. This field controls the places where indicators will render in the sidebar of the Explorer. 
* **highisgood -** A binary field to signify variables where a higher value is good (**Yes**) or where lower values are good (**No**). 
* **min -** For quantitative variables, this field shows the lowest value in the dataset.
* **max -** For quantitative variables, this field shows the maximum value in the dataset.
* **range -** For quantitative variables, this field shows the range of the data (max - min). 
* **mean -** For quantitataive variables, this field shows the mean value of the data. 
* **median -** For quantitative variables, this field shows the median value of the data.
* **stdev -** For quantitative variables, this field shows the standard deviation of the data.

## Files
## License
## Other Info
