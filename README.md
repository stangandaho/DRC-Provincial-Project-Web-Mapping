![App view](https://raw.githubusercontent.com/stangandaho/DRC-Provincial-Project-Web-Mapping/main/appview.jpg?raw=true)

# DRC Projects Map Visualization

This repository contains a Shiny application built with R for visualizing projects in the Democratic Republic of Congo (DRC). 
The application provides an interactive map displaying information about various 
projects funded and executed in the region. Users can explore project details 
such as the title, funding amount, executing organization, contact information, 
and project timelines.

## Features

- **Interactive Map:** An interactive map powered by the Leaflet library, with multiple basemaps to choose from.
- **Province Boundaries:** The map includes the provincial boundaries of the DRC for contextual geographic reference.
- **Project Markers:** Custom markers display project locations on the map, with popups showing detailed project information.
- **Layer Control:** Users can switch between different map baselayers such as OpenStreetMap, Esri World Imagery, and more.

## Dataset Requirements

### 1. Province Boundaries
The application uses a GeoJSON file containing the boundaries of [DRC provinces](https://data.humdata.org/dataset/openstreetmap-dr-congo-provinces-boundaries-admin-level-2):

### 2. Project Information
The application uses a GeoJSON file for project data, including the following attributes:

- `Secteur d’intervention`: Sector of intervention.
- `Intitulé.du.projet`: Title of the project.
- `Début`: Project start date.
- `Fin`: Project end date.
- `Montant`: Funding amount for the project.
- `Structure.d.exécution.Contact`: Contact information for the executing organization.
- `Bailleur`: Project funder.

## Application Details

### UI
The user interface consists of a full-screen Leaflet map:

- **Map View:** The map output is set to fill the screen for an immersive user experience.
- **Basemap Selector:** A control panel allows users to switch between available basemap options.

### Server Logic

- **Basemap Configuration:** The server initializes the map with default settings (centered at latitude -2.867277, longitude 23.64774, with a zoom level of 6).
- **Polygon Layer:** Provincial boundaries are added with semi-transparent styling.
- **Marker Layer:** Project locations are marked with custom icons and detailed popups.
- **Popup Content:** Popups display project information dynamically from the dataset, with formatted HTML content.

### Marker Customization
Custom markers use an icon defined in `inst/media/pin.png`, sized at 10x10 pixels for consistent visualization.

## Installation and Usage

### Prerequisites

Ensure you have the following installed on your system:

1. R (version 4.0 or later)
2. RStudio (optional, but recommended)
3. Required R packages:
   - `leaflet`
   - `shiny`
   - `sf`
   - `dplyr`

### Steps to Run the Application

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Install required R packages:
   ```R
   install.packages(c("leaflet", "shiny", "sf", "dplyr"))
   ```

3. Run the application:
   ```R
   shiny::runApp()
   ```

4. Access the application in your browser at the URL provided in the R console.

## File Structure

```
.
├── inst
│   ├── datasets
│   │   ├── rd_congo_admin_4_provinces.geojson
│   │   └── points_and_project.geojson
│   ├── media
│   │   └── pin.png
├── app.R
└── README.md
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For questions or contributions, please contact:

- Name: Stanislas Mahuss Gandaho
- Email: stangandaho@gmail.com
- GitHub: https://github.com/stangandaho/

