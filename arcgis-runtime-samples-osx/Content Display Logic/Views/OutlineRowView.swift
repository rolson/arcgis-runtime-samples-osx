//
//  OutlineRowView.swift
//  arcgis-runtime-samples-osx
//
//  Created by Gagandeep Singh on 9/19/16.
//  Copyright © 2016 Esri. All rights reserved.
//

import Cocoa

class OutlineRowView: NSTableRowView {
    
    override func drawSelectionInRect(dirtyRect: NSRect) {
        super.drawSelectionInRect(dirtyRect)
        if self.emphasized {
            NSColor(calibratedWhite: 68/255.0, alpha: 1).set()
        }
        else {
            NSColor(calibratedWhite: 190/255.0, alpha: 1).set()
        }
        NSRectFill(dirtyRect)
    }
}
