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

class WindowController: NSWindowController, NSSearchFieldDelegate {

    @IBOutlet var segmentedControl:NSSegmentedControl!
    @IBOutlet var searchField:NSSearchField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    //MARK: - NSSearchFieldDelegate
    
    override func controlTextDidChange(notification: NSNotification) {
        if let sender = notification.object as? NSSearchField where sender == self.searchField {
//            let suggestions = SearchEngine.sharedInstance().suggestionsForString(self.searchField.stringValue)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func searchAction(sender: NSSearchField) {
        let mainVC = self.contentViewController as! MainViewController
        mainVC.searchSamplesForString(sender.stringValue)
    }
}
