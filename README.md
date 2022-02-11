# **Winter Affectations Post-2020** on the **Scottish Health Sector**
WAP SHS App
---

* Further details and results can be found within `analysis_and_documentation/report/project_WAP_SHS_APP_report.Rmd`.


This project's objective was to create an R shiny dashboard for Public Health Scotland in one week, by Team KLAS
### Members of Team KLAS

* Aboubakar Hameed
* Kang Hin Lee
* Lucy Burns
* Seàn M. Cusick

## Team learning goals  
In the Kick-Off meeting, each member discussed their personal goals in regards to the knowledge they wished to consolidate and any new skill they wanted to learn:  

* **Aboubakar Hameed** -  
  *My plan in this project was to get more experience in the shiny app, by exploring the relationship between the ui and the server as well as to get more knowledge and experience on how to create more tabs and improve the overall design of the app.*  

* **Kang Hin Lee** -  
  *"It is a very exciting opportunity to practise everything I have learned from CodeClan so far, using the live data from PHS. The aim for myself is to hone my data cleaning and wrangling skills and improve my analysis skills through working with my peers."*  

* **Lucy Burns** -  
  *"I really wanted to explore the mapping systems within Leaflet and RStudio. I wanted to reinforce all of my learnings over the past seven weeks and improve my coding and visualising skills. I don’t think I have achieved these and have found this week frustrating - mostly at my own inexperience and problematic datasets. It has however not all been negative with a sharp learning curve for me, and I think, my team."*  

* **Seàn M. Cusick** -  
  *planned to solidify his experience in Project Management by incorporating his knowledge in leading Event and Technical Projects, into leading a Software based project. Additionally, to improve his working experience with spatial visualisations. *


***  

## Roles & Responsibilities
* **Aboubakar Hameed** -  
  responsible for the Minimum Viable Product (MVP) - summarised within Work Package (WP) `WP2.3 - Shiny App MVP`; furthermore, supported `WP2.1.3 - Data Wrangling`, and `WP2.3.2 - Backend Code`.  

* **Kang Hin Lee** -  
  responsible for the Data Sets - summarised in `WP2.1 - Data Analysis`; furthermore, supported `WP2.1.3 - Data Wrangling`, and `WP2.3.2 - Backend Code`.

* **Lucy Burns** -  
  responsible for the visualisations - summarised within WP `WP2.2 - Data Visualisation`; furthermore, supported `WP2.1.3 - Data Wrangling`, `WP3.1.2 - README File`, and `WP3.2 - Presentation` .

* **Seàn M. Cusick** -  
  responsible for Project Management and Documentation - summarised within WP `WP1 - Project Management` & `WP3 - Documentation`; furthermore, supported `WP3.1.2 - README File`, and `WP3.2 - Presentation`.

## Team Responsibilities
* **All team members** worked on the following **Work Packages** (WP):  
  * `WP1.1 - Project Set-up`  
  * `WP2 - Shiny App`  
  * `WP2.1.1 - DataSet Selection `
  * `WP2.1.2 - Data Cleaning`  
  * `WP2.1.3 - Data Wrangling`  
  * `WP2.2.1 - Temporal Visualisations`  
  * `WP2.2.2 - Spatial Visualisations`  
  * `WP2.2.3 - Demographic Visualisations`   
  * `WP2.2.4 - Features`  
  * `WP2.3.1 - User Interface`
  * `WP3.1 - Report`  
  * `WP3.1.1 - Analysis`


***  
# Dashboard Details

## Objective
The objective for our Minimum Viable Product (MVP) was to demonstrate the following topic:
What, if any, __effect does the  Winter Season__ have on the acute Health Sector in Scotland, specifically __within Accident and Emergency (A&E)__; additionally, how does the __COVID-19 pandemic__ influence this further.

The dashboard outlines our topic in terms of:  
* The geographic spread of the Scottish Health Service  
* COVID-19's spread through Scotland  
* The activity within A&E departments in Scotland.  


## Initial Concept
In order to realise this objective, a preliminary wire-frame of the Minimal Viable Product (MVP) was designed during the Initial Design Review (IDR) in `WP1.1 - Project Set-up`. This wire-frame can be found in the appendix.  

