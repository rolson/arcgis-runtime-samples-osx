#Create and save a map

This sample demonstrates how to create a map and save it to your portal

##How to use the sample

On opening the sample you get to choose the layers for your map. You can choose a basemap and optionally one or more operational layers. Tapping on the `Done` button will display a map with those layers added. You can tap on the `New` button to start over or the `Save` button to save the map to your portal. You will be required to login and provide a title, tags and description (optional) for the map.

![](image1.png)
![](image2.png)
![](image3.png)
![](image4.png)

##How it works

The sample uses a pre-populated list of layers and basemaps. When you tap on `Done`, the selected basemap is used to create an `AGSMap` object using `initWithBasemap:` initializer. The authentication is handled by `AGSAuthenticationManager`. And to save the map the sample uses `saveAs:portal:tags:folder:itemDescription:thumbnail:completion:` method on `AGSMap`.



