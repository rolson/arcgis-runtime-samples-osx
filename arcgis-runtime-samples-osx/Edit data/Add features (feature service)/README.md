#Add features (feature service)

This sample demonstrates how to add features to the feature layer using a feature service.

##How to use the sample

Click on a location in the map view to add a feature at that location

![](image1.png)

##How it works

The sample uses the `mapView:didTapAtPoint:mapPoint:` method on `AGSMapViewTouchDelegate` to get the tapped point. Creates a new feature using `createFeatureWithAttributes:geometry:` method on `AGSServiceFeatureTable`. Adds the new feature to the feature table using `addFeature:completion:` method and applies the edit to the service using the `applyEditsWithCompletion:` method.