## Revised Concept
During the Detailed Design Review (DDR), the design was further streamlined, with superfluous features moved to the `WP2.2.4 - Features` work package. The updated wire-frames can be found in the tabs below:
### Brief description of dashboard topic

Our dashboard contains three sections:
1. checkboxes of each health board
2. drop down menu for individual hospitals in that health board
3. Tabs
  1). Map of Scotland
  2). Time series graphs
  3). proportional graphs
  

### Stages of the project

* Role Allocation  
* Project Management  
  * Work Breakdown Structure  
  * Project Gantt  
  * Git branching  
  * Version control  
* Application Development  
  * Choosing datasets  
  * Dashboard wireframe  
***

#### Milestones

Milestones are key points in the project that are outputs from certain Work Packages. They are used to measure if the Project is progressing at the planned pace successfully.  
Milestones:  
* Project Set-up  
* Data Analysis  
* Data Visualisation  
* Shiny App MVP  
* Documentation  
* Presentation  

Design Reviews are meetings that are used to ensure that the project's objective is still feasible, and allows the team to make adjustments from any new information or challenges that have arisen from project activities.  

Design Reviews:  
* Initial Design Review - **IDR**  
* Detailed Design Review - **DDR**  
* Prototype Design Review - **PDR**  
* Final Design Review - **FDR**  

***

## MVP Details

As a team we sketched out an MVP for the project. We identified three questions to look at - dealing with COVID, Winter and Deprivation.

Using these and our knowledge of RShiny, we sketched the areas in Jamboard to allow us to start building the wire frame.

The Minimum Value Product (MVP) of the dashboard, found in work package `WP 2.3 - Shiny App MVP`, can be separated into a sidebar, with each tab displaying relevant information.
Details on the page contents can be found in the tabs below:

### Landing Page
The main page MVP was to contain a map showing the hospital locations, and some simple graphs showing some of the trends within the data as well as a short description.

We mostly met the MVP and decided to change the graphs to a dashboard showing key Covid statistics. We also did not include a Health Board selection box to change the map.

***  

### Page 1
The MVP for the Covid table was a couple of fixed graphs giving us an overview of the impact of Covid on hospitalisation. As an extension we planned to look at some more specific stats - looking at using dropdown for age/gender/health board but we only managed to complete the MVP in the timescale.

***  

### Page 2
A&E Activity - later renamed Winter.
The Winter page was looking at the impact of winter on hospital rates. We wanted to see if the media claims were correct that winter has a negative affect on the Scottish health system. We added links to some media stories to illustrate this. We met MVP on this tab.

***  

### Page 3
The third page which was re-prioritised after the Detailed Design Review (DDR) from the `WP 2.3 - Shiny App MVP` to `WP2.2.4 - Features`.
We had planned to run a series of analysis on deprivation statistics but, in looking deeper into the data, we struggled to get anything meaningful from the datasets so dropped this.

***  

### Additional Features
The winter analysis suggested to us that the winter was not in fact the busiest quarter and in order to look into this we added in some additional hypothesis analysis comparing the means of quarterly admissions as well as comparing data from Covid times and pre-pandemic. This was added into an additional area.

## Quality & Biases

### Data Quality

Data cleaning functions were created for this set, which are described in the Data Cleaning section.  

