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

protocol SaveMapVCDelegate:class {
    
    func saveMapViewController(saveMapViewController:SaveMapViewController, didInitiateSaveWithTitle title:String, tags:[String], itemDescription:String?)
    
    func saveMapViewControllerDidCancel(saveAsViewController:SaveMapViewController)
}

class SaveMapViewController: NSViewController {

    @IBOutlet  weak var titleTextField:NSTextField!
    @IBOutlet private weak var tagsTextField:NSTextField!
    @IBOutlet private weak var descriptionTextField:NSTextField!
    
    weak var delegate:SaveMapVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func resetInputFields() {
        self.titleTextField.stringValue = ""
        self.tagsTextField.stringValue = ""
        self.descriptionTextField.stringValue = ""
    }
    
    @IBAction private func cancelAction(sender: AnyObject) {
        
        self.delegate?.saveMapViewControllerDidCancel(self)
    }
    
    @IBAction private func saveAction(sender: AnyObject) {
        //Validations
        let title = titleTextField.stringValue
        let tags = tagsTextField.stringValue
        let itemDescription = descriptionTextField.stringValue
        
        if title.isEmpty || tags.isEmpty || itemDescription.isEmpty {
            //show alert
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = "Title, tags and description are required fields"
            alert.addButtonWithTitle("OK")
            alert.beginSheetModalForWindow(self.view.window!, completionHandler: nil)
            return
        }
        
        var tagsArray = tags.componentsSeparatedByString(",")
        
        tagsArray = tagsArray.map ({
            $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        })
        
        self.delegate?.saveMapViewController(self, didInitiateSaveWithTitle: title, tags: tagsArray, itemDescription: itemDescription)
    }
}
