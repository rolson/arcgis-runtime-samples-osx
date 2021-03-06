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

import Cocoa
import ArcGIS

class SimpleMarkerSymbolViewController: NSViewController {
    
    @IBOutlet var mapView:AGSMapView!
    
    private var graphicsOverlay = AGSGraphicsOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize map with basemap
        let map = AGSMap(basemap: AGSBasemap.imageryWithLabelsBasemap())
        
        //initial viewpoint
        let center = AGSPoint(x: -226773, y: 6550477, spatialReference: AGSSpatialReference.webMercator())
        map.initialViewpoint = AGSViewpoint(center: center, scale: 6500)
        
        //assign map to the map view
        self.mapView.map = map
        
        //add graphics overlay to the map view
        self.mapView.graphicsOverlays.addObject(graphicsOverlay)
        
        //add a graphic with simple marker symbol
        self.addSimpleMarkerSymbol()
    }
    
    private func addSimpleMarkerSymbol() {
        //create a simple marker symbol
        let symbol = AGSSimpleMarkerSymbol(style: .Circle, color: NSColor.redColor(), size: 12)
        
        //create point
        let point = AGSPoint(x: -226773, y: 6550477, spatialReference: AGSSpatialReference.webMercator())
        
        //graphic for point using simple marker symbol
        let graphic = AGSGraphic(geometry: point, symbol: symbol)
        
        //add the graphic to the graphics overlay
        self.graphicsOverlay.graphics.addObject(graphic)
    }
    
    
}