As for the quality of the data set: according to the [About tab](https://www.opendata.nhs.scot/about) on PHS dedicated page, the data quality of all Public Health Scotland's data sets follow the [open data standards](https://www.opendata.nhs.scot/uploads/admin/PHS-Open-Data-Standards-Version-1.0.pdf), ensuring consistency across all data sets.

The use of open data standards means that there was little cleaning involved.

***

### Challenges  
The deprivation data was confusing to use. Initially we thought that it would give us a good indicator of who was being admitted into hospital. What it seemed to reveal, however, was a ranking for all patients who were entering/being admitted to hospital so it was not possible to compare or track the rates by SIMD (Scottish Index of Multiple Deprivation) as roughly 20% of the people in the hospitals were allocated to each of the quintiles. Deeper analysis of the SIMD could possibly provide some interesting analysis but in the short time scale we had we decided to drop the data set.  

The bed capacity dataset was incomplete. It looked like it would be a good statistic to use to look at how full the hospitals are. On further investigation, however, we noticed that the data was only for a couple of hospitals across two of the thirteen Health Boards in Scotland.

***

### Potential Biases
The dataset may be biased because the data does not include variables that properly capture the phenomenon we want to predict.

***

## Data Manipulation
The data cleaning & wrangling process are focused on the balance between time & computational efficiency. It aimed to perform a generic clean operation to remove redundant metadata and wrangle towards a standardised data frame layout
throughout the datasets.

### Data Cleaning
The data cleaning process is built based on computational and time efficiency and aimed to perform a generic clean to all datasets with a standard consistency across most of them.

The datasets are first extracted from the PHS website using API keys then converted `.csv` files and stored at local repository level.
The API data is then loaded into the cleaning script to performed generic cleaning process such as format the dataset into data frames and any redundant columns that has zero value to our MVP goals.

Additional cleaning for each dataset require on individual dataset d was rarely required as the data sets use [open data standards](https://www.opendata.nhs.scot/uploads/admin/PHS-Open-Data-Standards-Version-1.0.pdf).

***

### Data Wrangling

The wrangling process is focused on standardising any category and foreign key columns. For example establish a "year" and "quarter" column for each dataset, and reordering any age_group columns.
The output data frames should have multiple foreign key columns ready to be processed in the analysis stage.

***

## Storage and Structure
The following tabs explores details of the storage and structure of the data sets used in the project:  

### Storage
The data on hospital activity and COVID cases were stored in the form of `.csv` files, also known as comma-separated values files. The value of using `.csv` is that they can be easily read by RStudio, and transformed into data frames which can be manipulated.


In order to plot the maps, spatial data was taken from the PHS site and stored as the following file types:

File type    | Use   
:------ | :-------------
.cpg    | code page used to specify the code page (only for .dbf)   
.dbf    | shapefile attribute format; columnar attributes for each shape,  
.prj    | projection description
.sbn    | shapefile spatial index format
.shp    | shape format; feature geometry itself
.shp.xml| geospatial metadata in XML format  
.shx    | shape index format; positional index of the feature geometry   

***

### Structure
The following tabs contain an explanation for the file naming methods utilised by the team to differentiate and synthesise between each data set:  

#### Parameters naming methodology
Parameter      | Definition
:------------- | :-------------
api       | Application Programming Interface values
backup    | Backup Data frame (Stored loaded API data frames as backup)
df        | Data frame
sample    |  sample / test data frame
agegroup  | Data frame with categorized age group (filtered out "all age" & "gender/sex" parameters)

***

#### Acronyms
Parameter      | Definition
:------------- | :-------------
ane       | A&E (Group 03)  
cov       | COVID (Group 02)  
ans       | Age and Sex
dep       |  sample / test data frame
spe       | Speciality
ha        | Hospital Activity  
hb        | Health Board  
hscp      | Health and Social Care Partnership

***

### Justification

Benefits of storing the data like this are that it becomes easy to make a distinction between data sets at a glance, i.e. *to distinguish which data set is on A&E activity, and which is on COVID*.  

Conversely, it also helps to quickly group data sets that share a common link, i.e. *both sets group by speciality, or by age and sex*.  

***

## Data Ethics

There are no ethical considerations, because the datasets are devoid of any personal data and assessed for confidentiality, including third party information. Although the data sets are dealing with the health of individuals, no person can be discerned for the information provided.

A draw back to the lack of personalised data is that the findings from the analysis would be not as accurate, but the author notes that it would not justify breaching the privacy of individuals.

## Legality
The datasets used in this project are covered by the [Open Government License](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/), which means that as long as the source is acknowledged, any one has worldwide, royalty-free, perpetual, non-exclusive licence to utilise the data, including:  

* copy, publish, distribute and transmit the Information;  
* adapt the Information;  
* exploit the Information commercially and non-commercially for example, by combining it with other Information, or by including it in your own product or application.  
