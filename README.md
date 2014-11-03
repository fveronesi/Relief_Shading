Relief_Shading
==============

ArcGIS toolbox to automatically create relief shading implementing with two light sources.

<strong>Instructions</strong>:
It was successfully tested on ArcGIS 10.1 SP1.
To install the tool, first save the right version on your PC, then open ArcGIS and the ArcToolbox. Here click on the title at the top, “ArcToolbox”, with the right mouse button and select “Add Toolbox”. A selection window will appear where you can navigate where you saved the sine wave toolbox. Click once on the file and then on “Open”, do not double-click on the file.
Each tool creates several temporary intermediate files that are needed to perform the shading but are deleted when the process is terminated. These files are saved locally in a temporary folder. Before using the tool the user needs to be sure to have a folder named temp (C:\temp) in his local hard drive. If there is not, it should be created.

This software is a complement to the following article.

<strong>Title</strong>:
"A GIS tool to increase the visual quality of relief shading by automatically changing the light
direction"

<strong>Authors</strong>:
Dr. Fabio Veronesi, Prof. Dr. Lorenz Hurni

<strong>Affiliation</strong>:
Institute of Cartography and Geoinformation, ETH Zurich
Stefano-Franscini-Platz 5, CH-8093 Zurich

<strong>E-Mail</strong>: fveronesi@ethz.ch

<strong>Abstract</strong>:
Shaded relief representations were traditionally produced manually by specifically trained cartographers. This was however a labour-intensive and time-consuming task, which gave rise to numerous attempts of automation.
Nowadays, many GIS applications implement hillshading using an oblique light source. This has standardised the method, providing a simple way to obtain reliable and consistent results. Its visual quality is however well below the standards of manual shading, where multiple light sources are employed to achieve a superior visual quality.
In this work we present a GIS tool to enhance the visual quality of hillshading. We developed a technique to illuminate the landscape from two different angles and correct the tone according to either elevation or slope. With this method the quality of the shaded relief is superior to the standard method, but itits level of automation and standardisation guarantees consistent and reproducible results. This method has been embedded into an ArcGIS toolbox.
