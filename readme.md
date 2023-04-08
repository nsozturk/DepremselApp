# DepremselApp

## Overview

Depremsel App is an iOS application that displays a list of recent earthquakes in a table view. Each earthquake is colored according to its magnitude, with stronger earthquakes appearing in reddish colors. The app also allows users to click on a cell to view more details about a particular earthquake.

## Installation

1. Clone or download the repository to your local machine.
2. Open the EarthquakeTracker.xcodeproj file in Xcode.
3. Select a simulator or a physical device to run the app on.
4. Click the "Run" button in Xcode to build and run the app.

## Screenshots

![Screenshot 1](Docs/earthquake-1.png) ![Screenshot 2](Docs/earthquake-2.png)

## Features

- View a list of recent earthquakes in a table view
- Sort the earthquakes by magnitude, date, or location
- Color-code the earthquakes by magnitude
- Click on a cell to view more details about a particular earthquake
- View earthquake fault lines on a map

## Todo

[ ] Add a notification when the "Fetch" button is pressed, if there are earthquakes with a spesific magnitude.

[ ] Display earthquake on a map which has turkey's all faults drawin.

## Credits

The earthquake data is sourced from the kandilli observatory and earthquake research institute (KOERI)

The app also uses the Kandilli Rasathanesi API (https://github.com/orhanayd/kandilli-rasathanesi-api) to retrieve earthquake data in Turkey. We would like to thank Orhan AYDIN (https://github.com/orhanayd) for creating and maintaining this API.

We would also like to thank Mehmet Ali Pekcan (https://github.com/mapelse) for creating and sharing the Fay Hatları project (https://github.com/mapelse/fayHatlari), which helped us to include all of the fault lines in Turkey in the app.

