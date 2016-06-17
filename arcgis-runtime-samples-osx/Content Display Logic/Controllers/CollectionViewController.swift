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

class CollectionViewItem: NSCollectionViewItem {
 
    @IBOutlet var titleTextField: NSTextField!
    @IBOutlet var descriptionTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
}

protocol CollectionViewControllerDelegate: class {
    
    func collectionViewController(collectionViewController:CollectionViewController, didSelectSampleNode node:Node)
}

class CollectionViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {

    @IBOutlet var collectionView:NSCollectionView!
    
    weak var delegate:CollectionViewControllerDelegate?
    
    var sampleNodes: [Node]! {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    //MARK: - NSCollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sampleNodes?.count ?? 0
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        
        let sampleNode = self.sampleNodes[indexPath.item]
        
        let viewItem = collectionView.makeItemWithIdentifier("CollectionViewItem", forIndexPath: indexPath) as! CollectionViewItem
        viewItem.titleTextField.stringValue = sampleNode.displayName
        viewItem.descriptionTextField.stringValue = sampleNode.descriptionText
        
        //stylize
        viewItem.view.wantsLayer = true
        viewItem.view.layer?.borderColor = NSColor.blackColor().CGColor
        viewItem.view.layer?.borderWidth = 1
        
        return viewItem
    }
    
    //MARK: - NSCollectionViewDelegate
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        self.delegate?.collectionViewController(self, didSelectSampleNode: self.sampleNodes[indexPaths.first!.item])
    }
}
