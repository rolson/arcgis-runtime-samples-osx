//
//  MapLoadedViewController.swift
//  arcgis-runtime-samples-osx
//
//  Created by Gagandeep Singh on 7/13/16.
//  Copyright © 2016 Esri. All rights reserved.
//

import Cocoa
import ArcGIS

class MapLoadedViewController: NSViewController {

    @IBOutlet var mapView:AGSMapView!
    @IBOutlet var bannerLabel:NSTextField!
    
    private var map:AGSMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize map with basemap
        self.map = AGSMap(basemap: AGSBasemap.imageryWithLabelsBasemap())
        
        //assign map to map view
        self.mapView.map = self.map
        
        //register as an observer for loadStatus property on map
        self.map.addObserver(self, forKeyPath: "loadStatus", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        //update the banner label on main thread
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            
            if let weakSelf = self {
                //get the string for load status
                let loadStatusString = weakSelf.loadStatusString(weakSelf.map.loadStatus)
                
                //set it on the banner label
                weakSelf.bannerLabel.stringValue = "Load status : \(loadStatusString)"
            }
        }
    }
    
    private func loadStatusString(status: AGSLoadStatus) -> String {
        switch status {
        case .FailedToLoad:
            return "Failed_To_Load"
        case .Loaded:
            return "Loaded"
        case .Loading:
            return "Loading"
        case .NotLoaded:
            return "Not_Loaded"
        default:
            return "Unknown"
        }
    }
}
