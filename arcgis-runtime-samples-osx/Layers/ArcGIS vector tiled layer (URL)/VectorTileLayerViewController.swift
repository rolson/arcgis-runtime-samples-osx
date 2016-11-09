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

import AppKit
import ArcGIS

class VectorTileLayerViewController: NSViewController {

    @IBOutlet var mapView:AGSMapView!
    
    private var navigationURLString = "https://www.arcgis.com/home/item.html?id=dcbbba0edf094eaa81af19298b9c6247"
    private var streetsURLString = "https://www.arcgis.com/home/item.html?id=4e1133c28ac04cca97693cf336cd49ad"
    private var nightURLString = "https://www.arcgis.com/home/item.html?id=bf79e422e9454565ae0cbe9553cf6471"
    private var darkGrayURLString = "https://www.arcgis.com/home/item.html?id=850db44b9eb845d3bd42b19e8aa7a024"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a vector tiled layer
        let vectorTileLayer = AGSArcGISVectorTiledLayer(URL: NSURL(string: navigationURLString)!)
        //create a map and set the vector tiled layer as the basemap
        let map = AGSMap(basemap: AGSBasemap(baseLayer: vectorTileLayer))
        
        //assign the map to the map view
        self.mapView.map = map

        //center on Miami, Fl
        self.mapView.setViewpointCenter(AGSPoint(x: -80.18, y: 25.778135, spatialReference: AGSSpatialReference.WGS84()), scale: 150000, completion: nil)

    }
    
    @IBAction func segmentedControlChanged(sender:NSSegmentedControl) {
        var urlString:String
        switch sender.selectedSegment {
        case 0:
            urlString = navigationURLString
        case 1:
            urlString = streetsURLString
        case 2:
            urlString = nightURLString
        default:
            urlString = darkGrayURLString
        }
        
        //create the new vector tiled layer using the url
        let vectorTileLayer = AGSArcGISVectorTiledLayer(URL: NSURL(string: urlString)!)
        //change the basemap to the new layer
        self.mapView.map?.basemap = AGSBasemap(baseLayer: vectorTileLayer)
    }
}
