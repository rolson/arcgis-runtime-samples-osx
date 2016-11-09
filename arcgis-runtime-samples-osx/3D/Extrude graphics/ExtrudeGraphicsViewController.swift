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

class ExtrudeGraphicsViewController: NSViewController {

    @IBOutlet var sceneView:AGSSceneView!
    
    private var graphicsOverlay: AGSGraphicsOverlay!
    
    private let squareSize:Double = 0.01
    private let spacing:Double = 0.01
    private let maxHeight = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize scene with topographic basemap
        let scene = AGSScene(basemap: AGSBasemap.topographicBasemap())
        //assign scene to the scene view
        self.sceneView.scene = scene
        
        //set the viewpoint camera
        let camera = AGSCamera(latitude: 28.4, longitude: 83, altitude: 20000, heading: 10, pitch: 70, roll: 300)
        self.sceneView.setViewpointCamera(camera)
        
        //add graphics overlay
        self.graphicsOverlay = AGSGraphicsOverlay()
        self.graphicsOverlay.sceneProperties?.surfacePlacement = .Draped
        self.sceneView.graphicsOverlays.addObject(self.graphicsOverlay)
        
        //simple renderer with extrusion property
        let renderer = AGSSimpleRenderer()
        let lineSymbol = AGSSimpleLineSymbol(style: .Solid, color: NSColor.whiteColor(), width: 1)
        renderer.symbol = AGSSimpleFillSymbol(style: .Solid, color: NSColor.primaryBlue(), outline: lineSymbol)
        renderer.sceneProperties?.extrusionMode = .BaseHeight
        renderer.sceneProperties?.extrusionExpression = "[height]"
        self.graphicsOverlay.renderer = renderer
        
        // add base surface for elevation data
        let surface = AGSSurface()
        let elevationSource = AGSArcGISTiledElevationSource(URL: NSURL(string: "https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/Terrain3D/ImageServer")!)
        surface.elevationSources.append(elevationSource)
        scene.baseSurface = surface
        
        //add the graphics
        self.addGraphics()
    }
    
    
    private func addGraphics() {
        //starting point
        let x = self.sceneView.currentViewpointCamera().location.x - 0.03
        let y = self.sceneView.currentViewpointCamera().location.y + 0.2
        
        //creating a grid of polygon graphics
        for i in 0...6 {
            for j in 0...4 {
                let polygon = self.polygonForStartingPoint(AGSPoint(x: x + Double(i) * (squareSize + spacing), y: y + Double(j) * (squareSize + spacing), spatialReference: nil))
                self.addGraphicForPolygon(polygon)
            }
        }
    }
    
    //the function returns a polygon starting at the given point
    //with size equal to squareSize
    private func polygonForStartingPoint(point:AGSPoint) -> AGSPolygon {
        let polygon = AGSPolygonBuilder(spatialReference: AGSSpatialReference.WGS84())
        polygon.addPointWithX(point.x, y: point.y)
        polygon.addPointWithX(point.x, y: point.y+squareSize)
        polygon.addPointWithX(point.x+squareSize, y: point.y+squareSize)
        polygon.addPointWithX(point.x+squareSize, y: point.y)
        return polygon.toGeometry()
    }
    
    //add a graphic to the graphics overlay for the given polygon
    private func addGraphicForPolygon(polygon:AGSPolygon) {
        
        let rand = Int(arc4random()) % self.maxHeight
        let graphic = AGSGraphic(geometry: polygon, symbol: nil, attributes: nil)
        graphic.attributes.setValue(rand, forKey: "height")
        self.graphicsOverlay.graphics.addObject(graphic)
    }
    
    
}
