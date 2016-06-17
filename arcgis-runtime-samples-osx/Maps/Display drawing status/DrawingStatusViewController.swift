//
// Copyright 2016 Esri.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Cocoa
import ArcGIS

class DrawingStatusViewController: NSViewController {

    @IBOutlet private var mapView:AGSMapView!
    @IBOutlet private var activityIndicatorView:NSView!
    @IBOutlet private var progressIndicator:NSProgressIndicator!
    
    private var map:AGSMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //instantiate the map with topographic basemap
        self.map = AGSMap(basemap: AGSBasemap.topographicBasemap())
        
//        self.progressIndicator.startAnimation(self)
        
        //initial viewpoint
        self.map.initialViewpoint = AGSViewpoint(targetExtent: AGSEnvelope(XMin: -13639984, yMin: 4537387, xMax: -13606734, yMax: 4558866, spatialReference: AGSSpatialReference.webMercator()))
        
        //add a feature layer
        let featureTable = AGSServiceFeatureTable(URL: NSURL(string: "http://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0")!)
        let featureLayer = AGSFeatureLayer(featureTable: featureTable)
        self.map.operationalLayers.addObject(featureLayer)
        
        //assign the map to mapView
        self.mapView.map = self.map
        
        self.mapView.drawStatusChangedHandler = { [weak self] (drawStatus:AGSDrawStatus) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if drawStatus == AGSDrawStatus.InProgress {
                    self?.activityIndicatorView.hidden = false
                    self?.progressIndicator.startAnimation(self)
                }
                else {
                    self?.activityIndicatorView.hidden = true
                    self?.progressIndicator.stopAnimation(self)
                }
            })
        }
    }
    
}
