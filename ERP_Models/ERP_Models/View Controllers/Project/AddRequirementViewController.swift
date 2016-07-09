//
//  AddRequirementViewController.swift
//  ERP_Models
//
//  Created by Amir on 4/18/1395 AP.
//  Copyright © 1395 AP Hossein Azizi. All rights reserved.
//

import Cocoa

class AddRequirementViewController: NSViewController {
    
    @IBOutlet weak var resourceListButton: NSPopUpButton!
    @IBOutlet weak var selectedProjectHierarchyLabel: NSTextField!
    
    @IBOutlet weak var estimatedTime: NSTextField!
    @IBOutlet weak var numberOfRequirement: NSTextField!
    
    private var resources : Array<Resource>
        {
        get{
            return ResourceCatalog.getInstance().getAllResources()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (ProjectViewController.selectedItem != nil){
            selectedProjectHierarchyLabel.stringValue = (ProjectViewController.selectedItem?.projectName)! as String
            for res in resources{
                resourceListButton.addItemWithTitle(res.name as String)
            }
            
        }
        
        // Do view setup here.
    }
    
    @IBAction func addRequirement(sender: AnyObject) {
        let res = ResourceCatalog.getInstance().findResource(Resource.self, name: resourceListButton.selectedItem?.title)[0]
        let numberOfReq = numberOfRequirement.integerValue
        let estimated = estimatedTime.integerValue
        
        var selectedProjectHierarchy: Project? = nil
        if (ProjectViewController.selectedSubSystemItem != nil)
        {
            selectedProjectHierarchy = ProjectViewController.selectedSubSystemItem!
        }
        else if (ProjectViewController.selectedSystemItem != nil)
        {
            selectedProjectHierarchy = ProjectViewController.selectedSystemItem!
        }
        else if (ProjectViewController.selectedItem != nil)
        {
            selectedProjectHierarchy = ProjectViewController.selectedItem!
        }
        selectedProjectHierarchy?.createRequirement(forResource: res, withAmount: numberOfReq, estimatedToBeUsed: estimated, entity: nil)
        
        dismissViewController(self)
    }
    
}
